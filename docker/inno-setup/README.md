# Inno Setup Compiler Container

This directory contains the Docker image used by Linux Jenkins to build the
Windows installer without a Windows agent.

Build the image:

```sh
docker build -t spaghettichef-inno-setup:local docker/inno-setup
```

Run the compiler from the repository root after `package/windows` has been
prepared:

```sh
docker run --rm \
  -v "$PWD:/work" \
  spaghettichef-inno-setup:local \
  /DAppVersion=0.0.2 \
  /DSourceDir=package/windows/spaghettichef-angular \
  /DOutputDir=dist \
  installer/spaghettichef-angular.iss
```

The output file is:

```text
dist/SpaghettiChefAngularSetup-0.0.2.exe
```

Jenkins builds this image locally so the release job is not tied to a public
third-party Inno Setup image.
