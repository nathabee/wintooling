# powershell commands


## tree

### cmd
Windows `tree` does not support `-L` like Linux.

Basic command:

```cmd
tree
```

Only directories:

```cmd
tree /A
```

Directories + files:

```cmd
tree /F /A
```

Example:

```cmd
cd C:\Users\natha\coding\wintooling
tree /A
```

### Equivalent of `tree -L 3`

Windows `tree` has no depth limit.

Use PowerShell instead:

```powershell
Get-ChildItem -Directory -Depth 3
```

or a nicer view:

```powershell
Get-ChildItem -Depth 3
```

For something closer to Linux `tree -L 3`, install the modern `tree` package:

```powershell
winget install GnuWin32.Tree
```

or use Git Bash:

```bash
tree -L 3
```

Since you already have Git for Windows, the easiest is often:

```powershell
"C:\Program Files\Git\bin\bash.exe"
```

then:

```bash
cd ~/coding/wintooling
tree -L 3
```

That gives you exactly the Linux behavior you're used to.
