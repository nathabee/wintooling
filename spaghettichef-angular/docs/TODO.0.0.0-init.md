# Version 0.0.0 — project initialisation

## Status

DONE


## Scope

Create a small Angular standalone application named spangular.

Use routing with three pages: Dashboard, Printers, Settings.

Use HttpClient to call:
- GET http://localhost:18080/monitoring
- GET http://localhost:18080/printers
- GET http://localhost:18080/settings/monitoring

Create typed TypeScript interfaces for the API responses.

Create a left sidebar navigation.

Keep the app simple, readable, and beginner-friendly.

No authentication.
No Django backend.
No write actions.
No POST/PUT/DELETE.
Read-only frontend only.

Jenkins will produce a developer/source release. It requires:

```text
npm install
npm run build
npm start
```

So it is not a product release.
