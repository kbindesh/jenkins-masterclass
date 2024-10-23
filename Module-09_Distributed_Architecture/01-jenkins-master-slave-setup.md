# Setup Jenkins Distributed (Master-Slave) Setup

## Prerequisites

- Github Repository with maven based java application.</br>

## Step-01: Setup Jenkins Server (controller/master node)

### Step-1.1: Create an EC2 Instance and Configure as Jenkins server

- [Refer this link for step-by-step process](https://github.com/kbindesh/jenkins-masterclass/tree/main/Module-03_Setting_up_Jenkins/01-jenkins-on-amazon-linux)

### Step-1.2: Install required Jenkins Plugins

- Navigate to Jenkins dashboard >> Manage Jenkins >> Plugins >> Available Plugins
- Search and Install following plugins:
  - Maven Integration
  - Maven Invoker
  - GitHub

## Step-02: Setup Jenkins Agent (Maven Build Server | slave node)

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

## Step-03: Add Maven server as an Agent on Jenkins server (master node)

### Step-3.1: Create a new user on Maven build server for Jenkins communication

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

### Step-3.2: Add `Maven server` as new node on `Jenkins server`

- Open Jenkins server's Dashboard >> Manage Nodes and Cloud >> New Node
- Node Name: maven_build_server
- Permanent Agent: Enable
- `# of executors`: 5
- Remote Root Directory: /home/jenkins
- Launch Method: Launch Agent via SSH
  - Host: <private_ip_of_the_maven_server>
  - Credentials >> Add
    - Username: jenkins
    - Password: <your_jenkins_user_passwd>
    - ID: jenkins
  - Select the created credentials from the dropdown list.
- Host key verification strategy: Non verifying verification strategy

### Step-3.3: Verify the connection with Maven build agent

- Jenkins Dashboard >> Manage Jenkins >> Nodes >> maven_build_server
- You should see agent added without a warning sign. Also check it in the logs.

## Step-04: Configure Global Configuration Setting for Maven and Java

## Step-05: Create Jenkins Job to execute it on Agent node

- Create a new Jenkins job

  - Name: master-slave-demo
  - Type: Freestyle
  - General settings
    - Restrict where this project can be run: Enable
    - Label Expression: <name_of_the_agent> (here maven-build-agent)
  - Source Code Management
    - Git
      - Repository URL: <your_github_repo_url>
      - Credentials: <select_creds_if_private_repo>
      - Branches to build: <branch_of_github_repo>
  - Build Triggers
    - GitHub hook trigger for GITScm polling: Enable
  - Build Steps

    - Add Build step >> Invoke top-level Maven targets
      - Maven Version: maven-3.9.8
      - Goals: clean install

## Step-06: Verify the Job execution on Agent node
