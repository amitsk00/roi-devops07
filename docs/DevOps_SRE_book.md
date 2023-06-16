
## Post mortem

```
-- Strcture of the document --

* Date
* Authors
* Status
* Summary
* Imapct
* Trigger - what caused it
* Root Cause
* Resolution
* Action Items (with tasks, owners, status/bug)
* Lessons Learnt
    * What went well
    * What went bad
    * where we were lucky
* Timeine
* Supporting docs
```

* Avoid Blame and Keep It Constructive
* Collaborate and Share Knowledge
* No Postmortem Left Unreviewed
* Visibly Reward People for Doing the Right Thing
* Ask for Feedback on Postmortem Effectiveness
* Conclusion and Ongoing Improvements



## Error Budgets

* Product Management defines an SLO, which sets an expectation of how much uptime the service should have per quarter.
* The actual uptime is measured by a neutral third party: our monitoring system.
* The difference between these two numbers is the "budget" of how much "unreliability" is remaining for the quarter.
* As long as the uptime measured is above the SLO—in other words, as long as there is error budget remaining—new releases can be pushed.


>  If SLO violations occur frequently enough to expend the error budget, releases are temporarily halted while additional resources are invested in system testing and development to make the system more resilient

> If the team is having trouble launching new features, they may elect to loosen the SLO (thus increasing the error budget) in order to increase innovation.


SRE do not set SLI (business and product decide), but SRE decides on SLI

## SLI


 * Latency - time to return response
 * Error rates - fraction of valid requests
 * throughput - requests per second
 * availability - fraction of time the service is usable
 * yield - fraction of well formed requests that succeed
 * durability - likelihood that data will be retained over a long period of time


&nbsp;
&nbsp;

QPS can't be SLI as the requests are not in our hands. 

&nbsp;
&nbsp;

Which system needs what:

| system type | which SLI needed |
| --- | --- |
| User-facing serving systems |  availability, latency, and throughput| 
| Storage systems |  latency, availability, and durability| 
| BigData systems |  throughput and end-to-end latency| 
| All systems |  correctness| 



&nbsp;
&nbsp;

SLI specs
* Aggregation intervals: “Averaged over 1 minute”
* Aggregation regions: “All the tasks in a cluster”
* How frequently measurements are made: “Every 10 seconds”
* Which requests are included: “HTTP GETs from black-box monitoring jobs”
* How the data is acquired: “Through our monitoring, measured at the server”
* Data-access latency: “Time to last byte”

## SLO


&nbsp;
&nbsp;


Control Measures

1. Monitor and measure the system’s SLIs.
2. Compare the SLIs to the SLOs, and decide whether or not action is needed.
3. If action is needed, figure out what needs to happen in order to meet the target.
4. Take that action.


## SLA

an explicit or implicit contract with your users that includes consequences of meeting (or missing) the SLOs they contain

Google Search has no SLA, but slow searches have impact on reputation and ad loss.



&nbsp;
&nbsp;


## Toil
* Manual
* Repeatative
* Automable
* Tactical
* no enduring value
* Grows with service growth

SRE spend 50% time on toil

> Overhead --> Administrative work not tied directly to running a service. Examples include hiring, HR paperwork, team/company meetings, bug queue hygiene, snippets, peer reviews and self-assessments, and training courses.

&nbsp;
&nbsp;

Is Toil Always Bad?
* Career Stagnation
* Low morale
* confusion
* slows progress
* sets precedent - Dev may push tasks/work to SRE 
* promotes attrition
* breach of faith - for new joiners



## Monitoring

White-box monitoring --> Monitoring based on metrics exposed by the internals of the system, including logs, interfaces like the Java Virtual Machine Profiling Interface, or an HTTP handler that emits internal statistics. (pro active - before issue occurs)

Black-box monitoring --> Testing externally visible behavior as a user would see it. (reactive - after problem occurs)



Why Monitor?
* Analyzing long-term trends
* Comparing over time or experiment groups
* Alerting
* Building dashboards
* Conducting ad hoc retrospective analysis (i.e., debugging)


The Four Golden Signals
Latency 
:  The time it takes to service a request
Traffic 
:  how much demand is being placed on your system e.g. HTTP requests per second , network I/O rate , concurrent sessions , transactions / retrievals per second
Errors 
    :  The rate of requests that fail
Saturation 
    :  How "full" your service is e.g. memory or I/O or CPU (latency is because of saturation)

<p> how many requests did I serve that took between 0 ms and 10 ms, between 10 ms and 30 ms, between 30 ms and 100 ms, between 100 ms and 300 ms, and so on? 




## Best Practices for Incident Management
* Prioritize.Stop the bleeding, restore service, and preserve the evidence for root-causing.

* Prepare.Develop and document your incident management procedures in advance, in consultation with incident participants.

* Trust.Give full autonomy within the assigned role to all incident participants.

* Introspect.Pay attention to your emotional state while responding to an incident. If you start to feel panicky or overwhelmed, solicit more support.

* Consider alternatives.Periodically consider your options and re-evaluate whether it still makes sense to continue what you’re doing or whether you should be taking another tack in incident response.

* Practice.Use the process routinely so it becomes second nature.

* Change it around.Were you incident commander last time? Take on a different role this time. Encourage every team member to acquire familiarity with each role.


Incident Command System
* Coordinate
* Communicate
* Command

The OL works to respond to the incident by applying operational tools to mitigate or resolve the incident.

While the IC and OL work on mitigating and resolving the incident, the CL is the public face of the incident response team. If the incident becomes small enough, the CL role can be subsumed back into the IC role.

