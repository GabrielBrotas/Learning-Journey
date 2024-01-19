# Resilience

## Introduction

- Principle: "At some point, every system will fail."
- Resilience is the ability of a system to recover from failures and continue to function.
- Resilience is a set of intentionally strategies for the adaptation of a system when a failure occurs.
- Have resilience strategies allow us to minimize the risk of data loss and crucial transactions for the business.

## Resilience Strategies

### Protect and be protected

- a system in a distributed arquitecture needs to adopt self-preservation mechanisms to ensure its operation with the highest possible quality.
    - in a software system quality means that the system is available, reliable, and secure. If your SLA is 99.99% availability, then your system must be available 99.99% of the time. If your system has to respond to a request in 100ms, then it must respond in 100ms or less regardless of the number of requests (100, 1K, 1M).
- a system cannot be selfish to the point of making more requests to a failing system. It must be able to protect itself from failures and protect other systems from its own failures.
    - if the external system is failing, it must not make more requests to that systems, it must wait for the system to recover.
- a slow system available most times is worse than an unavailable system (cascade effect).
    - all systems that rely on the slow system will be affected by the slowness.

### Health check

- a system must be able to check its own health.
- without vital signs, it's not possible to know if the system is "alive" or "dead".
    - health check is not only return a 200 OK response, it's also check if the external dependencies of that system are healthy, the database, the cache,..., everything that is necessary for the system to work.
- a system that is not healthy has a chance of self-recover if stop receiving traffic.
    - if the system is not healthy, it must not receive traffic, it must be isolated from the rest of the system.
    - when the system is not healthy, for example is slow because it received a lot of traffic/requests, in this case, if we stop sending traffic to the system, it will have a chance to process the pending requests and self-recover.
- Active health check
    - the system is responsible for checking its own health.
    - the system is responsible for reporting its health status to the health check system (monitoring system).
- Passive health check
    - the system is not responsible for checking its own health.
    - the health check system is responsible for checking the health of the system.
    - example of passive health check: kubernetes probes. The probes are responsible for checking the health of the system and the system is responsible for reporting its health status to the kubernetes probes.

### Rate limiting

