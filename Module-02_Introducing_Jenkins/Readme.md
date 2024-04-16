# Introducing Jenkins

## 01. Jenkins Overview

- **Jenkins** is an open source _Continuous Integration_ tool.
- Jenkins can be used to achieve **Continuous Delivery**, **Continuous Testing** and **Continuous
  Deployment**.
- Jenkins is supported by a large number of plugins that enhance its capability.
- The Jenkins tool is written in Java and so are its plugins.
- The tool has a simplistic GUI that can be enhanced using specific plugins if required.

## 02. What is `Jenkins` is made of?

- The Jenkins framework mainly contains jobs, builds, parameters, pipelines and plugins. Let's look at them in detail.

### 2.1 Jenkins job (also known as projects)

At a higher level, a typical Jenkins job contains a _unique name_, _description_, _parameters_, _build steps_, and _post-build actions_.

- **Jenkins Parameters**

  - Jenkins parameters can be anything: environment variables, interactive values, pre-defined values, links, triggers, and so on.
  - Their primary purpose is to assist the builds.
  - They are also responsible for triggering pre-build activities and post-build
    activities.

- **Jenkins Build**

  - A Jenkins build (not to be confused with a software build) can be anything from a simple Windows batch/linux command to a complex Perl script.
  - The range is extensive, which include Shell, Perl, Ruby, and Python scripts or even Maven and Ant builds.
  - There can be number of build steps inside a Jenkins job and all of them run in sequence.

- **Jenkins post-build actions**
  - Post-build actions are parameters and settings that define the subsequent steps to be performed after a build.
  - For example, we can have a post-build action in our current job, which in the event of a successful build starts another Jenkins job.

### 2.2 Jenkins pipeline

- _Jenkins pipeline_, in simple terms, is a group of multiple Jenkins jobs that run in sequence or in parallel or a combination of both.
- For example, there can be below listed five separate Jenkins jobs, all running one after the other:
  - Static code analysis
  - Integration testing
  - Publish to artifactory
  - Deploy to Testing server
  - User Acceptance Testing (UAT)

### 2.3 Jenkins plugins

- _Jenkins plugins_ are additional set of programs that enhance the Jenkins capabilities to work with various external tools.
- Plugins after installation, manifest in the form of either system settings or parameters inside a Jenkins job.
- For example, SonarQube tool (a static code analysis tool configuration settings in your job will be made available only after installing the Jenkins plugin for SonarQube named _sonar_.
