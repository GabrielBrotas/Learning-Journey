# Observability

**Observability lets us understand a system from the outside**, by letting us ask questions about that system without knowing its inner workings. Furthermore, **allows us to easily troubleshoot and deal with new problems**, and helps us answer the question, “Why is this happening?”

In order to be able to ask those questions of a system, the application must be properly instrumented. That is, the application code must emit signals such as traces, metrics, and logs. **An application is properly instrumented when developers don’t need to add more instrumentation to troubleshoot an issue because they have all of the information they need.**

---

It's important to ensure the application is running properly, in a big system we cannot work without observability.

"Imagine you are the pilot of an airplane with 300 people flying, you need the necessary measures (high, velocity,...) to know what decision to take or if a problem happen you need to know where to fix. Our applications is an airplane"

> Who doesn't measure doesn't manage;

It’s essential to understand when something goes wrong along the application delivery chain so you can identify the root cause and correct it before it impacts your business. Monitoring and observability provide a two-pronged approach. Monitoring supplies situational awareness, and observability helps pinpoint what’s happening and what to do about it.

> Good monitoring is a staple of high-performing teams. DevOps Research and Assessment (DORA) research shows that a comprehensive monitoring and observability solution, along with a number of other technical practices, positively contributes to continuous delivery.

## Observability vs Monitoring

Observability and monitoring are two related concepts, monitoring is a subset of observability.

Monitoring is the process of collecting and analyzing data from a system to assess its health and performance. It involves setting up a predefined set of metrics and logs to track, typically focusing on metrics that are essential for the proper functioning of the system. 

Observability provides a broader understanding of a system. It involves collecting and analyzing a wide range of data, including metrics, logs, traces, and events to explore properties and patterns not defined in advance.

### Observability
> Is tooling or a technical solution that allows teams to actively debug their system. Observability is based on exploring properties and patterns not defined in advance.

Observability is the ability to understand a complex system’s internal state by analyzing the data it generates, such as logs, metrics, and traces. it helps teams analyze what’s happening and identify the root cause of a performance problem so they can detect and resolve the underlying causes of issues.

- How well you can understand your complex system.
- It’s a measure of our internal system, how we can get the data output and understand what is happening inside the system.
- Understand why is wrong, and how that happen?
- Gain visibility into aspects of the system that were previously unknown or unexpected.
- Get insight to identify and resolve issues more quickly.
- Understand how different components are interacting with each other and identify potential points of failure.
- Enable teams to proactively optimize their systems, by identifying areas for improvement and make data-driven decisions.

### Monitoring
Monitoring is the task of assessing the health of a system by collecting and analyzing aggregate data based on a predefined set of metrics and logs.

It measures the health of the application, such as creating a rule that alerts when the app is nearing 100% disk usage, helping prevent downtime. It shows you not only how the app is functioning, but also how it’s being used over time.

- Show when there’s something wrong;
- Know in advance the signals you want to monitor;
- Enables teams to proactively detect and diagnose issues before they impact end-users;
- Detect and diagnose issues before they escalate into more significant problems.
- Generate alerts when predefined thresholds are crossed or when other predefined conditions are met.

<br />

For **example**, in a e-commerce scenario, monitoring would focus on specific metrics that are critical for the proper functioning of each service, such as response time, error rates, and CPU usage. A tool (such as Prometheus) could be used to track these metrics and generate alerts when predefined thresholds are crossed.

And the observability would allow teams to explore data in real-time to gain insights into the behavior and performance of the entire system. such as trace requests across the entire system and identify the root cause of the issue.

**3 Pillars of Observability:**

- **Metrics ⇒** number, we have 2 types of metrics, business metrics and technical metrics;
    technical metrics: CPU: 90%, Memory: 50%...
    
    business metrics: 50 new students, 10 students left this month,...

- **Logs ⇒** result of a specific events;

- **Tracing ⇒** order of how the event was generated, stacktrace;


## Tools
- [Elastic Stack](elastic-stack.md)
- Prometheus & Grafana
- [OpenTelemetry](open-telemetry.md)
- Datadog
