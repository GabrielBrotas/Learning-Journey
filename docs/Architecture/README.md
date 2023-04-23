## Types of Architecture

- Technological Architecture
- Corporate Architecture
- Solution Architecture
- Software Architecture

### Technological Architecture

This type of architecture focuses on specific technologies used in the market. A technology architect has in-depth knowledge of a particular tool or technology and can generate value based on their expertise. They are well-versed in the workings of a particular technology, and are able to recommend and implement solutions that leverage that technology. Examples of technology architects include Elastic architects (for Kibana and Elastic Search), Java architects, SQL Server architects, SAP architects...

- Specialization in specific market technologies, has a great knowledge of a technology/tool.
- Generate value based on specialties;
- In-depth knowledge of the technology;

### Enterprise Architecture

Enterprise architecture involves creating policies and rules that strategically impact the organization as a whole. In large companies with thousands of employees, the number of technologies that can be utilized may be endless. An enterprise architect brings solid governance to the infrastructure and technology that will be used, with a focus on evaluating costs that make sense for the company's growth. They evaluate licenses, assess new technologies, standardize technologies, plan large-scale implementations, and oversee core systems and migrations (such as from monolithic to microservices).

- Policies and rules that strategically impact the organization as a whole,
- The number of technologies that can be used can reach N, this architect brings solid governance regarding the infrastructure/technology that will be used with an evaluation of costs that make sense for the company to grow.
- Evaluation of licenses;
- Evaluation of possible new technologies;
- Standardization of technologies;
- Planning for large deployments (SAP, Salesforce,...)
- Core systems, migrations (Monolithic, Microservices, ...)

### Solutions Architecture
Solution architecture sits at the intersection of business and software, translating business requirements into software solutions. Solution architects create architectural designs that map out how the software will function. They use tools like the C4 diagram, UML, and BPMN to analyze the commercial impact of technology choices, assess the company's context and team, and make informed decisions. For example, they may assess whether it makes sense for a company to switch from AWS to Google Cloud Platform, or whether migrating from Oracle to SQL or Postgres would be cost-effective. Solution architects take a short, medium, and long-term view of the software, and may be involved in pre-sales and sales processes to better understand the business and its needs. They also analyze the cost impact of implementing solutions, bringing predictability to the project.

- Between the business and software area, transforms business requirements into software solutions;
- Architectural designs of the software solution to reproduce how it will work;
- C4 diagram, UML, BPMN;
- Analyzes commercial impacts regarding a technology choice, analyzes the company's context and team to be able to make that decision (ex: if the company is using AWS, does it make sense to switch to Google just because it's the technology your team knows? Is there a financial advantage in this?, Oracle database, does it make sense to switch to SQL, Postgres,...?);
- Short, medium, long-term thinking;
- May participate in the pre-sales and sales process, usually accompanies the client to better understand the business;
- Analyzes the cost impacts for the business, how much does it cost to implement this CRM? brings predictability
- High-level vision (macro);

### Software Architecture
Software architecture is a discipline of software engineering that is directly tied to the software development process. It has a significant impact on the organizational structure of a company, and involves forming teams and structuring software components. Software architects must consider how to develop the software in components that best meet the business objectives. They must also take into account any restrictions or limitations, such as budget constraints, team capabilities, or technological requirements. Software architecture is the fundamental organization of a system and its components, as well as the principles that guide its design and evolution. A software architect must build a software system with a long-term perspective, and must ensure that the software delivers value to the company. They focus on the micro-level details of design, patterns, tests, implementation, clean architecture, code reviews, and requirements.

- Discipline of software engineering, directly linked to the software development process;
- Directly affects the organizational structure of the company;
- Formation of teams, structure of software components;
- How can I develop this software in components? How can these components best meet business objectives? every business has constraints, so I have to adapt my components to these constraints (financial, team, technological, etc.).
- It is the fundamental organization of a system and its components, their relationships, their environment, as well as the principles that guide its design and evolution.
- Software must be built with long-term thinking.
- The role of the software architect is to make the software return value to the company.
- Micro vision (design, patterns, tests, implementations, clean architecture, code reviews, requirements,....)

### Role of the Software Architect
- Translate business requirements into architectural patterns;
- Orchestrate developers and domain experts;
- Assist in decision-making in times of crisis;
- Reinforce good development practices.
- Have a deep understanding of architectural concepts and models;

