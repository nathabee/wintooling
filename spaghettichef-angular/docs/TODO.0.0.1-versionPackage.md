
# Version 0.0.1 — production package release

## Status

DONE

## Goal

```text
Version management
Jenkins builds Angular once.
Release contains already-built production files.
User does not run npm install.
User does not run ng build.
User does not run ng serve.
```

## 0.0.1 Scope

Version management: 
during precommit version should align json with the reference VERSION file
- update the /VERSION file to 0.0.1
- use version replacement in the JSON files
create/adapt the version tools :
- /tools/check-version.sh
- /tools/sync-version.sh
- /tools/git-hooks/pre-commit


Artifacts:

```text
spaghettichef-angular-0.0.1-windows-production.zip
spaghettichef-angular-0.0.1-linux-production.tar.gz
SHA256SUMS.txt
```

Inside the package:

```text
spaghettichef-angular/
├── public/
│   └── compiled Angular production files from dist/spangular/browser
├── docs/
│   ├── install-windows.md
│   ├── install-linux.md
│   └── api-contract.md
├── config/
│   └── app-config.example.json
└── README.md
```

VERSION file must be handled

### Important rule

0.0.1 must package:

```text
npm run build output
```

not:

```text
Angular source code
node_modules
package.json as required runtime
ng serve
```

### What Jenkins must do

```text
use VERSION file if no user overwrite
checkout
npm ci
npm run build
copy dist/spangular/browser to package/.../public
copy docs
copy README
create windows zip
create linux tar.gz
create SHA256SUMS
archive artifacts
optional publish GitHub Release
```

### What 0.0.1 does not do yet

```text
No Inno Setup .exe
No Windows Start Menu shortcut
No Linux systemd service
No embedded web server
No auto-start
No installer UI
```

That is for the next version.
 
