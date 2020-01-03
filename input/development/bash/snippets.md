---
title: Snippets
---

Stop on first error

```
set -e
set -o errexit
command || { echo "command failed"; exit 1; } 

# command you are interested in the return code
command || true
```