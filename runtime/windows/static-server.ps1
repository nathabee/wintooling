param(
    [Parameter(Mandatory = $true)]
    [string]$Root,

    [int]$Port = 4200,

    [string]$PidFile = ""
)

$ErrorActionPreference = "Stop"

$resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
$resolvedRootPrefix = $resolvedRoot.TrimEnd("\", "/") + [System.IO.Path]::DirectorySeparatorChar
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)

$mimeTypes = @{
    ".css" = "text/css"
    ".html" = "text/html"
    ".ico" = "image/x-icon"
    ".js" = "application/javascript"
    ".json" = "application/json"
    ".map" = "application/json"
    ".png" = "image/png"
    ".svg" = "image/svg+xml"
    ".txt" = "text/plain"
    ".webp" = "image/webp"
}

function Resolve-StaticPath {
    param([string]$RequestPath)

    $relativePath = [Uri]::UnescapeDataString($RequestPath.TrimStart("/"))

    if ([string]::IsNullOrWhiteSpace($relativePath)) {
        $relativePath = "index.html"
    }

    $candidate = Join-Path $resolvedRoot $relativePath

    if (Test-Path -LiteralPath $candidate -PathType Container) {
        $candidate = Join-Path $candidate "index.html"
    }

    if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
        $candidate = Join-Path $resolvedRoot "index.html"
    }

    $resolvedCandidate = (Resolve-Path -LiteralPath $candidate).Path
    $isRootFile = $resolvedCandidate.Equals($resolvedRoot, [System.StringComparison]::OrdinalIgnoreCase)
    $isRootChild = $resolvedCandidate.StartsWith($resolvedRootPrefix, [System.StringComparison]::OrdinalIgnoreCase)
    if (-not ($isRootFile -or $isRootChild)) {
        throw "Requested path escapes the public directory."
    }

    return $resolvedCandidate
}

function Send-Response {
    param(
        [System.IO.Stream]$Stream,
        [int]$StatusCode,
        [string]$StatusText,
        [string]$ContentType,
        [byte[]]$Body
    )

    $headers = @(
        "HTTP/1.1 $StatusCode $StatusText",
        "Content-Type: $ContentType",
        "Content-Length: $($Body.Length)",
        "Connection: close",
        "",
        ""
    ) -join "`r`n"

    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($headers)
    $Stream.Write($headerBytes, 0, $headerBytes.Length)
    $Stream.Write($Body, 0, $Body.Length)
}

try {
    if ($PidFile) {
        $pidDirectory = Split-Path -Parent $PidFile
        if ($pidDirectory -and -not (Test-Path -LiteralPath $pidDirectory)) {
            New-Item -ItemType Directory -Path $pidDirectory | Out-Null
        }
        [System.IO.File]::WriteAllText($PidFile, "$PID")
    }

    $listener.Start()
    Write-Host "Serving $resolvedRoot at http://127.0.0.1:$Port/"

    while ($true) {
        $client = $listener.AcceptTcpClient()
        $reader = $null
        $stream = $null

        try {
            $stream = $client.GetStream()
            $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::ASCII, $false, 1024, $true)
            $requestLine = $reader.ReadLine()

            while ($reader.ReadLine()) {
                continue
            }

            if (-not $requestLine) {
                continue
            }

            $parts = $requestLine.Split(" ")
            if ($parts.Length -lt 2 -or $parts[0] -ne "GET") {
                $body = [System.Text.Encoding]::UTF8.GetBytes("Method not allowed")
                Send-Response -Stream $stream -StatusCode 405 -StatusText "Method Not Allowed" -ContentType "text/plain" -Body $body
                continue
            }

            $requestPath = $parts[1].Split("?")[0]
            $path = Resolve-StaticPath -RequestPath $requestPath
            $body = [System.IO.File]::ReadAllBytes($path)
            $extension = [System.IO.Path]::GetExtension($path).ToLowerInvariant()
            $contentType = $mimeTypes[$extension]
            if (-not $contentType) {
                $contentType = "application/octet-stream"
            }

            Send-Response -Stream $stream -StatusCode 200 -StatusText "OK" -ContentType $contentType -Body $body
        }
        catch {
            if ($stream) {
                $body = [System.Text.Encoding]::UTF8.GetBytes("Not found")
                Send-Response -Stream $stream -StatusCode 404 -StatusText "Not Found" -ContentType "text/plain" -Body $body
            }
        }
        finally {
            if ($reader) {
                $reader.Dispose()
            }
            if ($client) {
                $client.Close()
            }
        }
    }
}
finally {
    $listener.Stop()

    if ($PidFile -and (Test-Path -LiteralPath $PidFile)) {
        Remove-Item -LiteralPath $PidFile -Force
    }
}
