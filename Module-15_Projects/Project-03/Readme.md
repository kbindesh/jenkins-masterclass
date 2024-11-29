# Project-xx: Jenkins CI/CD Pipeline for containerized application using Docker and GitHub

This project will demonstrate integration of Docker into Jenkins based CI/CD pipeline for packaging, building and deploying containerized application on Docker host.

- Develop an Application (here, Java Spring Boot app)
- Develop Jenkinsfile
- Setup Jenkins server
- Setup Docker Host (jenkins slave node)
- Integrate Docker agent with Jenkins
- Create Jenkins job to build and copy artifacts to Docker Host
- Update Dockerfile to automate deployment process
- Create a Jenkins job to deploy App to Docker host using Jenkins CI/CD pipeline.

## Step-xx: Solution Design

## Step-xx: Prerequisites

- An AWS Account
- GitHub Account
- DockerHub Account

## Step-xx: Setup the `Jenkins server` (master node)

### Step-xx: Create an EC2 Instance and configure it as Jenkins server

- [Refer this link for step-by-step process](https://github.com/kbindesh/jenkins-masterclass/tree/main/Module-03_Setting_up_Jenkins/01-jenkins-on-amazon-linux)

### Step-xx: Install required Jenkins Plugins

- Navigate to Jenkins dashboard >> Manage Jenkins >> Plugins >> Available Plugins
- Search and Install following plugins:
  - Maven Integration
  - Maven Invoker
  - GitHub

## Step-xx: Setup the `Maven build server` (slave node)

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
yum install -y java-17-amazon-corretto.x86_64

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
- You should see agent added without a warning sign. Also check it in the node logs.

## Step-xx: Configure `Maven` and `Java` installation path on Jenkins server

- Navigate to Jenkins server dashboard >> Manage Jenkins >> Tools

- **JDK**

  - Name: Java-17
  - JAVA_HOME: /usr/lib/jvm/java-17-amazon-corretto.x86_64

- **Maven** - location of maven installation on Maven slave machine (not on Jenkins master node)
  - Name: Maven-3.9.8
  - MAVEN_HOME: /opt/apache-maven-3.9.8

## Step-xx: Create a new Jenkins job (Maven project)

- Name:
- Project Type: Maven Project
- Restrict where this project can be run: Enable
- Source Code Management
  - Git
    - Repository URL: https://github.com/kbindesh/mvn-webapp.git
    - Branch: Master
- Build Triggers
  - Build whenever a SNAPSHOT dependency is built: Enable
- Build
  - Root POM: pom.xml
  - Goals & Options: clean install
- Post Steps
  - Run only if build succeeds
- Post-build Actions
  - Files to archive: target/\*.war

## Step-xx: Setup `Docker Host agent` (slave node)

### Create an EC2 instance

### Install & Configure Docker

```
sudo su -

yum install -y docker

systemctl start docker

systemctl enable docker

systemctl status docker
```

## Step-xx: Develop the Java Application

### Create a new Maven project using Visual Studio Code

- Launch VS Code >> Create a new folder and open into it.
- Press Ctrl+Shift+P >> Select maven-archetype-webapp from the list
  - Version: <default>
  - GroupId: <default>
  - ArtifactId: <default>

### (Alternative) Create a new Maven project using Maven CLI

```
# Create a new Maven project (web)
mvn archetype:generate -DgroupId=com.example -DartifactId=my-webapp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
```

### Push the Maven project source code to GitHub repo

```
git add .

git commit -m "Maven App Version 1.0"

git push -u origin master
```

## Step-xx: Integrate Docker host with Jenkins server

### Create a new user on Docker Host (for connectivity with Jenkins server)

```
sudo su -

useradd dockeradmin

passwd dockeradmin

usermod -aG docker dockeradmin
```

### Enable password based authentication for `dockeradmin` user

```
vi /etc/ssh/sshd_config

# Set "PasswordAuthentication" variable to Yes
PasswordAuthentication Yes

# To take effect, reload the sshd service
service sshd reload
```

- To check, you may now try to connect to your Docker host using `dockeradmin` user using password based authentication.

### Install `Publish over SSH` plugin

- Jenkins Dashboard >> Manage Jenkins >> Plugins >> Available.
- Search "Publish Over SSH" plugin >> Select it and Install

### Save `Docker host` (slave node) details on Jenkins server

- Jenkins Dashboard >> Manage Jenkins >> Systems >> Scroll to `Publish over SSH` section.
- SSH Server >> Click **Add** button
  - Name: dockerhost
  - Hostname: <private_ip_of_docker_host>
  - Username: dockeradmin
  - Password: <dockeradmin_password>
- Click on **Test Connection** button to check the connectivity with the Docker host.

## Step-xx: Create a Jenkins job to `Build an app on Jenkins server` & `copy artifacts to Docker host`

### Create a new Jenkins job

- Type: Freestyle
- Name: build-and-deploy-app-job
- **Source Code Management**
  - Git
    - Repository URL: <your_github_repo_url>
    - Branches to build: master
- **Build Triggers**

  - Build whenever a SNAPSHOT dependency is built: Enable
  - Poll SCM: \* \* \* \* \*

- **Build**

  - Root POM: pom.xml
  - Goals & Options: clean install

- **Post-build Actions**
  - Click **Add post-build actions** button >> Select **Send build artifacts over SSH**
  - Name: <select_from_the_list>
  - Source files: demo/target/\*.war
  - Remote directory: /home/dockeradmin
