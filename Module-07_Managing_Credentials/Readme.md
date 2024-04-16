# Managing credentials in Jenkins

## 01. Understanding `credential` in Jenkins

- There are different kinds of authentication techniques used by tools, such as Git, Nexus etc., to authenticate the user.
- The following authentication techniques are mainly used:

  - **Basic authentication**

  - **SSH authentication**

  - **API token**

  - **Certificate**

- The **Jenkins Credentials plugin** allows you to create credentials of different types in order to store the required authentication information.
- Once the credential record has been created, you can refer to it by using the Credentials ID in the Jenkins job or pipeline with the help of the Credentials Binding plugin.

## 02. Understanding `Scope` and `Domain` in Jenkins credential management

## 03. Creating a Credential in Jenkins