It is common for us to want to solve a new problem in the same way we solved past ones. For example, if we always used a monolithic pattern, it is very likely that the next challenge will also be a monolithic application. The more the software architect understands architectural models, the greater their range of possibilities to understand and solve the challenge in the best possible way.

### Why learn software architecture?
- Ability to navigate from the macro to the micro view of one or more software;
- Understand the various options we have to develop the same thing and choose the best solution for a given context;
- Think long-term about the project and its sustainability (Deadlines, People);
- Make decisions in a more cold and calculated way, thus avoiding being influenced by market "hypes";
- Dive into design patterns and development and their best practices;
- Have a clearer understanding of the impact that software has on the organization as a whole;
- Make decisions with more confidence.

### Sustainability

- Developing software is expensive;
- Software solves a "pain";
- Software needs to pay for itself over time;
    - The company should profit more because of that software;
    - The software, along with the company, is an organism, as this evolution occurs, the software must be able to sustain itself in a way that the cost is lower than the result it is bringing to the company;

- Long-term thinking;
    - It is very common for a software to reach a point where the developers are demotivated to work and want to start everything from scratch, but often the software hasn't even paid for itself and has to start over, in this way the software will never be able to reach the breakeven point, balance between cost vs what it generates.

- Follow the evolution of the business;
    - For example: imagine if Nubank goes through a refactoring process and customers have to wait for the bugs to be fixed before they can use the product again, this is unfeasible for the business, the software must be built with a long-term perspective and always following the evolution of the business.

- The longer the software stays up, the more return it generates;
- The solution needs to be architected;

### Software Architecture Pillars
- Structuring
    -Easy evolution and componentization to meet business objectives;
- Componentization;
- Relationship between systems; (External communication, third-party services, networks)
- Governance; (Standardization, rules, documentation, protocols, ...)
    - A software must be independent of the developer. If a person leaves, it should be easy for someone else to take on that role and continue the project in the same way it was.

### Architectural Requirements
- Performance
    - Example: Handling 500 requests per second, resilience, etc.

- Data storage
    - Example: Data centers in Brazil, Europe, etc.?

- Scalability
    - Horizontally, vertically, load balancer, etc.

- Security
    - SSL, Rate Limiter, Mutual TLS, etc.

- Legal
    - Comply with the legislation of each country (LGPD, Terms of Use, Retention Period for Data, etc.);

- Marketing
    - Track where each request comes from, etc.

---

## Architectural Features
### Operational
- Availability;
    - Will it be online 24/7? What level of availability do I want in my system? Should it be available in other countries?

- Disaster recovery;
    - How will I recover when my system is down? What if an AWS region goes down? Do I need multi-cloud?
    - Processes must be in place for these cases;

- Performance;
    - How much performance do I want in this system? 5000 requests per second? It will affect the choice of the database, replicas, ...

- Recovery (backup);
    - Test the backup periodically to make sure it's working.

- Reliability and security;
    - Prevent brute force attacks, password policies, captcha, ...

- Robustness;
    - Can it scale? Can it change region if one goes down? Do you have the necessary amount of IP, CIDR?

- Scalability;

### Structural
Characteristics of my software for it to function in a flexible way;

- Configurability
    - Use environment variables, abstractions, there should be no need to change the source code to deploy in different environments (dev, stage, prod).

- Extensibility
    - It should be able to grow in a way that things can be plugged into it, for example: Payment Gateway, changing from gateway x to y should be simple, work with interfaces, abstractions. The application should not depend on vendors (databases, gateways, modules, etc.).

- Easy installation
    - Standardization of the environment, Infrastructure as a Code, docker compose for development.

- Component reuse
    - Attach libraries so that all services can use them, for example: npm packages.

- Internationalization
    - For example, if the payment gateway changes, how will the conversion be handled? How about installment payments, etc.?

- Easy maintenance
    - Make the software simple, SOLID, understand the layers of the system. Fixing bugs and adding new features should become easy.

- Easy support (logs, debugging)
    - Standardization in log generation, observability, etc.

### Cross-Cutting
- Accessibility
    - Is it easy for others to access the site? What about people with disabilities? Use appropriate labels, lightweight images, etc.

- Data retention and recovery process (how long will the data be kept)
    - Storage is expensive. Do the data you have today really need to exist for 7, 30, or 60 days? Old data can be kept in different locations after a certain time to make the database cheaper.

- Authentication and Authorization
    - In a distributed architecture, how will it work? Use Keycloak? API Gateway?

