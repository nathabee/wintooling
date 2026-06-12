# Windows Runtime

Version 0.0.3 installs a runnable SpaghettiChef Angular Console.

The installed user does not need:

```text
Node.js
npm
Angular CLI
source code
manual build commands
```

## Start

Use the Start Menu shortcut:

```text
SpaghettiChef Angular Console
```

The shortcut runs:

```text
scripts\windows\start-spaghettichef-angular.bat
```

The script starts the bundled PowerShell static server, serves the compiled
Angular files from `public`, and opens the browser at:

```text
http://127.0.0.1:4200/
```

If the server is already running, the script reuses it and only opens the
browser.

## Stop

Use the Start Menu shortcut:

```text
Stop SpaghettiChef Angular Console
```

The stop script reads the runtime pid file and only stops the PowerShell process
that was started with the bundled `static-server.ps1` script.

## Installed Layout

```text
SpaghettiChef Angular\
|-- public\
|-- runtime\
|   `-- windows\
|       `-- static-server.ps1
|-- scripts\
|   `-- windows\
|       |-- start-spaghettichef-angular.bat
|       `-- stop-spaghettichef-angular.bat
|-- docs\
|   `-- windows-runtime.md
`-- README.md
```

## Port

The runtime uses:

```text
127.0.0.1:4200
```

The server binds only to localhost.
