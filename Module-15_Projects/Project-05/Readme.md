# Project-03: Continuous Delivery (CD) Pipeline for Elastic Kubernetes Service (EKS) Applications </br></br> (GitHub | Jenkins | Maven | Docker | EKS | ECR)

## Step-01: Solution Design

## Step-02: Prerequisites

- An AWS Account
- GitHub repository with an Application source code. You may refer to this repo for sample source-code:

## Step-xx: Setup `Jenkins Server` (Master node)

### Step-1.1: Create an EC2 Instance and configure it as `Jenkins server`

- [Refer this link for step-by-step process](https://github.com/kbindesh/jenkins-masterclass/tree/main/Module-03_Setting_up_Jenkins/01-jenkins-on-amazon-linux)

### Step-xx: Install and Configure Maven & Git on Jenkins Server

### Step-xx: Install and Configure Docker on Jenkins Server

### Step-xx: Install required Jenkins plugins

- Maven Integration
- Maven Invoker
- Docker Pipeline

## Step-xx: Setup `Maven Build server + Docker Agent` (slave node)

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
sudo yum install -y git
```

### Step-2.4: Install and Configure Docker

```
sudo amazon-linux-extras install -y docker

sudo systemctl start docker

sudo systemctl enable docker
```

## Step-xx: Add `Maven server` as slave node on Jenkins server

### Step-3.1: Create a New user on Maven build server (slave) for Jenkins communication

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

### Step-3.2: Add `Maven server` as an Agent (slave) on Jenkins server

- Open Jenkins Dashboard >> Nodes >> New Node
- Node Name: maven-build-server
- Permanent Agent: Enable
- `# of executors`: 3
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
- You should see agent added without a warning sign. Also check it in the node logs.

## Step-xx: Setup Amazon EKS cluster

### Step-xx: Create an IAM user for communicating with AWS over CLI

### Step-xx: Configure local machine to communicate with Amazon EKS & ECR

- AWS CLI
- kubectl
- eksctl

### Step-xx: Connect to your AWS Account using AWS CLI

### Step-xx: Create an Amazon EKS cluster using AWS CLI

## Step-xx: Configure `Maven` and `Java` installation path on Jenkins server

- Navigate to Jenkins server dashboard >> Manage Jenkins >> Tools

- **JDK**

  - Name: Java-17
  - JAVA_HOME: /usr/lib/jvm/java-17-amazon-corretto.x86_64

- **Maven** - location of maven installation on Maven slave machine (not on Jenkins master node)
  - Name: Maven-3.9.8
  - MAVEN_HOME: /opt/apache-maven-3.9.8

## Step-xx: Create a Docker Hub Account (for pushing images)

## Step-xx: Develop `Dockerfile & Kubernetes Manifests`

### Develop the Dockerfile

### Develop the Kubernetes Manifests

### Push Dockerfile + K8s manifests to Github repos

## Step-xx: Develop `Jenkinsfile` with `build stages`

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

### Step-5.2: Push the Jenkinsfile into GitHub repository

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

## Step-xx: Setup Continuous Integration job on Jenkins server

## Step-xx: Deploy Java (Springboot) application on EKS cluster using Helm charts with Jenkins pipeline
