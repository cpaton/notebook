---
title: Event Sourcing
---

# Videos

## The Elephant in the Room (Versioning Events)

Talk by Greg Young at [DDD eXchange 2017](https://skillsmatter.com/conferences/8231-ddd-exchange-2017#skillscasts) [https://skillsmatter.com/skillscasts/9652-the-elephant-in-the-room](https://skillsmatter.com/skillscasts/9652-the-elephant-in-the-room) which goes through patterns for versioning events.  Greg has also written a book covering the subject [https://leanpub.com/esversioning](https://leanpub.com/esversioning)

Greg's position is that if you can take the entire system down and then bring it back up versioning is an easy problem to solve, the more interesting problem is if you can't have downtime and need to run the old and new version of the system side by side.

1. Starts assuming your serializer is strict and doesn't provide any help.  In this case you have to make additive changes only by creating new _vX copies of the events and methods on your aggregate to apply those events.  Over time you end up with a large list of events
2. Better approach is to use loose schema where you only copy fields from your event to your C# class if the names match.  With this approach you can still only make additive changes and cannot rename any fields but you can keep a single event type and applicator.  This suppports upcasting older versions to the latest versions using defaults for the newer fields
3. Key attribute of an event store is that the events are immutable and cannot be changed, but nothing says you can't modify an event stream and create a new one.  You can write control events into the stream which the software can correspond to.  Stream modification can happen asyncronhously or you can have the new version of the software perform the modifications as it works on a stream.
4. Harder problems to solve are if you have your aggregate boundaries wrong.  You may need to split a single stream into two streams if you realise a single aggregate is actually two, or you may need to combine two streams into one.  Control events can be written into the old stream when this happens.  This can work but gets complicated fast.
5. It may be better to cheat.  You could migrate all data from the old system to the new system (similar to SQL migrations).  Bring both systems up copy all events from the old version to the new version, during the copy you have the opportunity to perform operations on the event stream to fix bugs or tidy things up.  Once the copy is complete you can have the old version write an event to shutdown and no longer accept new transactions, once the new version sees the shutdown event it knows there will not be any events to receive and can start accepting transactions.  When the new system has taken over the old one can be deleted.  Immutable infrastructure