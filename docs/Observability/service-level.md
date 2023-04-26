# Service Level

## **SLA**
An SLA (service level agreement) **is an agreement between provider and client about measurable metrics like uptime, responsiveness, and responsibilities.**

These agreements are typically drawn up by a company’s new business and legal teams and they represent the promises you’re making to customers—and the consequences if you fail to live up to those promises. Typically, consequences include financial penalties, service credits, or license extensions.

- Agreement you make with your clients or users.
- Agreement between a vendor and a paying customer.
- Legal contract that if breached, will have financial penalties.

## **SLO**
An SLO (service level objective) **is an agreement within an SLA about a specific metric like uptime or response time**. So, if the SLA is the formal agreement between you and your customer, SLOs are the individual promises you’re making to that customer.

SLOs are what set customer expectations and tell IT and DevOps teams what goals they need to hit and measure themselves against.

- Intended to define a range of what is most and least acceptable for performance standards;
- Objectives your team must hit to meet that agreement;
- 99% of requests served in < 400ms over a 28-day window;
- Disaster recovery time;
- Application availability;

## **SLI**

An SLI (service level indicator) **measures compliance with an SLO** (service level objective). So, for example, if your SLA specifies that your systems will be available 99.95% of the time, your SLO is likely 99.95% uptime and your SLI is the actual measurement of your uptime. Maybe it’s 99.96%. Maybe 99.99%. **To stay in compliance with your SLA, the SLI will need to meet or exceed the promises made in that document.**

- Real numbers on performance

Refs:
- [Atlassian](https://www.atlassian.com/incident-management/kpis/sla-vs-slo-vs-sli)