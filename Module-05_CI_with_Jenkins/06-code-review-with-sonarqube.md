# Static Code Analysis with SonarQube

- The Jenkins CI pipelines also include tasks that perform Continuous Inspection i.e inspecting code for its quality in a continuous manner.

- Tools such as `SonarQube` help us to achieve static code analysis to improve code quality.
- Every time a code gets checked in into SCM repo, it is analyzed. This analysis is based on some rules defined by the code analysis tool.
- If the code passes the error threshold, it's allowed to move to the next step in its life cycle
- If it crosses the error threshold, it's dropped.

## 00. SonarQube Overview

- **SonarQube** is an open source tool that supports almost all popular programming languages with the help of plugins.
- **SonarQube** can also be integrated with a CI tool such as Jenkins to perform Continuous Inspection.

## 01. Download and Configure SonarQube

### Step-01: Download the SonarQube

- Download the SonarQube from the official download page: <br/>
  https://www.sonarsource.com/products/sonarqube/downloads/

- Once SonarQube is successfully downloaded, extract it to C:\Program Files\.
- I've extracted to C:\Program Files\sonarqube-10.5.1.90531

### Step-02: Setting the Sonar environment variables

- Set the **%SONAR_HOME%** environment variable to the installation directory

  ```
  setx SONAR_HOME "C:\Program Files\sonarqube-5.1.2" /M
  ```

- To verify the SONAR_HOME environment variable:

  ```
  echo %SONAR_HOME%
  ```

### Step-03: Running the SonarQube application

- Launch the **command prompt** with Administrative privileges.
- Move to the directory where the scripts to install and start SonarQube are present:

  ```
  cd %SONAR_HOME%\bin\windows-x86-64
  ```

- To install SonarQube, run the **SonarService.bat** script.
- To start SonarQube, run the **StartSonar.bat** script.

- To access SonarQube, type the following link in your web browser
  http://localhost:9000/.

:warning: There are no user accounts configured in SonarQube. However, by default, there is an admin account with the username **admin** and the password **admin**.

### Step-04: Creating a SonarQube Project

- Log in as an _admin_ by clicking on the Log in link at the top-right corner on the Sonar dashboard.
-

### Step-05:

## 02. Installing SonarQube Scanner

## 03. Installing Artifactory (binary repository)

## 04. Configuring Jenkins plugin for SonarQube

## 05. Configuring Jenkins plugin for Artifactory

## 06. Creating the Jenkins pipeline to poll the Integration branch
