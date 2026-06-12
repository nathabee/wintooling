# Inno Setup GUI Quick Guide

## Purpose

Inno Setup creates a Windows installer:

```text
MyApplicationSetup.exe
```

The installer copies files, creates shortcuts, and provides an uninstaller.

---

# Installation

Install:

```text
Inno Setup Compiler
```

After installation:

```text
Start Menu
    →
Inno Setup Compiler
```

---

# Typical Workflow

```text
Build application
    →
Prepare release folder
    →
Create/Open .iss file
    →
Compile
    →
Setup.exe generated
```

Inno Setup packages files.

It does not compile Angular, Java, C#, Python, etc.

---

# Create A New Installer

Open:

```text
Inno Setup Compiler
```

Choose:

```text
File
    →
New
```

The wizard starts.

---

# Wizard Information

## Application Information

Example:

```text
Application name:
SpaghettiChef Angular

Application version:
0.0.3

Publisher:
Nathabee
```

---

## Application Folder

Example:

```text
Default directory:

{autopf}\SpaghettiChef Angular
```

Usually:

```text
C:\Program Files\SpaghettiChef Angular
```

---

## Application Files

Select the files to install.

Example:

```text
public\
runtime\
scripts\
README.md
```

Important:

Use production files.

Do not install:

```text
node_modules
.angular
src
.git
```

unless intentionally distributing source code.

---

## Shortcuts

Example:

```text
Start Menu:
SpaghettiChef Angular

Desktop Shortcut:
optional
```

---

## Output

Example:

```text
Output folder:
output

Output filename:
SpaghettiChefAngularSetup
```

Generated file:

```text
output\
    SpaghettiChefAngularSetup.exe
```

---

# Generated Script

The wizard creates:

```text
spaghettichef-angular.iss
```

Store it in Git:

```text
installer\
    spaghettichef-angular.iss
```

Do not recreate it for every release.

Reuse it.

---

# Compile

Open:

```text
installer\spaghettichef-angular.iss
```

Then:

```text
Build
    →
Compile
```

or:

```text
F9
```

Result:

```text
Setup.exe
```

appears in the output folder.

---

# Existing Project Workflow

Most companies already have:

```text
installer\
    my-project.iss
```

In that case:

```text
Open .iss
Check version
Compile
```

No wizard required.

---

# Relationship With Jenkins

Manual:

```text
Open .iss
Compile
```

Automated:

```text
Jenkins
    →
ISCC.exe project.iss
```

Both use the same .iss file.

The GUI and CLI compile the same installer definition.

---

# Things To Check Before Compiling

Verify:

```text
Version number
Source files exist
Output directory exists
Application name is correct
Installer icon is correct
```

Then compile.

---

# Common Beginner Mistake

Wrong:

```text
Package source code
Package node_modules
Package development files
```

Correct:

```text
Package release files
Package compiled output
Package runtime files
Package documentation
```

Think:

```text
Angular build
    →
dist
    →
Inno Setup
    →
Setup.exe
```

not:

```text
Angular source
    →
Setup.exe
```