- Legal
    - How long will the data be kept? Will it be encrypted?

- Privacy
    - How can you minimize problems related to user data leakage under LGPD? Avoid developers having access to the production database. Separate sensitive information into separate databases. Have a database with fake data for development?

- Security
    - Use web firewall and work with mechanisms that can identify robots, etc.

- Usability
    - How is the API organized? Is there documentation? Is there a readme? Who is my client?
    

---

## Designing Quality Software

### Performance
When it comes to developing software, performance is an essential factor. It's the software's ability to complete a specific workload. But how can we determine how well a software performs a particular action? To measure performance, we need data. The primary units of measurement for evaluating software performance are latency and throughput.

The units of measurement for evaluating software performance are:
- Latency or "response time" ⇒ Time it takes for a software application to process a request and complete a workload.
- Throughput ⇒ Number of requests a software application can handle.

Having a performative software is different from having a scalable software

Objective:
- Reduce latency, usually measured in milliseconds; It is affected by the application's processing time, network, and external calls
- Increase throughput, allow the software to handle more requests; It is directly linked to latency

**Main reasons for low performance:**
- Inefficient processing;
    - Ex: Algorithms, the way the application is handling data, poorly made queries, etc.

- Limited computational resources;
    - CPU, RAM, Memory,...

- Working in a blocking way;
    - Every time you make a request and if that request blocks the application to deal specifically with that request, the application will decrease throughput because it will not be able to handle thousands of requests in parallel.
    - Separate each request into a thread.

- Serial access to resources;
    - Every time you access an API you wait for it to finish and call the next one, one after the other, this decreases throughput.

**Main ways to increase efficiency:**
- Scale of computational capacity (CPU, Disk, Memory, Network);
- Logic behind the software (Algorithms, queries, framework overhead);
- Concurrency and parallelism; Dealing with multiple processes at the same time;
- Databases (types of databases, schema);
- Caching;


**Computational Capacity: Vertical Scale vs Horizontal Scale**
- Vertical Scale ⇒ Increase the computational capacity of the machine, so that the application can receive more requests;

- Horizontal Scale ⇒ Increase the number of machines by placing a load balancer in front to balance the loads;

**Concurrency and Parallelism**
"Concurrency is about dealing with many things at once. Parallelism is about doing many things at once."

- Concurrency ⇒ Deals with several things but they are not necessarily executed at the same time; When two or more tasks can start to be executed and finish in overlapping time periods, not meaning that they need to be in execution necessarily at the same time.

That is, you have concurrency when:
    - More than one task progresses at the same time in an environment with multiple CPUs/cores;
    - Or in the case of a single-core environment, two or more tasks may not progress at the exact same moment, but more than one task is processed in the same time interval, not waiting for one task to complete before starting another.

- Parallelism ⇒ Perform actions simultaneously. It happens when two or more tasks are executed, literally, at the same time. Obviously requires a processor with multiple cores, or multiple processors so that more than one process or thread can be executed simultaneously.


Imagining a web server with a worker:

**Serial way**
Working in a serial way - single process
Serving 5 requests

```docker
10ms -> 10ms -> 10ms -> 10ms -> 10ms 
------------------------------------
              50ms
```

**Concurrent/parallel way**

- 5 threads atendendo 1 request cada

```docker
10 ms ->
10 ms ->
10 ms ->
10 ms ->
10 ms ->
--------
  10ms
```

### **Caching**

Pegar coisas que já foram processadas antes e devolver de forma mais rápida para o usuário final.

