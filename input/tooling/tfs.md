---
title: TFS
---

Experiences with working TFS 2015 on premise update 2

# Custom task to provide access to agent internals

# Viewing secret variables

# Artifacts

# Limitations

* **build triggers and variables**  Able to schedule builds but cannot provide variables values when the build is run, only the defaults are available.  Similarliy other triggers via CI or branch policies don't suppor specify variables values.   Without this capability it leads to having to create multiple copies of builds that are almost identical which coudl have been a single build definition with different variable values

# Resources

* [VSTS Task SDK](https://github.com/Microsoft/vsts-task-lib)  PowerShell module for working with TF build.  Designed to work with build agents 1.9.5 and up.  
* [VSTS Tasks](https://github.com/Microsoft/vsts-tasks) Implementation of custom tasks that come in the box
* [VSTS Agent](https://github.com/Microsoft/vsts-agent/) v2 agent that will replace the current closed source agent
* [TFS Rest API](https://www.visualstudio.com/en-us/docs/integrate/api/overview)