# install.md

# SpaghettiChef Angular Test Project Setup on Windows

## 1. Goal

initialise a angular project on windows when no repository to be cloned

---

## 2. Required Versions


see install.md to install prerequise

- Node.js 22 LTS
- npm included with Node.js
- Angular CLI 19
- Angular project 19
--

## 3.  repository for our spaghettichef-angular console project

```powershell
cd  C:\Users\natha\wintooling\spaghettichef-angular
```


---

## 4. Create Angular Project

```powershell
cd  C:\Users\natha\wintooling\spaghettichef-angular
ng new spangular
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

## 5. Enter Project

```powershell
cd C:\Users\natha\wintooling\spaghettichef-angular\spangular
```

---

## 6. Test Build

```powershell
ng build
```

Expected:

```text
Application bundle generation complete
```

---

## 7. Start Angular Development Server

```powershell
ng serve
```

Open:

```text
http://localhost:4200
```

You should see the Angular starter page.

---
