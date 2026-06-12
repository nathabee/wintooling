# Roadmap

## Goal

Small Angular frontend to test:

```text
VS Code Angular Language Service
Angular routing
HttpClient
components
interfaces
template binding
Codex workflow
```

### Pages

```text
/dashboard
/printers
/settings
```

### API used

```text
GET /monitoring
GET /printers
GET /settings/monitoring
```

### Layout

```text
App shell
├── left sidebar
├── top title bar
└── routed content area
```

### Dashboard page

Uses:

```text
GET http://localhost:18080/monitoring
```

Display:

```text
total printers
enabled printers
busy printers
error printers
active jobs
active uploads
printer state list
```

### Printers page

Uses:

```text
GET http://localhost:18080/printers
```

Display:

```text
printer id
display name
mode
enabled
state
hotend temperature
bed temperature
last response
error message
```

### Settings page

Uses:

```text
GET http://localhost:18080/settings/monitoring
```

Display read-only:

```text
poll interval
snapshot minimum interval
temperature delta threshold
event deduplication window
error persistence behavior
debug wire tracing enabled
```

---

## Version

### 0.0.0 First Angular App,  Developer Release

- init angular project with dashboard + routing + rest API
- Jenkins create Release Zip
- Zip are for developper and will be installed on Windows or Linux
- release zip are stored in github release

After installing the release, the user will have to do :
npm install
npm run build
npm start

Jenkins packages the Angular source tree for Windows and Linux. The user still has to run npm install, build, and start manually.

## 0.0.1 — Production Static Package

Jenkins builds Angular in production mode and packages only the compiled browser output plus documentation and configuration examples.

The release user must not run npm install, ng build, or ng serve.

Artifacts:

- spaghettichef-angular-0.0.1-windows-production.zip
- spaghettichef-angular-0.0.1-linux-production.tar.gz
- SHA256SUMS.txt

## 0.0.2 — Windows Installer

Use Inno Setup Compiler to create a Windows .exe installer from the 0.0.1 production package.

## 0.0.3 — Linux Install Package

Provide a Linux installable package or install script for serving the Angular static files with a standard web server.

