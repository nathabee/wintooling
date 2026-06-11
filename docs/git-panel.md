# VS Code Git Panel Quick Guide

## Open The Git Panel

In VS Code:

* Open your project folder.
* Click the **Source Control** icon on the left sidebar.
* Shortcut:

```text
Ctrl + Shift + G
```

The Git panel shows all modified files.

---

## Typical Workflow

### 1. Modify Files

Edit your files normally in VS Code.

Git automatically detects changes.

---

### 2. Review Changes

Click a changed file.

VS Code displays:

* Left side: previous version
* Right side: current version

Added lines are highlighted.

Removed lines are highlighted.

---

### 3. Stage Changes

Stage a single file:

* Hover over the file.
* Click the **+** icon.

Stage all files:

* Click the **+** next to "Changes".

Equivalent command:

```bash
git add .
```

---

### 4. Unstage Changes

In the "Staged Changes" section:

* Hover over a file.
* Click the **-** icon.

Equivalent command:

```bash
git restore --staged <file>
```

---

### 5. Commit

At the top of the Git panel:

* Enter a commit message.

Example:

```text
Add Docker configuration
```

Click:

```text
Commit
```

or press:

```text
Ctrl + Enter
```

Equivalent command:

```bash
git commit -m "Add Docker configuration"
```

---

### 6. Push To GitHub

After committing:

* Click **Sync Changes**
* Or click **Push**

Equivalent command:

```bash
git push
```

---

### 7. Pull Latest Changes

Before starting work:

* Click **Pull**

Equivalent command:

```bash
git pull
```

---

## Branch Management

Current branch is shown in the lower-left corner.

Click the branch name to:

* Switch branch
* Create branch
* Checkout branch

Equivalent commands:

```bash
git switch main
git switch feature/my-task
git switch -c feature/new-feature
```

---

## Useful Context Menu Actions

Right-click a file:

```text
Open Changes
Stage Changes
Unstage Changes
Discard Changes
Reveal In Explorer
```

Be careful with:

```text
Discard Changes
```

This permanently removes local modifications.

---

## Recommended Daily Workflow

```text
1. Open project in VS Code
2. Pull latest changes
3. Modify files
4. Review changes
5. Stage files
6. Commit
7. Push
```

For beginners, use:

```text
Git Bash = repository setup and troubleshooting
VS Code Git Panel = daily commits and pushes
GitLens = history and investigation
```
