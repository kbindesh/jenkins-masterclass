# Project-04: Automate AWS Cloud Infrastructure management using Terraform and Jenkins Pipeline

## Overview

In this project, we will learn how to manage terraform deployments and workflows using Jenkins.

## Step-xx: Setup Jenkins Server for Terraform

### Create an EC2 Instance and configure it as Jenkins server

- [Setup Jenkins server documentation](https://github.com/kbindesh/jenkins-masterclass/tree/main/Module-03_Setting_up_Jenkins/01-jenkins-on-amazon-linux)

### Install Terraform plugin

- Navigate to Jenkins server dashboard >> Manage Jenkins >> Plugins
- Select **Available** tab >> Search **Terraform** plugin and Install

### Install Terraform

```
# Install yum-config-manager to manage your repositories
sudo yum install -y yum-utils

#Use yum-config-manager to add the official HashiCorp Linux repository
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo yum -y install terraform

#To verify, check the installed terraform version**
terraform --version
```

### Set Terraform binary location

- Jenkins Dashboard >> Manage Jenkins >> Tools >> Scroll to **Terraform** section
- Click on Add Terraform button
  - Name: Terraform
  - Install directory: /usr/bin
    - You may check the terraform install directory by running following command:
    ```
    whereis terraform
    ```

## Step-xx: Elevate access levels of Jenkins server using IAM Role

### Create a new IAM Policy for Jenkins server IAM Role

- You may customize the IAM permission levels of Jenkins server based on what AWS resources are you going to manage/provision using Terraform.

- In this lab, the following IAM policy will allow Jenkins server to create/delete/update any _Amazon EC2, VPC, S3, DynamoDB_ resource:

```

```

### Create a new IAM Role for Jenkins server

### Assign IAM Role to Jenkins server

### Verify new access levels for Jenkins server

## Step-xx: Configure AWS S3 and DynamoDB for Terraform Remote Backend

### Create & configure a S3 bucket for storing terraform state (.tfstate)

### Create & configure Amazon DynamoDB instance for storing terraform session details

## Step-xx: Develop Terraform scripts

### Develop the Terrafor scripts

### Update the remote backend details with S3 & DynamoDB

### Execute the terraform scripts manually to verify the results

### Destroy all the created resources

## Step-xx: Develop Jenkinsfile

## Step-xx: Check-in files to GitHub repo

### Create a new GitHub repository

### Push Terraform scripts + Jenkinsfile to GitHub repo

## Create a new GitHub webhook for Jenkins job

## Step-xx: Create a new Jenkins Job

## Step-xx: Execute the Jenkins

### Execute the jenkins job manually (to verify the results)

### Trigger the jenkins job automatically using Github webhook

## Step-xx: Verify the created resources from AWS Management Console
