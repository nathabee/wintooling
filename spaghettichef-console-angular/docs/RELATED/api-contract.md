# SpaghettiChef REST API Contract for Angular Test Project

Base URL:

```text
http://localhost:18080
````

Angular test project uses only read-only GET endpoints.

No authentication for this first test.

If local security is enabled later, requests may need:

```http
X-SpaghettiChef-Role: ADMIN
```

---

# 1. Dashboard Endpoint

## Request

```http
GET /monitoring
```

Full URL:

```text
http://localhost:18080/monitoring
```

## Purpose

Used by the Angular Dashboard page.

Shows the global runtime monitoring state:

* printer count
* enabled printers
* disabled printers
* busy printers
* error printers
* active jobs
* active uploads
* printer runtime list

## Response Example

```json
{
  "generatedAt": "2026-05-28T12:00:00Z",
  "summary": {
    "totalPrinters": 1,
    "enabledPrinters": 1,
    "disabledPrinters": 0,
    "busyPrinters": 0,
    "errorPrinters": 0,
    "activeJobs": 0,
    "activeUploads": 0
  },
  "printers": [
    {
      "id": "p1",
      "displayName": "Printer 1",
      "name": "Printer 1",
      "portName": "/dev/ttyUSB0",
      "mode": "serial",
      "serialPortKind": "stable-or-device-kind",
      "stableSerialPath": true,
      "serialPathWarning": null,
      "enabled": true,
      "state": "READY",
      "busy": false,
      "activeJobId": null,
      "errorMessage": null,
      "serialFailureType": null,
      "updatedAt": "2026-05-28T12:00:00Z"
    }
  ],
  "activeJobs": [],
  "activeUploads": []
}
```

## TypeScript Interface Specification

```ts
export interface MonitoringResponse {
  generatedAt: string;
  summary: MonitoringSummary;
  printers: MonitoringPrinter[];
  activeJobs: unknown[];
  activeUploads: unknown[];
}

export interface MonitoringSummary {
  totalPrinters: number;
  enabledPrinters: number;
  disabledPrinters: number;
  busyPrinters: number;
  errorPrinters: number;
  activeJobs: number;
  activeUploads: number;
}

export interface MonitoringPrinter {
  id: string;
  displayName: string;
  name: string;
  portName: string;
  mode: string;
  serialPortKind: string | null;
  stableSerialPath: boolean;
  serialPathWarning: string | null;
  enabled: boolean;
  state: string;
  busy: boolean;
  activeJobId: string | null;
  errorMessage: string | null;
  serialFailureType: string | null;
  updatedAt: string | null;
}
```

---

# 2. Printers Endpoint

## Request

```http
GET /printers
```

Full URL:

```text
http://localhost:18080/printers
```

## Purpose

Used by the Angular Printers page.

Shows all registered printers and their latest runtime state.

## Response Example

```json
{
  "printers": [
    {
      "id": "p1",
      "displayName": "Printer 1",
      "name": "Printer 1",
      "portName": "/dev/ttyUSB0",
      "mode": "serial",
      "serialPortKind": "stable-or-device-kind",
      "stableSerialPath": true,
      "serialPathWarning": null,
      "enabled": true,
      "state": "READY",
      "hotendTemperature": 205.0,
      "bedTemperature": 60.0,
      "lastResponse": "ok T:205.0 /205.0 B:60.0 /60.0",
      "errorMessage": null,
      "serialFailureType": null,
      "updatedAt": "2026-05-28T12:00:00Z"
    }
  ]
}
```

## TypeScript Interface Specification

```ts
export interface PrintersResponse {
  printers: Printer[];
}

export interface Printer {
  id: string;
  displayName: string;
  name: string;
  portName: string;
  mode: string;
  serialPortKind: string | null;
  stableSerialPath: boolean;
  serialPathWarning: string | null;
  enabled: boolean;
  state: string;
  hotendTemperature: number | null;
  bedTemperature: number | null;
  lastResponse: string | null;
  errorMessage: string | null;
  serialFailureType: string | null;
  updatedAt: string | null;
}
```

---

# 3. Monitoring Settings Endpoint

## Request

```http
GET /settings/monitoring
```

Full URL:

```text
http://localhost:18080/settings/monitoring
```

## Purpose

Used by the Angular Settings page.

Shows read-only monitoring configuration.

## Response Example

```json
{
  "pollIntervalSeconds": 5,
  "snapshotMinimumIntervalSeconds": 30,
  "temperatureDeltaThreshold": 1.0,
  "eventDeduplicationWindowSeconds": 60,
  "errorPersistenceBehavior": "DEDUPLICATED",
  "debugWireTracingEnabled": false
}
```

## TypeScript Interface Specification

```ts
export interface MonitoringSettings {
  pollIntervalSeconds: number;
  snapshotMinimumIntervalSeconds: number;
  temperatureDeltaThreshold: number;
  eventDeduplicationWindowSeconds: number;
  errorPersistenceBehavior: string;
  debugWireTracingEnabled: boolean;
}
```

---

# Angular Pages Using These Endpoints

## Dashboard Page

Endpoint:

```text
GET /monitoring
```

Display:

```text
totalPrinters
enabledPrinters
disabledPrinters
busyPrinters
errorPrinters
activeJobs
activeUploads
printer list
```

## Printers Page

Endpoint:

```text
GET /printers
```

Display:

```text
id
displayName
mode
enabled
state
hotendTemperature
bedTemperature
lastResponse
errorMessage
updatedAt
```

## Settings Page

Endpoint:

```text
GET /settings/monitoring
```

Display:

```text
pollIntervalSeconds
snapshotMinimumIntervalSeconds
temperatureDeltaThreshold
eventDeduplicationWindowSeconds
errorPersistenceBehavior
debugWireTracingEnabled
```

---

# Codex Rules

When implementing the Angular project:

```text
Use HttpClient.
Use typed interfaces.
Use Angular routing.
Use standalone components if the Angular version supports it cleanly.
Keep the UI read-only.
Do not use POST.
Do not use PUT.
Do not use DELETE.
Do not add Django.
Do not add authentication.
Use http://localhost:18080 as the first hardcoded base URL.
```
 