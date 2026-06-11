# test git lens develop 2

## Scenario

```text
Starting point:
main = stable branch
develop = already published remote branch
develop contains 2 new committed files
Goal = review develop, then merge develop into main with a Pull Request
```

Important correction: **GitLens can help review and inspect changes**, but **opening issues and accepting PRs is normally done on GitHub.com** or with the **GitHub Pull Requests extension** in VS Code. GitLens alone is not the main PR tool.

scope :  we want now using googlens to merge the branch develop to the branch with PR after reviewing the changes (we should see 2 new files before accepting the merge)

## Step By Step
 



## 1. Open an issue

Best place: **GitHub.com**

```text
Repository → Issues → New issue
```

Example title:

```text
Add initial Git extension test files
```

Example body:

```text
This issue tracks the test changes created on the develop branch.

Expected change:
- Add two new files
- Review changes through Pull Request
- Merge develop into main after validation
```

Then create the issue.

## 2. Create a Pull Request

On GitHub.com:

```text
Repository → Pull requests → New pull request
```

Select:

```text
base: main
compare: develop
```

Meaning:

```text
merge develop into main
```

GitHub should show:

```text
2 files changed
```

Review these two files before merging.

## 3. Review changes with GitLens in VS Code

In VS Code:

```text
GitLens → Repositories → wintooling → Branches
```

Look at:

```text
remotes/origin/develop
remotes/origin/main
```

Then compare:

```text
origin/develop
against
origin/main
```

You want to see the two new files as the difference.

GitLens is useful here for:

```text
commit list
changed files
file diff
author/date/message
```

## 4. Accept the Pull Request

After review on GitHub.com:

```text
Pull Request → Files changed
```

Confirm the two files are correct.

Then:

```text
Merge pull request
Confirm merge
```

Now `main` contains the two files from `develop`.

## 5. Update local VS Code after merge

In VS Code standard Git extension:

```text
Switch to main
Fetch
Pull
```

Now local `main` also has the two files.

## Clean tool split

```text
GitHub.com
→ Issue
→ Pull Request
→ Merge

GitLens
→ Inspect branch history
→ Compare develop and main
→ Review commits/files

VS Code Git extension
→ Fetch
→ Pull
→ Switch branch
```

So the professional workflow is: **GitLens for review, GitHub PR for merge.**