- **Cache na borda / Edge computing**
    
    O usuário não chega a bater na máquina (ec2,ecs,lambda,...) pois esse tipo de cache vai cachear os dados em uma borda que fica antes do servidor principal.
    Ex de serviços: Cloudflare, Cloudfront.
    
    Cloudfront cachea os arquivos státicos (imagens, css, js, ...)em alguma availability zone e os usuários que estão próximos a elas vão receber os dados quase de forma instântanea
    
    Tipos de edge cache: 
    
    - Dados estáticos;
    - Páginas web;
    - Funções internas;
        - Evitar reprocessamento de algorítmos pesados colocando um TTL de 30min por ex;
        - Acesso ao banco de dados (Evitar I/O desnecessários).
    - Objetos;
    
    **Problema:** a netflix tem milhões de acesso em sua aplicação web, se o datacenter está nos estados unidos os usuários de todo o mundo vão ter que percorrer de seu local até o eua para pegar esses terabites de dados para poder acessar o site, congestionando a rede da netflix e a internet no geral e gerando bastante latência para acessar um conteúdo.
    
    **Solução: Edge computing**, cachear esses dados nas regiões onde seus usuários estão localizados, evitando que os usuarios precisem trafegar por toda a internet para bater no datacenter. Vai dar melhor experiencia para o usuario (baixa latencia) e a gente vai pagar menos pois vamos ter menos requisição nos nossos servidores.
    
    - Cache realizado mais próximo ao usuário. O usuários não precisa bater nos EUA para poder pegar uma imagem
    - Evita a requisição chegar até o Cloud Provider / Infra.
    - Normalmente arquivos estáticos. (Mais barato, Mais rápido)
    - CDN - Content Delivery Network; (Malha de servidores, espalha seu conteúdo para os outros data centers), EX: CDN da akamai → Mais de 500 pontos no Brazil, espalha seus conteúdos (Vídeos) para as regiões do Brazil.
        
        Se você ta em Portugal seu vídeo deve ser carregado de um CDN de Portugal
        
        Custo:
        
        - Custo da CDN
        - Custo de distribuição: Se a AKAMAI não estiver com o vídeo/imagem no CDN dela ela mesmo vai buscar o conteúdo no servidor (ex: us-east-1), baixar e disponibilizar para você, uma vez que ela baixou ela vai fazer algo chamado de Midgress, significa que agora vai pegar esse conteúdo e vai distribuir entre os pontos estratégicos, e esse espalhamento de conteúdo consome banda e você paga por esse tráfego para espalhar pelos edges. Origin → CDN → midgress →...
    - Cloudflare workers ⇒ Plataform de edge computing
    - Vercel
    - Akamai

### Escalabilidade

Escalabilidade é a capacidade de sistemas suportarem o aumento (ou a redução) dos workloads incrementando (ou reduzindo) o custo em menor ou igual proporção.

Enquanto performance tem o foco em reduzir a latência e aumentar o throughput, a escalabilidade visa termos a possibilidade de aumentar ou diminuir o throughput adicionando ou removendo a capacidade computacional.

Escala vertical - Escala horizontal

**Escalando software - Descentralização**

As máquinas são descartáveis, então seu sistema tem que ser independente da máquina que está sendo utilizada.

- **Disco efêmero →** Tudo que você salvar em disco pode ser apagado na hora que precisar. Precisamos do poder de matar a máquina na hora que quisermos.
- **Servidor de aplicação vs Servidor de assets →** Servidor tem o código da aplicação, assets ficam em um servidor de assets (s3 bucket).
- **Cache centralizado →** O cache não fica na própria máquina, fica em um servidor especifico para cache. ex: DynamoDB.
- **Sessões centralizadas →** O software não pode armazenar estado.
- **Upload / Gravação de Arquivos →** Bucket / servidor de arquivos

Tudo pode ser destruído e criado facilmente

**Escalando banco de dados**

- Aumentando recursos computacionais; Mais disco, memória, cpu,...;
- Distribuindo responsabilidades (escrita vs leitura); Criar réplicas;
- Shards de forma horizontal; Criar várias máquinas de leituras;
- Otimização de queries e índices;
- Serverless / Bancos cloud; (Dynamo, Aurora, Fauna,...);

Utilizar um sistema de APM (Application performance monitoring) para identificar os gargalos nas queries e problemas que estão acontecendo. 

- Explain na queries → identificar o que está acontecendo nas queries
- CQRS (Command Query Responsability Segregation)
- 

**Proxy reverso**

Proxy = Procurador, uma pessoa que fala em seu nome

Redireciona usuários,;

Proxy é um serviço que routea o trafico entre o cliente e outro sistema. ele pode regular o trafico de acordo com politicas presentes, enforçar segurança e bloquear IP desconhecidos.

Proxy reverso é um servidor que fica na frente de todos os servidores, ele possue regras, e essas regras fazem com que encaminhe a sua requisição para determinado servidores que possam resolve-lá . Diferente de proxy normal, que fica do lado do cliente, o proxy reverso é feito para proteger os servidores. ele aceita a requisição do cliente e encaminha a requisição para um ou mais servidores e retorna o resultado processado. O cliente se comunica diretamente com o reverse proxy e não sabe do servidor que processou.

**Solução de Proxy Reverso:**

