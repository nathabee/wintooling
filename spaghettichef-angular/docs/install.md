# SpaghettiChef Angular Install Guide

This guide explains three install modes:

1. Windows release zip
2. Linux release tar.gz
3. Developer clone from GitHub

The Angular app is a read-only frontend. It calls the SpaghettiChef REST API
directly from the browser.

The Angular project is in:

```text
spaghettichef-angular/spangular
```

## Requirements

Install these first:

- Node.js 22 LTS
- npm, included with Node.js
- Git, only needed for developer clone mode
- VS Code, optional but recommended for development

After installing Node.js, close PowerShell or your terminal and open a new one.

Check:

```powershell
node --version
npm --version
```

Expected examples:

```text
v22.x.x
10.x.x
```

The project uses the local Angular CLI from `node_modules`, so a global Angular
CLI install is not required for release installs.

On Windows, if PowerShell blocks `npm` because of `npm.ps1`, use `npm.cmd` in
commands, or allow local scripts for your user:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## Configure The API URL

The API URL is configured in:

```text
spangular/.env
```

Create it from the example:

```text
spangular/.env.example
```

Example when SpaghettiChef runs on another machine in the same LAN:

```text
SPAGHETTICHEF_API_BASE_URL=http://192.168.178.39:18080
```

If your SpaghettiChef API uses another address, change only this value.

Do not commit `.env`. It is local machine configuration.

When `npm start`, `npm run build`, or `npm run watch` runs, the project generates:

```text
spangular/src/environments/environment.ts
```

Angular reads that generated file at build time.

The browser calls the API URL directly. If the Angular page loads but API data
does not, check that SpaghettiChef allows CORS for the Angular origin, usually:

```text
http://127.0.0.1:4200
```

You can test the API with:

```powershell
curl http://192.168.178.39:18080/health
```

Use your own API address if it is different.

## Mode 1: Windows Release Zip

Download the Windows release asset from GitHub Releases:

```text
spaghettichef-angular-<release-name>-windows.zip
```

Extract it:

```powershell
cd C:\Users\natha
Expand-Archive .\Downloads\spaghettichef-angular-<release-name>-windows.zip -DestinationPath .
cd C:\Users\natha\spaghettichef-angular\spangular
```

Create and edit `.env`:

```powershell
copy .env.example .env
notepad .env
```

Install dependencies:

```powershell
npm.cmd install
```

Build:

```powershell
npm.cmd run build
```

Start the Angular development server:

```powershell
npm.cmd start
```

Open:

```text
http://127.0.0.1:4200
```

## Mode 2: Linux Release Tarball

Download the Linux release asset from GitHub Releases:

```text
spaghettichef-angular-<release-name>-linux.tar.gz
```

Extract it:

```bash
cd "$HOME"
tar -xzf ~/Downloads/spaghettichef-angular-<release-name>-linux.tar.gz
cd "$HOME/spaghettichef-angular/spangular"
```

Create and edit `.env`:

```bash
cp .env.example .env
nano .env
```

Install dependencies:

```bash
npm install
```

Build:

```bash
npm run build
```

Start the Angular development server:

```bash
npm start -- --host 127.0.0.1 --port 4200
```

Open:

```text
http://127.0.0.1:4200
```

If you want to open the Angular app from another machine in the LAN, start it
with:

```bash
npm start -- --host 0.0.0.0 --port 4200
```

Then open:

```text
http://<linux-machine-ip>:4200
```

## Mode 3: Developer Clone From GitHub

Use this mode when you want to edit the code.

Clone the repository:

```powershell
cd C:\Users\natha
git clone https://github.com/nathabee/wintooling.git
cd C:\Users\natha\wintooling
```

Enter the Angular project:

```powershell
cd C:\Users\natha\wintooling\spaghettichef-angular\spangular
```

Install dependencies:

```powershell
npm.cmd install
```

Create and edit `.env`:

```powershell
copy .env.example .env
notepad .env
```

Build:

```powershell
npm.cmd run build
```

Start:

```powershell
npm.cmd start
```

Open:

```text
http://127.0.0.1:4200
```

Open the project in VS Code:

```powershell
code .
```

## Routes

```text
/dashboard
/printers
/settings
```

## API Calls

The frontend uses only read-only API calls:

- `GET /monitoring`
- `GET /printers`
- `GET /settings/monitoring`

It does not include Django, authentication, backend code, or write operations.
