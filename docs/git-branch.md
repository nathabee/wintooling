# Branch in github



After a PR is merged, the **feature branch is usually deleted**.

For a small team of 3 people, imagine it like this:

```text
main / production
= stable code, deployed or deployable

develop / next
= integration branch for the next version

feature branches
= short-lived branches for one task
```

Typical workflow:

```text
main
  ↑ final release merge
develop
  ↑ PR from feature branches
feature/add-login
feature/fix-dashboard
feature/update-docs
```

A developer usually does:

```text
1. Start from destination branch
   Example: develop

2. Fetch / Pull latest version

3. Create personal/task branch
   Example: feature/update-docs

4. Work locally

5. Commit locally

6. Push branch to remote

7. Open PR:
   feature/update-docs → develop

8. Review

9. Merge PR

10. Delete feature branch
```

So not usually:

```text
one permanent branch per developer
```

Better:

```text
one branch per task / issue / feature / bugfix
```

For parallel versions:

```text
main / production
develop / next version
release/1.2
hotfix/fix-login-production
feature/new-dashboard
```

Simple team rule:

```text
main = production
develop = next version
feature/* = temporary work
hotfix/* = urgent production fix
```

Yes, your mental model is close. The correction is: branches are usually **per task**, not per developer.
