---
layout: page
title: Current thinking
page_display_sort_order: 1
---

* Don't test too small a unit.  Prefer component style tests over test class per production class.  Testing components results in resilient tests in the face of change that are not tied to implementation.
* Use mocks sparingly.  Mock at process boundaries but rarely for classes within a boundary