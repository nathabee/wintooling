### Goal

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
 