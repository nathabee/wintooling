# Git On Windows — Basic Professional Workflow

## 1. Tools On Windows

After installing Git for Windows, you usually have:

| Tool                          | Purpose                                                                      |
| ----------------------------- | ---------------------------------------------------------------------------- |
| Git Bash                      | Linux-like terminal for Git commands. Best choice if you already know Linux. |
| PowerShell / Windows Terminal | Native Windows terminal. Git commands also work here.                        |
| Git GUI                       | Simple graphical Git tool. Useful, but not the main professional workflow.   |
| VS Code Git panel             | Visual Git actions inside VS Code.                                           |
| GitLens                       | VS Code extension for Git history, blame, authorship, branches, commits.     |

Recommendation: use **Git Bash or Windows Terminal**, then open VS Code from the project folder with:

```bash
code .
```

---

## 2. Init github user


```bash
git config --global user.name "Nathalie Werner"
git config --global user.email "nathabee.de@gmail.com"
```

Check it:

```bash
git config --global --list
```



---

## 3. Clone An Existing GitHub Repository

If the repository already exists on GitHub:

```bash
git clone https://github.com/YOUR-USER/YOUR-REPO.git
cd YOUR-REPO
code .
```

For a private repository, HTTPS may ask for authentication. Prefer SSH later when configured:

```bash
git clone git@github.com:YOUR-USER/YOUR-REPO.git
```

---

## 4. Start From An Empty Local Folder


If the code starts locally first:

```bash
mkdir my-project
cd my-project
git init
code .
```

Then connect it to GitHub:

```bash
git add .
git status
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/nathabee/wintooling.git
git push -u origin main
```

If `remote origin already exists`, use:

```bash
git remote -v
git push -u origin main
```
 


 

---

## 5. Create Files

From terminal:

```bash
touch README.md
touch .gitignore
mkdir src
touch src/main.py
```

PowerShell alternative:

```powershell
New-Item README.md
New-Item .gitignore
mkdir src
New-Item src\main.py
```

Or simply create files directly in VS Code.

---

## 6. Where Code Is Started

Professional workflow:

```bash
cd /c/Users/nathalie/coding/github/YOUR-REPO
code .
```

This opens VS Code in the correct project root.

The project root is the folder containing:

```text
.git/
README.md
.gitignore
src/
```

---

## 7. Check Git Status

```bash
git status
```

This shows:

* changed files
* new untracked files
* staged files
* current branch

---

## 8. Add Files To Git Tracking

Add one file:

```bash
git add README.md
```

Add all changed files:

```bash
git add .
```

---

## 9. Stage And Unstage

Stage means: prepare changes for the next commit.

```bash
git add .
```

Unstage one file:

```bash
git restore --staged README.md
```

Unstage everything:

```bash
git restore --staged .
```

---

## 10. Commit

```bash
git commit -m "Add initial project structure"
```

Professional commit messages should be clear:

```bash
git commit -m "Add Docker setup"
git commit -m "Fix backend health endpoint"
git commit -m "Document Git workflow on Windows"
```

---

## 11. Push To GitHub

First push:

```bash
git push -u origin main
```

Next pushes:

```bash
git push
```

---

## 12. Pull Latest Changes

Before starting work:

```bash
git pull
```

This downloads changes from GitHub and merges them locally.

---

## 13. Branch Workflow

Check current branch:

```bash
git branch
```

Create and switch to a new branch:

```bash
git switch -c feature/setup-docs
```

Switch to an existing branch:

```bash
git switch main
```

Push a new branch:

```bash
git push -u origin feature/setup-docs
```

---

## 14. Basic Professional Branch Names

Examples:

```text
feature/docker-setup
feature/git-guide
fix/angular-routing
docs/windows-setup
chore/update-gitignore
```

Use short, meaningful names.

---

## 15. Merge Branch Back To Main

```bash
git switch main
git pull
git merge feature/setup-docs
git push
```

Professional alternative on GitHub: open a Pull Request.

---

## 16. .gitignore

The `.gitignore` file tells Git which files must not be committed.

Open it in VS Code:

```bash
code .gitignore
```

Common example:

```gitignore
# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# Environment
.env
.venv/
node_modules/

# Python
__pycache__/
*.pyc

# Logs
*.log

# Build outputs
dist/
build/
target/
```

Important: never commit secrets:

```text
.env
passwords
API keys
private tokens
```

---

## 17. See Differences

Show unstaged changes:

```bash
git diff
```

Show staged changes:

```bash
git diff --staged
```

VS Code and GitLens can show this visually.

---

## 18. Restore A Modified File

Discard local changes in one file:

```bash
git restore README.md
```

Danger: this removes your local edits for that file.

---

## 19. Pre-Commit Tooling

Pre-commit tooling runs checks before a commit is accepted.

Typical examples:

* code formatting
* linting
* tests
* secret detection

Python example:

```bash
pip install pre-commit
pre-commit install
```

Run manually:

```bash
pre-commit run --all-files
```

Typical `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
```

For JavaScript / Angular projects, pre-commit may also run:

```bash
npm run lint
npm test
```

---

## 20. VS Code Git Panel

In VS Code:

1. Open the project folder.
2. Click the Source Control icon.
3. Review changed files.
4. Stage selected files or all files.
5. Write a commit message.
6. Commit.
7. Push / Pull / Sync.

This is the graphical equivalent of:

```bash
git status
git add .
git commit -m "message"
git push
```

---

## 21. What GitLens Is For

GitLens is not Git itself. It is an advanced Git helper inside VS Code.

Useful features:

| GitLens Feature   | Meaning                                |
| ----------------- | -------------------------------------- |
| Blame             | Shows who changed a line and when.     |
| File history      | Shows the history of one file.         |
| Commit history    | Shows previous commits.                |
| Branch view       | Shows branches visually.               |
| Compare revisions | Compare current code with old commits. |

GitLens is mainly for understanding history, not for replacing basic Git knowledge.

---

## 22. Daily Professional Workflow

Start work:

```bash
cd /c/Users/nathalie/coding/github/YOUR-REPO
git switch main
git pull
git switch -c feature/my-task
code .
```

During work:

```bash
git status
git diff
git add .
git commit -m "Implement my task"
```

Push branch:

```bash
git push -u origin feature/my-task
```

After review or when finished:

```bash
git switch main
git pull
git merge feature/my-task
git push
```

---

## 23. Minimal Command Cheat Sheet

```bash
pwd                         # show current directory
ls                          # list files
mkdir folder-name            # create directory
cd folder-name               # enter directory
cd ..                        # go one level up

git clone URL                # download repo
git status                   # show Git state
git add .                    # stage all changes
git restore --staged .       # unstage all changes
git commit -m "message"      # commit changes
git push                     # upload to GitHub
git pull                     # download latest changes

git branch                   # list branches
git switch branch-name       # change branch
git switch -c new-branch     # create and switch branch
```

---

 