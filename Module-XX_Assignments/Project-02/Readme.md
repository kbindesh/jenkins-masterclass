# Project-02: Create Continuous Integration Pipeline using GitHub, Jenkins, SonarCloud and JFrog

## Prerequisites

- An AWS Account
- GitHub repository with a maven based java application. You may refer to this sample java app: https://github.com/kbindesh/mvn-lab-project/tree/main

## Step-01: Setup Jenkins Server (Master node)

### Step-1.1: Create an EC2 Instance and Configure as Jenkins server

- [Refer this link for step-by-step process](https://github.com/kbindesh/jenkins-masterclass/tree/main/Module-03_Setting_up_Jenkins/01-jenkins-on-amazon-linux)

### Step-1.2: Install required Jenkins Plugins

- Navigate to Jenkins dashboard >> Manage Jenkins >> Plugins >> Available Plugins
- Search and Install following plugins:
  - Maven Integration
  - Maven Invoker
  - GitHub
  - Pipeline
  - Pipeline: Stage View

## Step-02: Setup Jenkins Agent (Maven Build Server | Slave node)

### Step-2.1: Provision a Virtual Machine (EC2 Instance)

- Sign-in to AWS Account (https://console.aws.amazon.com/).
- Navigate to EC2 service >> Launch Instance.
- Name: Jenkins-Server
- AMI: Amazon Linux 2 (Kernel 5.10)
- Instance Type: t2.micro
- Key Pair: <your_existing_keypair>
- VPC/Subnet: Default
- Elastic IP: Enable
- Security Group: <create_new_sg>
  - Ingress: Allow Ingress - SSH (22) from Jenkins Master node IP
- Storage: 10 GB, GP2 (min for this lab)
- Click on Launch Instance button

### Step-2.2: Install and Configure Java

- Official link for java download: https://www.oracle.com/in/java/technologies/downloads/

```
# Switch to root user
sudo su -

# Install Java as a pre-requisites for jenkins installation
sudo yum install -y java-17-amazon-corretto.x86_64

# To verify java installation
java --version
```

- **Setup JAVA_HOME path with java home directory location**

```
find /usr/lib/jvm/java* | head -n 3
[From the preceding command, copy "/usr/lib/jvm/java-17-amazon-corretto.x86_64" path]

vi ~/.bash_profile

# Create a new variable JAVA_HOME
JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64

# Add JAVA_HOME to the existing path
PATH=$PATH:$HOME/bin:$JAVA_HOME
```

- **Verify the Java path**

```
echo $PATH
[The preceding command will give you the updated PATH]

# In order to refresh the path
source ~/.bash_profile

# Again, display the PATH to get the updated values
echo $PATH
```

### Step-2.3: Install and Configure Maven

- Apache maven official download page: https://maven.apache.org/download.cgi

- Now, download and configure Apache Maven

```
# Move to /opt directory
cd /opt

# Download the maven binary
wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz

# Unzip the downloaded maven tarball
tar -xvzf apache-maven-3.9.8-bin.tar.gz

# List all the file to see the unzipped maven directory
ls -l apache-maven-3.9.8

# Get inside the maven home directory
cd apache-maven-3.9.8
```

- **Setup Maven home path | M2_HOME & M2 variables**

```
# Update the bash profile with maven path
vi ~/.bash_profile

# Create M2_HOME and M2 variable with maven location specs
M2_HOME=/opt/apache-maven-3.9.8
M2=/opt/apache-maven-3.9.8/bin

# Update the PATH variable | Add Maven path
PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2

[Save the file and exit]

source ~/.bash_profile

# Verify the PATH with java and maven variables
echo $PATH
```

### Step-2.4: Install Git

```
yum install -y git
```

## Step-03: Add Maven server as an Agent on Jenkins Master node

### Step-3.1: Create a new user on Maven build server (slave machine) for Jenkins communication

- Connect to your Maven server (ec2 instance) over SSH.

```
# Switch to sudo user
sudo su -

# List all the existing users
cat /etc/passwd

# Create a new user
useradd jenkins

# Set the password for jenkins user
passwd jenkins

# Add the jenkins user to the sudoers file
visudo

[Press "G" to go to the end of the file and press "i" to go in insert mode]

## Allow root to run any command anywhere
root    ALL=(ALL)     ALL
jenkins ALL=(ALL)     NOPASSWD: ALL
```

- Enable password based authentication

```
vi /etc/ssh/sshd_config

[Search for PasswordAuthentication]

# Uncomment the line
PasswordAuthentication yes

# Refresh sshd service
service sshd reload
```

### Step-3.2: Add `Maven server` as new node on `Jenkins Master node`

- Open Jenkins Dashboard >> Nodes >> New Node
- Node Name: maven-build-server
- Permanent Agent: Enable
- `# of executors`: 5
- Remote Root Directory: /home/jenkins
- Launch Method: Launch Agent via SSH
  - Host: <private_ip_of_the_maven_server>
  - Credentials >> Add
    - Username: jenkins
    - Password: <jenkins_user_passwd_you_configured_in_prev_step>
    - ID: jenkins
  - Select the created credentials from the dropdown list.
- Host key verification strategy: Non verifying verification strategy

### Step-3.3: Verify the connection with Maven build agent

- Jenkins Dashboard >> Manage Jenkins >> Nodes >> maven_build_server
- You should see agent added without a warning sign. Also check it in the logs.

## Step-04: Configure Maven and Java installation path on Jenkins master

- Navigate to Jenkins server dashboard >> Manage Jenkins >> Tools

- **JDK**

  - Name: Java-17
  - JAVA_HOME: /usr/lib/jvm/java-17-amazon-corretto.x86_64

- **Maven** - location of maven installation on Maven slave machine (not on Jenkins master node)
  - Name: Maven-3.9.8
  - MAVEN_HOME: /opt/apache-maven-3.9.8

## Step-05: Develop Jenkinsfile with build stages

### Step-5.1: Create a Jenkinsfile

- Launch any IDE (Visual Studio Code) on your system and open your maven project folder into it.

- Create a new file as **Jenkinsfile** and add the following code to it:

```
pipeline {

    // The agent name must match with the jenkins node name (Manage jenkins -> Nodes)
    agent {
        node {
            label 'maven-build-server'
        }
    }

    // The tool name must match with the jenkins tools (global configuration) variable names
    tools {
        maven 'Maven-3.9.8'
    }

    // Define environment variables
    environment {
        APP_NAME = "BINDESH_APP"
        APP_ENV  = "PRODUCTION"
    }

    // Cleanup the jenkins workspace before building an Application
    stages {
        // Build the application code using Maven
        stage('Code Build') {
            steps {
                 sh 'mvn install -Dmaven.test.skip=true'
            }
        }
    }
}
```

### Step-4.2: Push the Jenkinsfile into GitHub repository

```
# Stage the changes
git add .

# Commit the changes
git commit -m "Created Jenkinsfile with build stages"

// To check if the origin is pointing to the correct github repo
git remote -v

// Push the Jenkinsfile to remote github repo
git push origin main
```

## Step-05: Save GitHub Credentials on Jenkins server (Master)

- **NOTE**: Here, I'm assuming that our GitHub repository is a **Private repository**.
- Navigate to Jenkins Dashboard >> Manage Jenkins >> Credentials >> New Credential

## Step-xx: Create & Execute Jenkins Job (Pipeline) to build the app on Maven slave node

## Step-xx: Verify the Job execution on Agent node

## Step-xx: Setup Github Webhook

## Step-xx: SonarCloud integration with Jenkins

### Step-xx: Setup SonarCloud Account

- Navigate to https://www.sonarsource.com/products/sonarcloud/ >> click on Try now button >> GitHub
- If prompted, enter your GitHub credentials to sign-in.

### Step-xx: Generate an Authentication token on SonarCloud

- Sign-in to your SonarCloud account >> Click on your user drop-down list (top-right corner) >> My Account
- Select **Security** tab
  - **Generate Tokens**: token-for-jenkins >> click on **Generate Token** button.
  - Copy the generated token and store at save place as we'll need it in our next step.

### Step-xx: Save SonarCloud account token on Jenkins server

- Jenkins Dashboard >> Manage Jenkins >> Credentials >> System >> Global credentials (unrestricted)
- Click on New Credentials button
  - Kind: Secret Text
  - Scope: Global
  - Secret: <paste_the_sonarqube_token_generated_in_last_step>
  - ID: sonarcloud-token
- Click on **Create** button

### Step-xx: Install Sonar Scanner plugin on Jenkins server

- Jenkins Dashboard >> Manage Jenkins >> Plugins
- Select Available plugins tab >> serach for **SonarQube scanner** >> Select and Install

### Step-xx: Save SonarCloud account details on Jenkins

- Jenkins Dashboard >> Manage Jenkins >> System.
- Scroll down all the way to **SonarQube server section** (thanks to sonarqube scanner plugin).
- Click on **Add SonarQube** button
  - Name: sonarqube-server
  - Server URL: https://sonarcloud.io/
  - **Server Authentication Token**: <select_sonar_token_we_created_earlier>
- Click **Save** button

### Step-xx: Install SonarQube Scanner on Jenkins server

- Jenkins Dashboard >> Manage Jenkins >> Tools >> Scroll to **SonarQube Scanner** section
- Click on **Add SonarQube Scanner** button
  - Name: sonar-scanner
  - Install Automatically: Enable
  - Version: <select_lastet_version>
- Click on **Apply & Save**

### Step-xx: Create a sonar-project.properties file

### Step-xx: Add SonarCloud stage to Jenkinsfile - for code review

### Step-xx: Add Unit test stage to Jenkinsfile

### Step-xx: Add SonarCloud Quality gates to Jenkinsfile

### Step-xx: Push the changes to GitHub repo

### Step-xx: Check-in the code and execute Jenkins Job

### Step-xx: Verify the results

## Step-xx: JFrog integration with Jenkins

### Step-xx: Setup JFrog Account

### Step-xx: Add `Artifactory stage` to Jenkinsfile

### Step-xx: Add a stage in Jenkinsfile to publish build artifacts (\*.jar) to JFrog Artifactory

### Step-xx: Check-in the code and execute Jenkins Job

### Step-xx: Verify the results
