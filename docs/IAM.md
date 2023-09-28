# Identity and Access Management (IAM)

## What is identity and access management (IAM)?

Identity and access management provides **control over user validation and resource access**. Commonly known as IAM, this technology ensures that the right people access the right digital resources at the right time and for the right reasons. IAM solution is a gatekeeper to the resources you provide to customers as web applications, APIs, etc.

IAM includes authentication, authorization, and administration. **Authentication** is the process of verifying the identity of a user, device, or other entity. **Authorization** is the process of verifying that the authenticated user has access to the requested resource. **Administration** is the process of managing digital identities and controlling access to resources.

## IAM basic concepts

To understand IAM, you must be familiar with some fundamental concepts:

- A **digital resource** is any combination of applications and data in a computer system. Examples of digital resources include web applications, APIs, platforms, devices, or databases.

- The core of IAM is **identity**. Someone wants access to your resource. It could be a customer, employee, member, participant, and so on. In IAM, a **user account is a digital identity**. User accounts can also represent non-humans, such as software, Internet of Things devices, or robotics.

- **Authentication** is the process of verifying the identity of a user, device, or other entity. Authentication is the first step in the process of access control. Someone (or something) authenticates to prove that they're the user they claim to be.

- **Authorization** is the process of verifying that the authenticated user has access to the requested resource. Authorization is the second step in the process of access control. Someone (or something) is authorized to access a resource if they have permission to do so.

## Authentication vs Authorization

Authentication and authorization are two different processes. Authentication proves a user’s identity, while authorization grants or denies the user’s access to certain resources.

**Authentication**: When you enter the building, you must show your photo ID badge to the security guard. The guard compares the photo on the badge to your face. If they match, the guard lets you through the door to try to access different areas of the building. The guard doesn’t tell you what rooms you can access; they only get proof that you are who you claim to be. This is authentication: confirming user identity.

**Authorization**: In this scenario, imagine the elevators and doorways in the building have key sensors for access. The chip in your badge gives you access only to the first floor, which your company occupies. If you swipe your badge to enter any other floor, your access is denied. You can access your private office but not those belonging to your colleagues. You can enter the supply room but not the server room. This is authorization: granting and denying access to different resources based on identity.

## What does IAM do?

Identity and access management gives you control over user validation and resource access:

- How users become a part of your system
- What user information to store
- How users can prove their identity
- When and how often users must prove their identity
- The experience of proving identity
- Who can and cannot access different resources

You integrate IAM with your application, API, device, data store, or other technology. This integration can be very simple. For example, your web application might rely entirely on Facebook for authentication, and have an **all-or-nothing authorization policy**. Your app performs a simple check: if a user isn’t currently logged in to Facebook in the current browser, you direct them to do so. Once authenticated, all users can access everything in your app.

It’s unlikely that such a simple IAM solution would meet the needs of your users, organization, industry, or compliance standards. In real life, IAM is complex. Most systems require some combination of these capabilities:

- **Seamless signup and login experiences** — Smooth and professional login and signup experiences occur within your app, with your brand’s look and language.

- **Multiple sources of user identities** — Users expect to be able to log in using a variety of social (such as Google or Linkedin), enterprise (such as Microsoft Active Directory), and other identity providers.

- **Multi-factor authentication (MFA)** — In an age when passwords are often stolen, requiring additional proof of identity is the new standard. Fingerprint authentication and one-time passwords are examples of common authentication methods.

- **Step-up authentication** — Access to advanced capabilities and sensitive information require stronger proof of identity than everyday tasks and data. Step-up authentication requires additional identity verification for selected areas and features.

- **Attack protection** — Preventing bots and bad actors from breaking into your system is fundamental to cybersecurity.

- **Role-based access control (RBAC)** — As the number of users grows, managing the access of each individual quickly becomes impractical. With RBAC, people who have the same role have the same access to resources.

Facing this level of complexity, many developers rely on an IAM platform instead of building their own solutions.

## How does IAM work?

IAM is not one clearly defined system. IAM is a disciplina and a type of framework for solving the challenge of secure access to digital resources. Thers is no limit to the different approaches for implementing an IAM system.