- Nginx
- HAProxy (HA = High Availability)
- Traefik

### Resiliência

É um conjunto de estratégias adotadas intencionalmente para a adaptação de um sistema quando uma falha ocorre.

No software, se um erro acontecer ele apenas lança uma exception ? ou ele tem uma estratégia para que mesmo que dê erro atenda a requisição do cliente, mesmo que parcialmente.

Resiliéncia é o poder de se adaptar caso algo aconteça.

Como que eu consigo cadastrar o usuário mesmo que a API dos correios não esteja funcionando para pegar o CEP ? Como que eu consigo pegar essa venda se meu serviço de pagamento não está funcionando?

A unica coisa que temos certeza é que nosso software vai falhar em algum momento, porém temos que ter resiliência para lidar com essas falhas.

Ter estratégias de resiliência nos possibilita minimizar os riscos de perda de dados e transações importantes para o negócio.

**Estratégias de resiliências**

- **Proteger e ser Protegido**
    
    É muito comum hoje uma aplicação está baseada em um ecosistema com vários outros serviços. Um sistema em uma arquitetura distribuida precisa adotar mecanismos de autopreservação para garantir ao máximo sua operação com qualidade.
    
    Um sistema não pode ser “egoísta” ao ponto de realizar mais requisições em um sistema que está falhando.
    
    **Ex:** 
    
    Sistema A mandando requisição para saber a tabela de preço para o Sistema B, mas o sistema B não responde, e o sistema A fica mandando várias requisições em seguida, eventualmente o Sistema B vai sair do ar.
    
    Então um sistema não pode ficar mandando diversas requisições para outro até cair, não adianta chutar cachorro morto.
    
    Um sistema lento no ar muitas vezes é pior do que um sistema fora do ar. (Efeito dominó).
    
    **Ex:**
    
    Sistema A chama Sistema B que chama o Sistema C, se o sistema C está lento vai atrasar a resposta do B, que consequentemente vai atrasar a resposta do A, e se vem mais requisições chegando vai acabar derrubando algum serviço e eventualmente talvez todos.
    
    Então em alguns momentos se um sistema não está aguentando requisição é melhor retornar 500 para todo mundo até se estabilizar novamente.
    
    Uma forma de proteção é identificar que você não aguenta requisição ou que o outro serviço não está mais aguentando ou demorando demais para responder.
    
- **Health check**
    
    Verificar a saúde da aplicação;
    
    “Sem sinais vitais não é possível saber a saúde de um sistema”.
    
    Importante para saber se está podendo receber requisições ou não, ...., se estiver ruim já retorna um erro 500 para as outrar aplicações saberem se está indisponível.
    
    Um sistema que não está saudável possui uma chance de se recuperar caso o tráfego pare de ser direcionado a ele temporariamente.
    
    Self healing, dar um tempo para o servidor se auto recuperar, parar de mandar requisições para ele.
    
    **Health check de qualidade,** geralmente as pessoas só colocam uma rota /health para verificar se a aplicação está saudável, porém isso não consegue medir se a aplicação está saudável de verdade, pois nas outras rotas geralmente tem processamento, consulta ao banco, formatação de dados, etc.
    
- **Rate limiting**
    
    Protege o sistema baseado no que ele foi projetado para suportar.
    
    Para saber esse limite podemos fazer teste de estress e/ou orçamento da empresa para saber quanto tráfego pode ter.
    
    **Ex:** 100 requisições por segundo, “é até que eu aguento”, retorna um erro 500 caso ultrapasse.
    
    Também podemos trabalhar com prioridade, reservar 60 requisições para um cliente importante e 40 para o resto.
    

- **Circuit breaker**
    
    Proteje o sistema fazendo com que as requisições feitas para ele sejam negadas. EX: 500
    
    Se a api estiver dando problema o circuito abre o ‘interruptor’ e não permite mais a passagem de requisições.
    
    **Circuito Fechado =** requisições chegam normalmente;
    
    **Circuito Aberto** = requisições não chegam ao sistema. Erro instantâneo ao client;
    
    **Meio Aberto** = Permite uma quantidade limitada de requisições para verificação se o sistema tem condições de voltar ao ar integralmente.
    
