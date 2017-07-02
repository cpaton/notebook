---
title: Resources
---

# Videos

## Test automation without a headache: Five key patterns

![Test Patterns](https://vimeo.com/154289460)

**Synopsis**

Patterns for test automation that provide value of time and don't slow down a project over time

**Quotes/Thoughts**

* The purpose of automated testing is to be able to make change quicker
* Tests provide value on two occasions.  The first time they pass so that you know the feature works.  When they fail following change so that you know something is broken.  All the time they run and pass they are not really providing value.  Therefore optimise for diagnosing a failure when it happens
* Split tests into 3 logical layers/components
 * Business rules - Business language (Depends on tool)
 * Workflow - Calls to application API (Depends on application)
 * Interactions - technical infrastructure concerns e.g. talking to the database/queues etc (Depends on application)

## Testing with No Harm

![Testing with no harm](https://vimeo.com/154312751)

**Synopsis**

We have to change our applications to make them testable, in doing so we can cause harm to the application

**Quotes/Thoughts**

* Tests are as important as production code, but not more important.  
* Putting tests firsts ala TDD with tests driving the design can lead to creating fake abstractions to support testing.  This can lead to too many mocks and overspecified tests that are tightly linked to implementation
* Tests should define the behaviour of a system and not its structure
* Solution -> Test larger units, don't focus on test class per production class.  This leads to testing behaviour and not implementation.  Have a mix of component, integration and end-to-end tests
* Name your tests after a scenario and not a class being tested

**References**

* [DHH Test Induced Design Damage](http://david.heinemeierhansson.com/2014/test-induced-design-damage.html)

# Links

* [Is TDD dead?](https://martinfowler.com/articles/is-tdd-dead/)