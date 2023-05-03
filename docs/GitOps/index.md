# GitOps

## Traditional Approach

Before dive into what GitOps is, it's important to understand how applications deployment was done, the traditional approachs..., how developers used to rollout applications version, and how they used to create infrastructure components, this way, it's easier to undestand the problems that the GitOps approach solves.

**Traditional approach**

Back then, applications were deployed using imperative scripts or manual processes, developers would roll out new versions of their applications by logging into servers and running scripts or commands to manually update the code and dependencies.

for example, a developer that is working on a project feature will merge the changes in the main branch, ssh the virtual machine that is hosting that service, execute the commands to manually pull the changes, install dependencies, and re-run the service

In nodejs for example:

```bash
ssh -i "key.pem" ec2-user@ec2-ip.compute-1.amazonaws.com

git clone ...

npm install

npm start
```

Best case scenario, this approach will have a pipeline defined to execute the imperative scripts, but there are a lot of developers that still do this manually.

This way you have the application running with the new version.

This approach has a lot of problems:

- time-consuming;
- error-prone;
- developers can easily make mistakes or overlook steps when running scripts manually, leading to issues and downtime. 
- hard to track changes and ensure consistency across environments.
- difficult to rollback changes in case something happen.
- hard to know the current state of your infrastructure.
- ...

Despite these challenges, some developers and companies still use the old approach today. Perhaps they lack the knowledge or resources to adopt a new methodology, or they simply don't see the value in changing their ways. But the reality is that this approach is not reliable and can hold back innovation and development speed because this approach is script-based, the system configuration is tipically based in imperative scripts, in which is a sequence of steps to setup the system and reach a desired state

I think you undesrstood the number of problems with this approach so far, needless to say that you have to create all infra components manually and if you're working with multiple environments you have to do this operation for each env (dev, stage, prod...)

And because of these problems, using an declarative approach is extremely important to a modern software development to companies of all sizes

## GitOps

In a few words, GitOps is infrastructure as Code (IaC), but it goes far beyond that.

**GitOps is an evolution of IaC with a recommended DevOps practice that utilize Git as the only source of truth and a pipeline to create/update/destroy the infrastructure, application or system architecture.**

GitOps leverages Git as a single source of truth for both application code and infrastructure configuration, making it easier to manage and automate the deployment process. With GitOps, developers can define their desired state for an environment in code and use Git to manage changes to that code over time. This ensures that infrastructure changes are tracked, versioned, and auditable, and makes it easier to roll back changes if needed.

There are a lot of tools that allow us to create IaC such as Terraform, Ansible, Serverless Framework, CloudFormation, Crossplane, and others. However, to fully adopt GitOps, it's important to use these tools in conjunction with a Git-based deployment pipeline.

Remember, *Is not only by using one of these IaC tools that you're adopting GitOps*, if you're still running local commands to apply these changes then there is a gap in there and you can't rely on git to know your system state.

For example, let's say you're using Terraform to manage your infrastructure. With GitOps, you would define your infrastructure as code in Terraform, and store it in a Git repository. You would also define a deployment pipeline that automatically updates your infrastructure based on changes to the code in that repository.

You might also use a pull-request strategy so that once the changes are approved and merged into the main branch, the pipeline would automatically deploy them to production.

By using this approach, you can ensure that your infrastructure changes are tracked and versioned in Git, and that your deployment process is automated and auditable. This makes it easier to manage your infrastructure at scale.

**Benefits**

- declarative approach (follows a declaration of an expected state rather than a sequence of commands.), easier to know and understand what's in your environment
- reduce errors and downtime
- enable more rapid innovation and experimentation
- consistent state


### GitOps Approachs

- push-based

- pull-based
