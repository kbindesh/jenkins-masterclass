# Exploring Jenkins Jobs

## 01. What is a `Job` in Jenkins?

- Jenkins, as an automation server (CI), can perform different tasks to automate end-to-end build lifecycles.
- These tasks are configured in the form of **jobs**.

- A `Jenkins job` is a set of instructions that tell Jenkins what to do and when to do it.
- A job is also called a **Jenkins Project**.
- There are bascially three types of instructions that configure for a Jenkins Job:

  - **When to do a Task?**

    - You can define the criteria to execute the Task. In Jenkins terms, it is know as **trigger**.

  - **What to do as a part of a Task?**

    - You can configure the steps to be performed as part of a task to achieve a particular objective.
    - In Jenkins terms, these set of instructions are called **build steps**.
    - For example, a build step could be running a simple batch command.

  - **What to do once the Task is complete?**
    - You can configure what you want Jenkins to do once it is done with a given task.
    - In Jenkins terms, this set of instructions are called the **post build actions**.
    - For example, it could notify users about the success or failure of the task.

## 02. What is a `Build`?

- A Jenkins build job contains the configuration for automating a specific task or step in the application development process.
- These tasks include _gathering dependencies, compiling, archiving_ or _transforming code_, and _testing and deploying code_ in different environments.
- You can run a Jenkins jobs multiple times, and each execution gets a **unique build number**.
- All the details related to a particular execution, like artifacts created, console logs, and so on, are stored with that build number.

## 03. Working with `Jobs` (also known as Projects)

- Jenkins uses Jobs to perform its work.
- Projects are defined and run by Jenkins users.
- Jenkins offers several different types of jobs, including:

  - **Freestyle**
  - **Pipeline**
  - **Multibranch Pipeline**
  - **Organization folders**
  - **Multi-configuration (matrix)**
  - **Maven**
  - **External job**

### Step-3.1: `Free style jobs` in Jenkins

- Free-style jobs are typical build jobs or tasks.
- They can be as simple as running tests, building or packaging an application, or sending a report.
- Freestyle jobs are suitable for simple build tasks.
- Freestyle jobs are highly flexible, however they support a limited number of general build and post-build actions.
- In order to perform any specialized action with a freestyle project requires additional jenkins plugins.

### Step-3.2: Create a build job in Jenkins

- Log into the Jenkins server and navigate to the dashboard.
- Click the New **Item link** on the left-hand side of the Jenkins dashboard.
- Enter the Project details:
  - **Project Name**: <jenkins_project_name>
  - **Type**: Freestyle project
- Click **OK** to continue.
- Under the **General** tab, add a project description in the **Description** field.

### Step-3.3: Add a build steps to the job

- Scroll down to the **Build** section or from the left-side panel of the job, select **Build**
- Open the **Add build step** drop-down menu and select **Execute shell**.
- Enter the commands you want to execute in on the bash shell of the jenkins server:

```
# In this lab, we are running simple commands | in subsequent labs it will build commands
java --version

ls -l
```

- Click on Save button to save the project.

### Step-3.4: Trigger the build job (manually)

- Click the **Build Now** link on the left-hand side of the project/job details page.
- Click the link to the latest project build in the Build History section (left-side panel).
- Click the **Console Output** link on the left-hand side to display the output for the commands you entered.
- The console output indicates that Jenkins has successfully executed the commands, and displays the current version of Java and list files in Jenkins working directory.

## 04. Parameters in Jenkins jobs/projects

- The jenkins jobs can be parameterized if the job needs any external inputs while processing.

### Step-01: Create a parameter

- Update the existing jenkins project or create a new freestyle project.
- In order to add a parameter, you have to check the checkbox "**This Project is Parameterised**" from the available dropdown options >> **Add Parameter**
- Now, enter the requested parameter details:
  - **Name**: <name_of_the_parameter>
  - **Default value**: <default_value_of_parameter>
  - **Description**: <description_about_the_parameter>

### Step-02: Pass the declared parameter to Job
