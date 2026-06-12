# WinTooling

Windows tooling and development workbench.

Purpose:

* Learn Windows development tooling
* Test VS Code extensions
* Learn Git and GitLens workflows
* Explore Codex-assisted development
* Experiment with Angular
* Build Windows installers with Inno Setup
* Automate releases with Jenkins on Linux

## Repository Structure

```text
wintooling/
├── docs/
├── spaghettichef-angular/
├── installer/
├── docker/
├── runtime/
├── scripts/
├── tools/
└── Jenkinsfile
```

## Documentation

```text
docs/init-windows.md
```

Windows setup and installation notes.

```text
docs/git.md
docs/git-panel.md
docs/git-branch.md
```

Git workflow and VS Code integration.

```text
docs/test-git-lens-*.md
```

GitLens exploration and workflow tests.

```text
docs/powershell.md
```

Useful PowerShell commands.

## Tools Under Evaluation

```text
Git
GitLens
Codex
Angular Language Service
PowerShell
Docker
Jenkins
Inno Setup
```

## Angular Test Project

```text
spaghettichef-angular/
```

Angular learning project used to experiment with:

```text
Angular 19
Routing
HttpClient
VS Code
Codex
Jenkins packaging
Inno Setup installers
```

See:

```text
spaghettichef-angular/README.md
```

for project details.

## CI/CD

```text
Jenkins runs on Linux.
```

Current goals:

```text
Build Angular
Create release packages
Generate Windows installers
Publish GitHub releases
```
