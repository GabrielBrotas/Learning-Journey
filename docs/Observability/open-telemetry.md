# OpenTelemetry

## Telemetry, Reliability and Metrics

**Telemetry** refers to **data emitted from a system about its behavior**. The data can come in the form of Traces, Metrics, and Logs.

**Reliability** answers the question: “**Is the service doing what users expect it to be doing?**” A system could be up 100% of the time, but if, when a user clicks “Add to Cart” to add a black pair of pants to their shopping cart, and instead, the system keeps adding a red pair of pants, then the system would be said to be **un**reliable.

**Metrics are aggregations over a period of time of numeric data about your infrastructure or application**. Examples include system error rate, CPU utilization, request rate for a given service, and so on….

---

## **Logs**

**A Log is a timestamped message emitted by services or other components.** Unlike Traces, however, they are not necessarily associated with any particular user request or transaction. They are found almost everywhere in software, and have been heavily relied on in the past by both developers and operators alike to help them understand system behavior.

Unfortunately, logs aren’t extremely useful for tracking code execution, as they typically lack contextual information, such as where they were called from.

They become far more useful when they are included as part of a Span.

## **Spans**

**A Span represents a unit of work or operation. It tracks specific operations that a request makes, painting a picture of what happened when that operation was executed.**

A Span contains name, time-related data, structured log messages, and other metadata (i.e. Attributes) to provide information about the operation it tracks.

Below is a sample of the type of information that would be present in a Span:

**Span Attributes**

| Key              | Value      |
| ---------------- | ---------- |
| net.transport    | IP.TCP     |
| net.peer.ip      | 10.244.0.1 |
| net.peer.port    | 10243      |
| net.host.name    | localhost  |
| http.method      | GET        |
| http.target      | /cart      |
| http.server_name | frontend   |
| http.route       | /cart      |
| http.scheme      | http       |
| http.host        | localhost  |
| http.flavor      | 1.1        |
| http.status_code | 200        |

## **Distributed Traces**

A **Distributed Trace**, more commonly known as a **Trace**, **records the paths taken by requests (made by an application or end-user) as they propagate through multi-service architectures, like microservice and serverless applications.**

Without tracing, it's challenging to identify the cause of performance issues in a distributed system.

It improves the visibility of our application or system’s health and lets us debug behavior that is difficult to reproduce locally. Tracing is essential for distributed systems, which commonly have nondeterministic problems or are too complicated to reproduce locally.

Tracing makes debugging and understanding distributed systems less daunting by breaking down what happens within a request as it flows through a distributed system.

**A Trace is made of one or more Spans.** The first Span represents the Root Span. Each Root Span represents a request from start to finish. The Spans underneath the parent provide a more in-depth context of what occurs during a request (or what steps make up a request).

Many Observability back-ends visualize Traces as waterfall diagrams that may look something like this:

![Traces as Waterfall](/Learning-Journey/images/observability/waterfall-trace.png)

Waterfall diagrams show the parent-child relationship between a Root Span and its child Spans. When a Span encapsulates another Span, this also represents a nested relationship.

- If you have 5 microservices and a user got an error 500, what microservice went wrong? with tracing, we can see the request from microservice to microservice to debug the problem.

## **So what?**

In order to make a system observable, it must be instrumented. That is, the code must emit traces, metrics, and logs. The instrumented data must then be sent to an Observability back-end. There are a number of Observability back-ends out there, ranging from self-hosted open-source tools to commercial SaaS offerings.

In the past, the way in which code was instrumented would vary, as each Observability back-end would have its own instrumentation libraries and agents for emitting data to the tools.

This meant that there was no standardized data format for sending data to an Observability back-end. Furthermore, if a company chose to switch Observability back-ends, it meant that they would have to re-instrument their code and configure new agents just to be able to emit telemetry data to the new tool of choice.

Recognizing the need for standardization, the cloud community came together, and two open-source projects were born: [OpenTracing](https://opentracing.io/) (a [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/) project) and [OpenCensus](https://opencensus.io/) (a [Google Open Source](https://opensource.google/) community project).

In the interest of having one single standard, OpenCensus and OpenTracing were merged to form OpenTelemetry (OTel for short) in May 2019. As a CNCF incubating project, OpenTelemetry takes the best of both worlds, and then some.

## **What is OpenTelemetry (OTel)**

OpenTelemetry, also known as OTel for short, is a vendor-neutral open source Observability framework for instrumenting, generating, collecting, and exporting telemetry data such as traces, metrics, and logs. As an industry standard, it is natively supported by a number of vendors.

OpenTelemetry is a collection of tools, APIs, and SDKs. Use it to instrument, generate, collect, and export telemetry data (metrics, logs, and traces) to help you analyze your software’s performance and behavior.

OTel’s goal is to provide a set of standardized vendor-agnostic SDKs, APIs, and [tools](https://opentelemetry.io/docs/collector) for ingesting, transforming, and sending data to an Observability back-end (i.e. open-source or commercial vendor).

## **What can OpenTelemetry do for me?**

OTel has broad industry support and adoption from cloud providers, [vendors](https://opentelemetry.io/vendors) and end users. It provides you with:

- A single, vendor-agnostic instrumentation library [per language](https://opentelemetry.io/docs/instrumentation) with support for both automatic and manual instrumentation.
- A single vendor-neutral [collector](https://opentelemetry.io/docs/collector) binary that can be deployed in a variety of ways.
- An end-to-end implementation to generate, emit, collect, process and export telemetry data.
- Full control of your data with the ability to send data to multiple destinations in parallel through configuration.
- Open-standard semantic conventions to ensure vendor-agnostic data collection
- The ability to support multiple [context propagation](https://opentelemetry.io/docs/reference/specification/overview/#context-propagation) formats in parallel to assist with migrating as standards evolve.
- A path forward no matter where you are on your observability journey.

Vendors and Tools with different patterns = Lock-In

## **What OpenTelemetry is not**

OpenTelemetry is not an observability back-end like Jaeger or Prometheus. Instead, it supports exporting data to a variety of open-source and commercial back-ends. It provides a pluggable architecture so additional technology protocols and formats can be easily added.

Refs:

- [OpenTelemetry](https://opentelemetry.io/docs/concepts/)
