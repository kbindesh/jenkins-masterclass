# Installing Jenkins on Windows

- This chapter covers the Jenkins installation process on different environments like Windows, Linux and Docker containers and discusses the hardware/software requirements.

## Step-00: System Requirements

### Hardware requirements

- 256MB of RAM
- 1 GB hard disk space (If you are running Jenkins as a Docker container, 10GB is recommended.)

### Software requirements

- **Java**
  - Java 17 OR java-17-amazon-corretto.x86_64
  - You may download it from this official download link: https://www.oracle.com/in/java/technologies/downloads/
- **Operating system**
  - [Windows](https://www.jenkins.io/doc/book/installing/windows/)
  - [Linux](https://www.jenkins.io/doc/book/installing/linux/)
  - [MacOS](https://www.jenkins.io/doc/book/installing/macos/)
  - [Docker](https://www.jenkins.io/doc/book/installing/docker/)
  - [Kubernetes](https://www.jenkins.io/doc/book/installing/kubernetes/)

## Step-01: Installing Jenkins

### 01. Provision a Virtual Machine (EC2 Instance)

- Sign-in to AWS Account (https://console.aws.amazon.com/).
- Navigate to EC2 service >> Launch Instance.
- **Name**: Jenkins-Server
- **AMI**: Amazon Linux 2 (Kernel 5.10) / Amazon Linux 2023
- **Instance Type**: t2.micro
- Key Pair: <create_new_keypair>
- VPC/Subnet: Default
- Elastic IP: Enable
- Security Group: <create_new_sg>
  - Ingress: Allow SSH (22)
- Storage: 10 GB, GP2 (min for this lab)
- Click on **Launch Instance** button

### 02. Install Java (as a prerequisite)

- Official link for java download: https://www.oracle.com/in/java/technologies/downloads/

```
# Download Java rpm package


# Install Java as a pre-requisites for jenkins installation
yum install -y java-17-amazon-corretto.x86_64

# To verify java installation
java --version

```

### 03. Install and Configure Jenkins

- Official website link for Jenkins download: https://www.jenkins.io/doc/book/installing/linux/

```

```

## Step-02: Update Jenkins server (EC2 Instance) security group rule

## Step-03: Access Jenkins server's Dashboard

## Step-04: Configuring Jenkins - Authenticate for first time use

## Step-05: Setup and Install Jenkins plugins

## Step-06: Create the first Admin user

## Step-07: Install Git

## References

- [Jenkins installation system requirements](https://www.jenkins.io/doc/pipeline/tour/getting-started/#prerequisites)
- [Installing Jenkins on various platforms](https://www.jenkins.io/doc/book/installing/)
