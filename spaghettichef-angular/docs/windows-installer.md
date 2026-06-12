# Windows Installer

Version 0.0.2 builds a Windows `.exe` installer from the compiled Angular
production package created by the Jenkins release job.

The Jenkins agent stays on Linux. It uses Docker, Wine, and Inno Setup Compiler
to produce:

```text
SpaghettiChefAngularSetup-0.0.2.exe
```

## Jenkins Flow

```text
checkout
npm ci
npm run build -- --configuration production
prepare package/windows/spaghettichef-angular
build docker/inno-setup image
run Inno Setup compiler in Docker
write SHA256SUMS.txt
archive dist/*
optionally publish dist/* to GitHub Releases
```

The final user does not need Node.js, npm, Angular CLI, or the source
repository.

## Local Linux Build

From the repository root, after preparing `package/windows`:

```sh
docker build -t spaghettichef-inno-setup:local docker/inno-setup

docker run --rm \
  -v "$PWD:/work" \
  spaghettichef-inno-setup:local \
  /DAppVersion=0.0.2 \
  /DSourceDir=package/windows/spaghettichef-angular \
  /DOutputDir=dist \
  installer/spaghettichef-angular.iss
```

## Installed Files

The installer copies the production package under:

```text
C:\Program Files\SpaghettiChef Angular
```

Installed layout:

```text
SpaghettiChef Angular\
|-- public\
|-- docs\
|-- config\
`-- README.md
```

The installer also creates Start Menu shortcuts to the Angular static entry
point and the README.
