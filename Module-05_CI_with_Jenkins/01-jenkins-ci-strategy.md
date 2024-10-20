# Continuous Integration using Jenkins

## 01. Jenkins Continuous integration strategy

- **Continuous Integration** includes not only Jenkins or any other similar CI tool for that matter, but it also deals with how you version control your code, the branching strategy you follow, and so on.
- Organizations may follow different kinds of strategies to achieve Continuous Integration as it depends on the project requirements and type.

### 1.1 The branching strategy

- Branching helps you organize your code.
- It is a way to isolate your working code from the code that is under development.
- The continuous integration is basically categorized into three types of branches:

  - **Master branch**

    - You can also call it the **production branch**. - It carries the working copy of the code that has been delivered.
    - The code on this branch has passed all the testing stages.
    - No development happens on this branch.

  - **Integration branch**

    - The integration branch is also known as the mainline branch.
    - This is where all the features are integrated, built, and tested for integration issues.
    - No development happens here. However, the developers can create feature branches out of the integration branch and work on them.

  - **Feature branch**
    - The actual development takes place on Feature branch.
    - We can have multiple feature branches created out of the integration branch.

- The following diagram shows a typical branching strategy.

<img src="" alt="branching strategy"/>

- We will create two feature branches created out from the integration/mainline branch, which itself created out from the master branch.

- A successful commit on the **feature branch** will go through a **build** and **unit test** phase. If the code passes these phases successfully, it is merged to the integration branch.
- A commit on the **integration branch** (a merge will create a commit) will go through a build, static code analysis, and integration testing phase. If the code passes these phases successfully, the resultant package is uploaded to Artifactory (binary repository).

### 1.2 The Continuous Integration (CI) pipeline
