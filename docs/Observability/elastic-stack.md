# Elastic Stack

ELK Stack

- **Elasticsearch:** it can search data more efficiently and scalable; it can do geospatial analysis and visualization; Logging and analytics;
    - Search engine and analytics;
- **Logstash:** real time data collector engine. get data from many places and transform and send data to many places. Also we can use some plugins to manipulate the data;
    - data processor through pipeline that can receive, transform and send simultaneous data;
- **Kibana:** Dashboard to visualize and explore the data, is used to: logs, analyse, application monitoring, operational intelligence. Integrated with Elasticsearch, also allow us to aggregate and filter data;
    - Allow users to visualize the elasticsearch data in different perspective;
    - maps, interactive graphs, dashboards;
   

### **ELK vs Elastic Stack ?**

ELK ⇒ Logstash → Elasticsearch → Kibana

Elastic Stack ⇒ (Beats, Logstash) → Elasticsearch → Kibana

**Beats →** “lightweight data shipper” delivery data on a light way. Data collector agent.

- Easy integration with Elasticsearch or Logstash,
- Get logs, metrics, network data, audit data, uptime monitoring

### Elastic

Elastic is a company behind the elasticstack, we can use the stack without pay anything but there is some plugins that we need to pay in order to use;

Products:

- APM → Application Performance Monitoring
- Maps
- Site Search
- Enterprise search
- App Search
- Infrastructure

## Kibana

Kibana is your window into the Elastic Stack. Specifically, it's a browser-based analytics and search dashboard for Elasticsearch.

## Projects

- [Observability-ElasticStack](https://github.com/GabrielBrotas/observability-elasticstack)