IAM systems are often built using a combination of these components:

- **Identity provider (IdP)** — An identity provider is a service that authenticates users and gives them access to resources. IdPs are the core of IAM. They are the source of truth for user identities. IdPs can be built in-house or purchased from a third-party vendor.

      In the past, the standard for identity and access management was for a system to create and manage its own identity information for its users. Each time a user wanted to use a new web application, they filled in a form to create an account. The application stored all of their information, including login credentials, and performed its own authentication whenever a user signed in.

      As the internet grew and more and more applications became available, most people amassed countless user accounts, each with its own account name and password to remember. There are many applications that continue to work this way. But many others now rely on identity providers to reduce their development and maintenance burden and their users’ effort.

      An **identity provider** creates, maintains, and manages identity information, and can provide authentication services to other applications. For example, Google Accounts is an identity provider. They store account information such as your user name, full name, job title, and email address. Slate online magazine lets you log in with Google (or another identity provider) rather than go through the steps of entering and storing your information anew.

      **Identity providers don’t share your authentication credentials with the apps that rely on them**. Slate, for example, doesn’t ever see your Google password. **Google only lets Slate know that you’ve proven your identity**.

      Other identity providers include social media (such as Facebook or LinkedIn), enterprise (such as Microsoft Active Directory), and legal identity providers (such as Swedish BankID).

- **Authentication Factors** - Authentication factors are the different ways/methods that a user can prove their identity. The most common authentication factors are (IAM systems require one or many authentication factors to verify identity.):

      - **Knowledge (something you know)** — Something the user knows, such as a password, PIN, or the answer to a security question.

      - **Possession (something you have)** — Something the user has, such as a mobile phone, hardware token, or smart card.

      - **Inherence (something you are)** — Something the user is, such as a fingerprint, retina, or face.

      - **Location (somewhere you are)** — Somewhere the user is, such as a specific IP address or GPS coordinates.

      - **Time** — When the user is trying to access the resource, such as a specific time of day or a time-limited one-time password.

      - **Behavioral** — How the user behaves, such as their typing speed or the way they move their mouse.

      - **Transaction** — The transaction itself, such as the amount of money being transferred or the type of data being accessed.

- **Authentication and Authorization Standards** - Authentication and authorization standards are open specifications and protocols that define how authentication and authorization work and provides guidance on how to: Design IAM system, Move personal data securely, decide who can access resources, and more. These IAM industry standards are considered the most secure, reliable, and pratical to implement:

      - **OAuth 2.0** — OAuth 2.0 is a delegation protocol for accessing APIs and is the industry-standard protocol for IAM. An open authorization protocol, OAuth 2.0 lets an app access resources hosted by other web apps on behalf of a user without ever sharing the user’s credentials. It’s the standard that allows third-party developers to rely on large social platforms like Facebook, Google, and Twitter for login.

      - **OpenID Connect (OIDC)** — OIDC is an authentication standard that uses JSON Web Tokens (JWTs) to pass identity information between identity providers and applications. OIDC is built on top of the OAuth 2.0 authorization framework. OIDC makes it easy to verify a user’s identity and obtain basic profile information from the identity provider. OIDC is another open standard protocol.

      - **JSON web tokens (JWTs)** - JWTS are an open standard that defines a compact and self-contained way for securely transmitting information between parties as a JSON object. JWTs can be verified and trusted because they’re digitally signed. They can be used to pass the identity of authenticated users between the identity provider and the service requesting the authentication. They also can be authenticated and encrypted.

      - **Security Assertion Markup Language (SAML)** — SAML is an open-standard, XML-based data format that lets businesses communicate user authentication and authorization information to partner companies and enterprise applications that their employees use.

      - **WS-Federation** — Developed by Microsoft and used extensively in their applications, this standard defines the way security tokens can be transported between different entities to exchange identity and authorization information.

## Popular IAM solutions

- **Auth0**
- **Okta**
- **Keycloak (open-source)**

## Refs

- [Auth0 identity-and-access-management](https://auth0.com/docs/get-started/identity-fundamentals/identity-and-access-management)