- **API Gateway**
    
    Centraliza o recebimento de todas as requisições da aplicação, toda as requisições passam por ela e ela aplica as regras politicas/validação para depois fazer o forward da requisição para quem vai resolver.
    
    Consegue entender as necessidades individuais de cada aplicação.
    
    Garante que requisições ‘inapropriadas’ cheguem até o sistema:
    
    Ex: usuário não autenticado.
    
    Tiramos a responsabilidade de autenticação da aplicação e passamos para o API Gateway, só de fazermos isso já reduzimos o gasto de recurso para verificar se o usuário está autenticado ou não.
    
    É como se morassemos em um condomínio e a pessoa só entra no apartamento se passar pela portaria (API Gateway) antes.
    
    Implementa políticas de Rate Limiting, Health check, etc...
    
    Ex de serviços: Kong
    
- **Service mesh**

Controla o tráfego de rede.

Ao invés de os serviços se comunicarem diretamente entre si eles batem em um proxy chamado sidecar e esse sidecar manda a requisição para o sidecar de outro sistema.

```docker
[ Sistema A ] (Sidecar) ----> (Sidecar) [Sistema B]
```

Toda comunicação de rede é efetuada via proxy, assim tudo que está passando na rede pode ser controlado.

Evita implementações de proteção pelo próprio sistema.

Você consegue analisar tudo que está acontecendo na rede, todo tráfego, e com isso consegue definir as regra de Rate Limiter, Circuit Breaker,...

mTLS → encryptografar a rede para se certificar que o Serviço A é ele mesmo e o B é ele mesmo.

- **Comunicação assíncrona**

Com menos recurso computacional consegue dar vazão a mais recurso computacional do que poderia dar.

Não precisa entregar a resposta das requisições imediatamente.

Evita perda de dados;

Não há perda de dados no envio de uma transação se o server estiver fora;

**Ex:** de forma sincrona se fizermos um pagamento e o servidor não estiver de pé vai dizer para tentar novamente mais tarde, porém, de forma assíncrona permite a gente manda a mensagem/informação para um intermediário (Redis, RabbitMQ, AWS SNS, Kafka,...) para lidar com a ação pois a outra ponta não precise da resposta naquele momento.

Servidor pode processar a transação em seu tempo quando estiver online;

- **Garantias de entrega com Retry**

Quando a gente quer resiliência na requisição precisamos ter certeza que a mensagem que estamos enviando ela está chegando no destino, agora nem sempre a mensagem pode chegar pois o outro sistema pode estar lento, fora do ar, ... e por conta disso uma das formas de ter resiliencia e minimizar esse problema é termos politicas de Retry, manda uma mensagem, se o sistema não responder manda outra, e outra,...

Porém temos um **problema**, se 10 serviços mandam uma req e o servidor não aguenta 10 requisições simultaneas, mesmo se os outros servidores tiverem policitas de retry e ficarem mandando mensagem de 2 em 2s não vai adiantar pois todos estão tentando acessar o servidor ao mesmo tempo e assim sempre vai retornar erro.

Para isso temos o **Exponential backoff - Jitter,** fazemos uma espera de forma exponencial 2s, 4s, 8s, 16s,..., para dar mais tempo ao servidor se recuperar e com o Jitter ele tem um algoritimo que vai adicionar um ruído aleatorio nas requisições para que não aconteçam de forma simultânea, ex: (2.1s, 2.5, 2.0), (4.7, 4.01, 4.12,...) para que mesmo que os serviços estejam mandando de forma simultânea o ruído vai fazer com que cheguem de forma diferente.; 

- **Garantias de entrega com Kafka**

- **Situações complexas**
    - O que acontece se o message broker cair? (Kafka, RabbitMQ, SNS,...)
    - Haverá perda de mensagens?
    - Seus sistema ficará fora do ar?
    - Como garantir resiliência em situações inusitadas?
    
    Sempre temos alguns SPF (Single point of failure).
    
    Por exemplo, se toda resiliencia que você vai se apoiar é no Apache Kafka significa que o seu SPF está no Apache Kafka.
    
    Como que conseguimos evitar isso? para que se o kafka cair o sistema não perca informações ?
    
    Isso tudo envolve gerenciamento de risco, quanto mais resiliência garantimos mais caro vai sair para a empresa.
    
    Se a AWS cair ? Vale a pena trabalhar com multi cloud ?
    
    Sempre vai ter um limite a sua resiliência, quanto mais resiliência, mais esforço e mais custo.
    
    A responsabilidade de definir qual o nível de resiliência do sistema é do CTO / CEO que define o risco que aquilo vai gerar para o negócio.