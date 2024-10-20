# Configuring Jenkins Server

In this section, we will configure Jenkins server with following components:

- Jenkins Git plugin
- Configuring Java on Jenkins
- Configuring Maven on Jenkins
- Installing email extension plugin

## 01. Installing Git plugin

In order to integrate Git with Jenkins, we need to install the GIT plugin.

1. From the Jenkins Dashboard, click on the **Manage Jenkins** link.
2. Click on the **Plugins** link and go to the **Available** tab.
3. Type *Git*in the search box >> Select _Git plugin_ from the list and click on the Install without restart button.
4. The download and installation starts automatically. You can see the Git plugin has a lot of dependencies that get downloaded and installed.

## 02. Configuring Java for Jenkins (on Windows)

### Step-01: Setting the Java environment variables

- To configure the Java environment variable **JAVA_HOME** from command prompt, run following command:

  ```
  setx JAVA_HOME "C:\Program Files\Java\jdk-21" /M
  ```

- To check the home directory of Java, use the following command:

  ```
  echo %JAVA_HOME%

  # You should see the java home directory path
  ```

- Now, add the Java executable path to the system **PATH** variable using the following command:

  ```
  setx PATH "%PATH%\;C:\Program Files\Java\jdk-21\bin" /M
  ```

### Step-02: Configuring `JDK` inside Jenkins server

Once you're done with the Java installation and configured the required system variables, let Jenkins also know about the JDK installation.

- Navigate to Jenkins Dashboard >> click on the **Manage Jenkins** link.

- On the Manage Jenkins page, Under _System Configuration_ section, click on the **Tools** link.
- Scroll down to _JDK_ section
  - **Name**: JDK21
  - **JAVA_HOME**: Your JDK installation path (e.g. C:\Program Files\Java\jdk-21)

## 03. Installing and Configuring `Maven`

### Step-3.1: Installing Maven

- Download Maven from the following link: <br/>
  https://maven.apache.org/download.cgi.

- For **Windows** systems, download the **binary zip archive** file
- Extract the downloaded zip file to **C:\Program Files\Apache\\** directory.

### Step-3.2: Setting the Environment variables and `System Path for Maven

- In this section, we will set following Maven environment variables:

  - **M2_HOME**

  - **M2**
  - **MAVEN_OPTS**

- Open **Command prompt** and run the following commands:

  ```
  setx M2_HOME "C:\Program Files\Apache\apache-maven-3.9.6" /M

  setx M2 "%M2_HOME%\bin" /M

  setx MAVEN_OPTS "-Xms256m -Xmx512m" /M
  ```

- To check the above configured variable values, execute the following commands:

  ```
  echo %M2_HOME%

  echo %M2%

  echo %MAVEN_OPTS%
  ```

- Now, add the Maven **bin** directory location to the system path:

  ```
  setx PATH "%PATH%;%M2%" /M
  ```

- To check if Maven has been installed properly:

  ```
  mvn --version
  ```

### Step-3.3: Configuring Maven inside Jenkins

- Navigate to Jenkins Dashboard >> click on the **Manage Jenkins** link.

- On the Manage Jenkins page, Under _System Configuration_ section, click on the **Tools** link.
- Scroll down to _Maven_ section
  - **Name**: Maven 3.9.6
  - **MAVEN_HOME**: Your Maven directory path (e.g. C:\binaries\apache-maven-3.9.6)

## 04. Installing email-extension plugin
