# Version 0.0.2 — Windows Installer From Linux Jenkins

## Status

PLANNED

## Goal

Create a Windows `.exe` installer for the compiled Angular production package.

The Jenkins server runs on Linux, so the installer build must not require a Windows Jenkins agent.

context :
0.0.1 : Production ZIP/TAR from compiled Angular static files.
0.0.2 : Windows .exe installer built on Linux Jenkins using Docker + Wine + Inno Setup.

Jenkins run on Linux only, has docker in it



## Strategy

Use Docker + Wine + Inno Setup compiler.

Jenkins will call an Inno Setup compiler container from the Linux agent.

## Deliverables

```text
installer/spaghettichef-angular.iss
docs/windows-installer.md
docker/inno-setup/README.md
Jenkins stage: Build Windows Installer
````

## Build Flow

```text
Checkout source
npm ci
npm run build
Prepare production package
Copy Angular dist output into package/windows/spaghettichef-angular/public
Run Inno Setup compiler through Docker/Wine
Create SpaghettiChefAngularSetup-0.0.2.exe
Generate SHA256SUMS.txt
Archive installer artifact
Optionally publish installer to GitHub Release
```

## Jenkins Requirement

Linux Jenkins agent must have:

```text
Docker
permission to run docker commands
```

No Windows Jenkins agent is required.

## Installer Requirement

The final user downloads:

```text
SpaghettiChefAngularSetup-0.0.2.exe
```

The user does not clone the repository.

The user does not run npm install.

The user does not run ng build.

## Not In Scope

```text
No Windows Jenkins agent
No manual Inno Setup GUI build
No source-code-based user installation
No npm requirement for final user
```

One warning: **0.0.2 only creates the installer**. It still must install something runnable. So 0.0.1 must first define the static production package clearly. Otherwise Inno Setup will only package confusion.
