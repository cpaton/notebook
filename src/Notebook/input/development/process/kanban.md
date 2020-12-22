---
title: Kanban
---

# Questions

* Where does estimation fit into kanabn? 
* Big source of variability would be ticket size.  Assume you would want to bring in tickets of similar size how do you achieve that?  At what point do you break larger tickets into smaller tickets of the same size
* How do you handle regression testing?
* How do you decide on your wip limits per column?

# Bookshelf

## Kanaban - Successful evolutionary change for your technology business

![Kanaban - Successful evolutionary change for your technology business](site.asset-base-url/Kanaban-Successful-evolutionary-change-for-your-technology-business-cover.jpg)

Kanaban - Successful evolutionary change for your technology business
(David J Anderson)

* Chapter 1 - ToC Drum-Buffer-Rope is an alternative implementation of a pull system.  Kanban seems to have a better fit to software development
* Chapter 2 - Kanban 5 core properties
    * Visualise workflow
    * Limit work in progress
    * Measure and manage flow
    * Make process policies specific
    * Use models to recognise improvement opportunities
* Chapter 3 - steps for implementing kanban within an existing team without causing too much disruption
    1. Focus on quality - fixing defects is the biggest source of waste in software development
    2. Reduce work in progress - studies so direct link between wip and quality
    3. Deliver often - build trust between development and other teams
    4. Balance demand with throughput - only accept new work when work is complete.  Exposes the bottleneck and creates slack enabaling time for improvement
    5. Priotize - look to maximize business value and not just development team throughput
    6. Attack sources of variability to improve predictability - more advanced topic and should be tackled after the above 5
* Chapter 6 - how to construct the kanban board along with examples for more complex workflows and swimlanes for different work types.  
* Chapter 8 - Release frequency 
   * Short time boxed iterations of Agile can lead to dysfunctional teams
   * Kanabn decouples prioritisation, development and delivery
   * Releasing has a cost, that needs to be balanced with the value gained
* Chapter 9 - Priotisation frequency
   * Have an input queue with a set size
   * Regular priorisation meetings to fill empty gaps in queue
   * As queue is small meeting should be quick
   * Estimation of items in backlog has a cost that needs to be balanced and may not be needed
* Chapter 10 - WIP limits
   * WIP limits are required
   * Don't set WIP limits too low - likely to find lots of impediments to flow initially
   * WIP limit per column/work centre should generally be set by average nummer of items per person
   * Bottleneck needs a buffer in front of them (but should be small)
   * Set a WIP limit and monitor it overtime
   * Input queue size should be slightly larger than the average items completed in the regular timeframe of priortisation
* Chapter 11 - Classes of service
   * Swimlane per class of service e.g. bug, work item, epedite (production defect), tech improvement
* Chapter 12 - Metrics
   * Cumulative flow diagram - should be smooth
   * Lead time (item count by days)
   * Throughput (items or story points per time period)
   * Flow efficiency (total time v value added time)
* Chapter 13 - Real world projects
   * Core priniciples of kanban apply - wip limits, prioritisation cadence, delivery cadence and classes of service
   * May track epics and stories on single kanban board
   * Typically won't go down to the level of a task

## Lean primer

[Lean Primer - Craig Larman & Bas Vodde](http://www.leanprimer.com/wiki/index.php?title=Main_Page)   