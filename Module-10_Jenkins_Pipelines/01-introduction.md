# Jenkins Pipeline

## 01. What is a `Jenkins Pipeline`?

- A Pipeline is a definition of a Jenkins job that can have multiple stages.
- Each pipeline stage has a step section that includes commands which should be executed in order to complete that particular stage.
- With the pipeline, we define how Jenkins should complete the CI/CD process (invoke code, compile, build, unit test, review etc) for our applications.

## 02. Types of Jenkins Pipeline Definition

1. **Declarative Pipeline**

   - Written in Jenkins DSL language
   - Comparitively easy to understand & write

2. **Scripted Pipeline**
   - Written in groovy language
   - Comparitively more feature rich and customizable

## 03. Introduction to `Jenkinsfile`

- Reference: https://www.jenkins.io/doc/book/pipeline/jenkinsfile/
