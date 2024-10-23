# Configure Pipeline as Code Job In Jenkins

## Objective

- Implement Continuous Integration (CI) process using:
  - **GitHub as SCM**
  - **Jenkins as Automation server**
  - **Jenkins job type** as **Pipeline**
  - **Maven** as a **build tool**

## Prerequisites

- **Jenkins Controller** (or Master | EC2 Instance | Name: jenkins-server)

- **Jenkins Agent** (or Slave | EC2 Instance | Name: maven-build-server)

- **Github repository** with Java App code

- **Access to GitHub repository** (your java app) from your Jenkins Agent

## Step-xx: Setup Jenkins Controller node

- JDK-17
- Jenkins
- Git

## Step-xx: Install Jenkins Plugins

- [Pipeline](https://plugins.jenkins.io/workflow-aggregator/)
- [Pipeline: Stage view](https://plugins.jenkins.io/pipeline-stage-view/)
- [build-discarder](https://plugins.jenkins.io/build-discarder/)
- [workspace-cleanup](https://plugins.jenkins.io/ws-cleanup/)

## Step-xx: Develop the Jenkinsfile

- You can use this [Jenkinsfile](./pipelines/Jenkinsfile) for this lab

## Step-xx: Configure Maven home path in Jenkins (Global Tool Configuration)

## Step-xx: Creating & Building a Jenkins Pipeline Job

## Step-xx Executing Jenkins Pipeline From Github (Jenkinsfile)
