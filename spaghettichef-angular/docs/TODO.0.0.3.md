# Version 0.0.3 — Runnable Windows Installer

## Status

PLANNED

## Context

Version 0.0.1 creates production ZIP/TAR packages from compiled Angular static files.

Version 0.0.2 creates a Windows `.exe` installer from Linux Jenkins using Docker + Wine + Inno Setup.

Version 0.0.2 proves that Jenkins can produce a Windows installer, but the installed Angular application still needs a clear runtime/start mechanism.

## Goal

Create a Windows installer that installs a runnable Angular console.

After installation, the user must be able to start the application from the Start Menu without cloning the repository, running Angular CLI, running `npm install`, or running `ng serve`.

## Product Behavior

The installed application should provide:

```text
Start Menu shortcut:
    SpaghettiChef Angular Console

When clicked:
    start a local static web server
    serve the compiled Angular production files
    open the browser automatically
```

Target URL:

```text
http://127.0.0.1:4200
```

or another documented local port if 4200 is changed.

## Preferred Runtime Strategy

Bundle a small static web server executable with the installer.

The final user must not need:

```text
Node.js
npm
Angular CLI
source code
manual build commands
```

## Deliverables

```text
runtime/windows/
    small static server executable or documented bundled server

scripts/windows/
    start-spaghettichef-angular.bat
    stop-spaghettichef-angular.bat

installer/spaghettichef-angular.iss
    updated to install runtime files
    updated to create Start Menu shortcut to start script
    optional Desktop shortcut

spaghettichef-angular/docs/windows-runtime.md
    explains installed runtime behavior
    explains how to start
    explains how to stop
    explains local port
    explains dependency-free user installation

Jenkinsfile
    updated to package runtime files into installer
    updated to archive final installer
```

## Installed Directory Structure

Expected installed layout:

```text
{app}
├── public/
│   └── compiled Angular production files
├── runtime/
│   └── static server executable
├── scripts/
│   ├── start-spaghettichef-angular.bat
│   └── stop-spaghettichef-angular.bat
├── docs/
│   └── windows-runtime.md
└── README.md
```

## Start Script Behavior

The start script should:

```text
1. Resolve the installation directory.
2. Start the bundled static server.
3. Serve the public directory.
4. Use a fixed local port.
5. Open the default browser.
6. Avoid starting duplicate server instances when possible.
```

## Stop Script Behavior

The stop script should:

```text
1. Stop the local static server started for SpaghettiChef Angular Console.
2. Avoid killing unrelated user processes.
3. Print a clear result message.
```

## Installer Behavior

The Inno Setup installer should:

```text
install compiled Angular files
install the bundled runtime
install start/stop scripts
create Start Menu shortcut
optionally create Desktop shortcut
create uninstaller
```

## Jenkins Build Flow

```text
Checkout source
npm ci
npm run build -- --configuration production
Prepare package/windows/spaghettichef-angular/public
Copy bundled runtime into package/windows/spaghettichef-angular/runtime
Copy start/stop scripts into package/windows/spaghettichef-angular/scripts
Copy docs
Run Inno Setup compiler through Docker/Wine
Create SpaghettiChefAngularSetup-0.0.3.exe
Generate SHA256SUMS.txt
Archive installer artifact
Optionally publish installer to GitHub Release
```

## Not In Scope

```text
No Windows scheduled task
No auto-start on boot
No Windows service
No Electron
No Tauri
No authentication
No SpaghettiChef backend installation
No SpaghettiChef backend startup
```

## Explicit Anti-Scope

The final installed user must not be asked to run:

```text
npm install
npm run build
ng serve
```

The installer must not only copy static files without a start mechanism.

## Acceptance Criteria

```text
Jenkins creates SpaghettiChefAngularSetup-0.0.3.exe.

A clean Windows machine can install the .exe.

After installation, the Start Menu shortcut exists.

Clicking the shortcut starts the local static server.

The browser opens the Angular console.

The Angular console loads from compiled production files.

The user does not need Node.js, npm, or Angular CLI.

Uninstall removes installed files and shortcuts.
```
