# test-git-lens-develop-1.md

this file is created locally on the develop branch#

## scenario

we use gitlens to create a new branch develop from remote origin/main
we switch to the branch develop
we can see in the bar underneath that the selected branch is now develop
we created locally this file
we will pull and see where the push is done on the remote: is it creating a new branch develop or commiting in the main?

---

## VS Code extension workflow

```text
Commit = local only
Publish Branch / Push = send to GitHub
```

For your `develop` branch:

### 1. Confirm bottom-left branch name says

```text
develop
```

### 2. Create your new file in VS Code Explorer

### 3. Open **Source Control**

```text
Ctrl + Shift + G
```

### 4. Stage the file

```text
click + next to the file
```

### 5. Write commit message

```text
Add test file on develop
```

### 6. Click **Commit**

At this point: local `develop` has the commit, GitHub does not yet.

### 7. Click **Publish Branch**

That is the VS Code equivalent of:

```bash
git push -u origin develop
```

After that, GitHub will have a remote branch:

```text
origin/develop
```

Later, when `develop` already exists on GitHub, VS Code will show:

```text
Sync Changes
```

or:

```text
Push
```

instead of **Publish Branch**.
