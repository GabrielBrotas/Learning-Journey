# Architectural Features

## Operational
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

## Structural
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

## Cross-Cutting
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