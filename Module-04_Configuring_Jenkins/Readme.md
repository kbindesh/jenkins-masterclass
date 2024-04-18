# Configuring Jenkins

- In this module, we will learn how to perform some basic Jenkins administration.
- We will also familiarize ourselves with some of the most common Jenkins tasks, like:
  - Creating jobs
  - Installing plugins
  - Configuring Jenkins system
- We will learn below concepts:

  - **Creating a simple Jenkins job**

  - **An overview of the Jenkins home directory**

  - **Managing and configuring Jenkins plugins**

  - **Managing users and permissions**

## 01. Creating a simple Jenkins job

- In this lab, we will learn how to create a jenkins job for performing a task on jenkins master node.
- We will configure the job to send an email notification.
- We will also learn how to use system variables while performing various tasks.

### Step-01: Create a new Jenkins job (also know as Project)

- From the Jenkins Dashboard, click on the **New Item** link present on the left side.

- **Name**: Cleaning_Temp_Directory
- **Type**: Freestyle
- Click on **OK** button to create a job.
- You will be automatically redirected to the page where you can configure your Jenkins job.
- You may add some description to the project.

### Step-02: Configuring Jenkins job

- Below the Description section, there are many other settings that can be ignored for now.
- Nevertheless, you can click on the question mark icon, present after each option to know its functionality.

### Step-03: Configure Source Code Management

- Scrolling down further, you will see the _Advanced Project Options_ section and the **Source Code Management** section. - Skip them for now as we don't need them.

### Step-04: Configure Build Triggers

- Scroll down further to move to **Build Triggers** section.
- Under the _Build Triggers_ section
  - select the **Build periodically** option
  - add **H 23 \* \* \*** inside the _Schedule_ field
- We would like our Jenkins job to run daily around 11:59 PM throughout the year.

**Info**: The schedule format is Minute (0-59) Hour (0-23) Day (1- 31) Month (1-12) Weekday (0-7). In the weekday section, 0 & 7 are Sunday.

### Step-05: Adding a build step

- Moving further down brings you to the most important part of the job's configuration: that is the **Build** section.
- Build steps are sections inside the Jenkins jobs that contain _scripts_, which perform the actual task.
- You can run a _Windows batch script_ or a _shell script_ or any script for that matter.

- Click on the **Add build step** button and select the **Execute shell** (for linux systems) or **Execute Windows batch** (for windows systems).
- In the command field, add the following command:

```
echo "Hello there.."

pwd
```

- You can create as many builds as you want, using the **Add build step** button.

### Step-06: Adding post-build actions

- Scroll down further and you'll find the **Post-build Actions** section.
- Click on the **Add post-build action** button and select the **E-mail Notification** option from the menu.
- Recipients: <recipient_email_ids_comma_sep>
- There are a few options under the E-mail Notification section that can be ignored for now.
- Click on the **Save** button to save all the configurations.

### Step-07: Configuring the Jenkins SMTP server

- SMTP server configuration is required to send email notifications.
- From the Jenkins Dashboard, click on the **Manage Jenkins** link >> **Configure System**
- On the configuration page, scroll down to **E-mail Notification** section (below config is for Gmail SMTP server):
  - **SMTP Server**: smtp.gmail.com
  - **SMTP port**: 465 (SSL) or 587 (TLS)
  - **Reply-To-Address**: An e-mail address, in case you want the recipient to reply to the auto-generated emails.
- You may test configuration by sending a test e-mail.
- Check _**Test configuration by sending test e-mail**_ checkbox >> Add the e-mail address >> click on the _**Test Configuration**_ button.
- If the configuration is correct, the recipient will receive a test e-mail.

### Step-08: Running a Jenkins job

- Go to the _Jenkins Dashboard_.
- You should see our newly created Jenkins job listed on the page.
- Click on the **Build** button to run the job. If everything goes well, the job will run successfully.

### Step-09: Jenkins build logs

- Hover the mouse over the _build number_ and select **Console Output**.

## 02. Jenkins Home Directory

- Jenkins home directory is the place where all of the Jenkins configurations and metadata is stored.

- **Windows (as installation)**
  - C:\ProgramData\Jenkins\.jenkins
  - C:\Windows\System32\config\systemprofile\AppData\Local\Jenkins\.jenkins\secrets
- **Linux**
  - var\lib\jenkins
- **Windows (as WAR file)**
  - C:\Users\Owner\.jenkins

### Where is the Jenkins Home Directory located?

- Navigate to your Jenkins dashboard. In our case, we are browsing to http://<jenkins_server_ip>:8080/
- Click the **Manage Jenkins** option.
- Under _System Configuration_, click the **Configure System** button.
- There you will find the location of the Jenkins current home directory.

### How to change Jenkins home directory in Linux?

- Stop the Jenkins service

```
sudo systemctl stop jenkins
```

- Create a new Jenkins Home directory. For this example, we are creating **/home/jenkins_home**.

```
sudo mkdir /home/jenkins_home

# Change permissions for the new Jenkins home directory
sudo chown jenkins:jenkins /home/jenkins_home

# Copy the contents from the old Jenkins Home dir to the new one
sudo cp -prv /var/lib/jenkins /home/jenkins_home

# Assign Jenkins as the user for the new Home directory
sudo usermod -d /home/jenkins_home jenkins

# Update the jenkins config file with new home dir details
sudo vi /etc/default/jenkins

JENKINS_HOME=/home/jenkins_home

# Restart the jenkins service
sudo systemctl start jenkins
```

### How to change Jenkins home directory in Windows?

## 03. Managing `Jenkins plugins`

- To let your application go through different SDLC phases (_pulling the source code from a SCM tool, compiling the source code, unit and integration testing, and then building the application_), you need to use different type of tools, like SCM tools, unit or integration testing tools, build tools, etc.
- Jenkins needs to communicate with those tools as part of executing the end-to-end build lifecycle.
- Jenkins uses **plugins** to communicate with these tools.

### What is `Jenkins Plugin`?

- A **Jenkins plugin** is a software component that adds a specific feature to installed Jenkins instance.
- There are various plugins developed by the Jenkins team to customize the usage of Jenkins.

### Commonly used `jenkins plugins`

- Some of the commonly used Jenkins plugins are:

  - Git
  - Maven
  - Email Extension
  - Amazon EC2
  - AWS CodeDeploy
  - Terraform
  - Jira
  - Docker
  - Kubernetes
  - SonarQube

  ### Locate `Jenkins plugin manager` and installing plugins

  1. Log into **Jenkins** server.
  2. From **Jenkins Dashboard** >> **Manage Jenkins** >> **Manage Plugins**. It will open the Plugin Manager page.

  - There will be multiple tabs under Jenkins plugin manager window:
    - **Updates**
    - **Available**
    - **Installed**
    - **Advanced**
  - Under **Available** tab, search for plugin name like maven, Amazon EC2 etc. >> Click on **Install** button.

## 04. Managing users and permissions

### Enabling global security on Jenkins

### Creating users in Jenkins

### Using the Project-based matrix authorization strategy
