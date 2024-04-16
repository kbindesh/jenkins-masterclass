# Managing plugins in Jenkins

## 01. What are `Plugins`?

- The software build lifecycle usually includes phases like pulling the source code from a source code management tool, compiling the source code, unit and integration testing, and then building the application and finally releasing it.
- To let your application go through those phases, you need to use different type of tools, like SCM tools, unit or integration testing tools, build tools, etc.
- Jenkins needs to communicate with those tools as part of executing the end-end build lifecycle. Jenkins uses plugins to communicate with these tools.

## 02. The `Jenkins Plugin manager`

- A **Jenkins plugin** is a software component that adds a specific feature to installed Jenkins instance.
- There are various plugins developed by the Jenkins team to customize the usage of Jenkins.
- Some of the commonly used Jenkins plugins are:
  - Git
  - Maven
  - Email Extension
  - Amazon EC2
  - AWS CodeDeploy
  - Terraform
  - Jira
  - Docker
  - Kubernetes
  - SonarQube
- In order to **locate Jenkins plugin manager**, follow below steps:

  1. Log into **Jenkins** server.
  2. From **Jenkins Dashboard** >> **Manage Jenkins** >> **Manage Plugins**. It will open the Plugin Manager page.

- There will be multiple tabs under Jenkins plugin manager window:
  - **Updates**
  - **Available**
  - **Installed**
  - **Advanced**

## 03. Installing the Jenkins plugin

You may follow the below steps to install the required jenkins plugins:

- Log into Jenkins Server (GUI) and you will land on dashboard.
- Click on **Manage Jenkins** link >> **Manage Plugins**.
- Under **Available** tab, search for plugin name like maven, Amazon EC2 etc. >> Click on **Install** button.
