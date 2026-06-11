# install.md

# SpaghettiChef Angular Test Project Setup on Windows

## 1. Goal

Create a small Angular 19 project on Windows to test:

- VS Code
- Angular Language Service 19.2.0
- Angular routing
- Angular components
- HttpClient
- Codex-assisted development

Project name:

spaghettichef-console-angular

This project will directly call the local SpaghettiChef API.

No Django backend is used for this first Angular test.

---

## 2. Required Versions

Because VS Code has Angular Language Service 19.2.0 installed, use Angular 19.

Recommended setup:

- Node.js 22 LTS
- npm included with Node.js
- Angular CLI 19
- Angular project 19

Angular 19 supports Node.js versions `^18.19.1`, `^20.11.1`, or `^22.0.0`. Use Node.js 22 LTS to stay clean. :contentReference[oaicite:0]{index=0}

The Angular Language Service extension provides Angular template completions, diagnostics, quick info, and navigation. It does not install Angular or Node.js. :contentReference[oaicite:1]{index=1}

---

## 3. Install Node.js on Windows

Download Node.js from the official Node.js website:

https://nodejs.org

Choose:

Node.js 22 LTS Windows Installer

During installation:

- keep default options
- allow Node.js to be added to PATH
- install npm with Node.js

After installation, close PowerShell completely and open a new PowerShell window.

Check:

```powershell
node --version
npm --version
````

Expected example:

```text
v22.x.x
10.x.x
```

---

## 4. Install Angular CLI 19

In PowerShell:

```powershell
npm install -g @angular/cli@19
```

Verify:

```powershell
ng version
```

Expected:

```text
Angular CLI: 19.x.x
Node: 22.x.x
Package Manager: npm
```

---

## 5. Create Project Folder

```powershell
mkdir C:\coding
mkdir C:\coding\angular
cd C:\coding\angular
```

---

## 6. Create Angular Project

```powershell
ng new spaghettichef-console-angular
```

When asked:

```text
Which stylesheet format would you like to use?
SCSS

Do you want to enable Server-Side Rendering and Static Site Generation?
No
```

If Angular asks about routing:

```text
Yes
```

---

## 7. Enter Project

```powershell
cd C:\coding\angular\spaghettichef-console-angular
```

---

## 8. Test Build

```powershell
ng build
```

Expected:

```text
Application bundle generation complete
```

---

## 9. Start Angular Development Server

```powershell
ng serve
```

Open:

```text
http://localhost:4200
```

You should see the Angular starter page.

---

## 10. Open Project in VS Code

From the project folder:

```powershell
code .
```

The Angular Language Service extension should now become useful.

It helps with:

* `.html` template autocomplete
* component property checking
* binding errors
* navigation between template and TypeScript
* Angular diagnostics

---

## 11. Check SpaghettiChef API

In another PowerShell window:

```powershell
curl http://localhost:18080/health
```

Expected:

```json
{
  "status": "ok"
}
```

If this works, Angular can later call SpaghettiChef.

---

## 12. Project Scope for Codex Later

Codex should create a read-only Angular frontend with:

Routes:

* `/dashboard`
* `/printers`
* `/settings`

API calls:

* `GET http://localhost:18080/monitoring`
* `GET http://localhost:18080/printers`
* `GET http://localhost:18080/settings/monitoring`

see : docs/RELATED/api-contract.md (READ ONLY)

Rules:

* no Django
* no backend
* no authentication
* no write actions
* no POST
* no PUT
* no DELETE
* read-only frontend only

 
