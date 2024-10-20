# Lab: Demonstrating the working of Jenkins Pipeline

## Step-01: Setup Jenkins server

- Kindly refer this link for steps-by-step process: https://github.com/kbindesh/jenkins-masterclass/tree/main/Module-03_Setting_up_Jenkins/02-Jenkins_on_EC2_Amzn_Linux

## Step-02: Install Jenkins Pipeline plugin

- Navigate to Jenkins dashboard >> Manage Jenkins >> Plugins
- Select **Available plugins** tab >> Search for following plugins and make sure it is installed:

  - **Pipeline**
  - **Pipeline: Stage View Plugin**

- In case you do not find the above plugins in the **Available plugins** tab, there is a strong possiblity that it would be already installed. To confirm, switch to **Installed plugins** tab and search over there.s

## Step-03: Create your first Jenkins pipeline

```
pipeline {
  agent any

  stages {
      stage('Build') {
          steps {
              echo 'Building..'
          }
      }
      stage('Test') {
          steps {
              echo 'Testing..'
          }
      }
      stage('Deploy') {
          steps {
              echo 'Deploying....'
          }
      }
  }
}
```

## Step-05: Create a new Jenkins job (Pipeline type)

- Jenkins dashboard >> **New item**
  - **Item name**: pipeline-01
  - **Item type**: Pipeline
  - Description: This jenkins job is of type pipeline and for demonstrating pipeline-as-a-code concept.
  - Pipeline
    - Definition: Pipeline script >> Paste the Jenkinsfile code (created in the preceding step) in the snippet.s
- Click on **Apply** & **Save** button

## Step-06: Execute Jenkins job

- Select the jenkins job (pipeline-01) you created in the previous step and click on **Build Now** button.
- You should see multiple phases with details.

## Adding multiple steps to Jenkins pipeline

```
pipeline {
  agent any

  stages {
      stage('Build') {
          steps {
              sh 'echo "Building.."'
              sh '''
                 echo "I am second step of Build stage.."
                 ls -lah
              '''
          }
      }
  }
}
```

## Using Environment variables

```
pipeline {
  agent any

  environment {
    Name = "Bindesh"
    Role = "Architect"
  }

  stages {
      stage('Build') {
          steps {
              sh 'echo $Name "is" $Role'
          }
      }
  }
}
```

## Adding Tools to Pipeline

```
pipeline {
    agent any
    tools {
        maven 'Maven_3.9.8'
        jdk 'Java-17'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                echo 'This is a simple pipeline.'
            }
        }
    }
}
```

## Running a Maven Build

```
pipeline {
    agent any
    tools {
        maven 'Maven_3.9.8'
        jdk 'Java-17'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn -Dmaven.test.failure.ignore=true install'
            }
            post {
                success {
                    junit 'target/surefire-reports/**/*.xml'
                }
            }
        }
    }
}
```

## Using Credentials (sensitive info) in Jenkins pipeline

## Defining post build actions in Pipelines

s
