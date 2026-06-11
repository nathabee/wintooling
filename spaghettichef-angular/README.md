# SpaghettiChef Angular Console

## Purpose

This repository contains a small Angular frontend used to learn and experiment with Angular development against the SpaghettiChef REST API.

The project is intentionally simple.

Goals:

* Learn Angular 19
* Learn Angular routing
* Learn Angular services and HttpClient
* Learn Angular standalone components
* Learn Angular Language Service in VS Code
* Experiment with Codex-assisted Angular development
* Consume a REST API from Angular

This project is not intended to become a production dashboard.

---

## Relationship To SpaghettiChef

SpaghettiChef is the backend application.

This Angular project acts only as a frontend client.

```text
+----------------------+
|      Angular UI      |
|      spangular       |
+----------+-----------+
           |
           | REST API
           v
+----------------------+
|    SpaghettiChef     |
|      localhost       |
|        18080         |
+----------------------+
```

The Angular application never accesses files directly.

All data comes from the REST API.

---

## Current Scope

Version 0.1.x is intentionally limited.

Read-only application.

Supported pages:

```text
/dashboard
/printers
/settings
```

Supported API endpoints:

```text
GET /monitoring
GET /printers
GET /settings/monitoring
```

No write operations.

No authentication.

No user management.

No printer control.

No job management.

No camera administration.

---

## Dashboard Page

The dashboard page displays the global monitoring state.

Information shown:

```text
total printers
enabled printers
disabled printers
busy printers
error printers
active jobs
active uploads
```

The dashboard may also display a simplified printer summary.

---

## Printers Page

The printers page displays registered printers.

Information shown:

```text
printer id
display name
connection mode
enabled state
printer state
hotend temperature
bed temperature
last response
error message
last update timestamp
```

---

## Settings Page

The settings page displays monitoring settings.

Information shown:

```text
poll interval
snapshot interval
temperature threshold
event deduplication window
error persistence behavior
debug tracing flag
```

The page is read-only.

---

## Technical Guidelines

Use:

```text
Angular 19
Angular CLI 19
TypeScript
HttpClient
Standalone Components
Angular Router
```

Avoid:

```text
NgRx
Authentication
State management frameworks
Backend code
Django
Complex UI frameworks
```

Keep the code easy to understand for Angular beginners.

---

## Initial Architecture

```text
src/
|
+-- app/
    |
    +-- pages/
    |    |
    |    +-- dashboard/
    |    +-- printers/
    |    +-- settings/
    |
    +-- services/
    |    |
    |    +-- spaghettichef-api.service.ts
    |
    +-- models/
    |    |
    |    +-- monitoring.model.ts
    |    +-- printer.model.ts
    |    +-- settings.model.ts
    |
    +-- app.routes.ts
```

---

## API Base URL

Initial development URL:

```text
http://localhost:18080
```

The value may later be moved to Angular environment configuration.

---

## Coding Principles

Prefer:

```text
simple
explicit
typed
readable
maintainable
```

Avoid:

```text
premature optimization
unnecessary abstraction
unused dependencies
complex architecture
```

The project exists primarily as an Angular learning and experimentation environment.
