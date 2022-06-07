pipeline {
  agent any
  environment {
  GIT_HASH = GIT_COMMIT.take(7)
  RELEASE_NOTES = sh (script: """git log --format="medium" -1 ${GIT_COMMIT}""", returnStdout:true)
}
    stages {
      stage('Compile') {
         steps {
           sh 'mvn compile' 
         }
       }  
     stage('Test') {
        steps {
         sh '''
          mvn clean install
          ls
          pwd
           ''' 
        }
      }
      stage('SonarQScan') {
          steps {
         withSonarQubeEnv(installationName: 'sq1') {
         sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
        }
      }
    }

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Building image') {
              
            steps {
                script {
                    dockerImage = docker.build "st251/petclinic:$BUILD_NUMBER"
                    dockerImage = docker.build "st251/petclinic:$GIT_HASH"
                }
            }
        }
        
       stage('Docker push') {
              steps {
                 script {
                    // Assume the Docker Hub registry by passing an empty string as the first parameter
                    docker.withRegistry('' , 'dockerhub-st251-jenkins') {
                        dockerImage.push()               
                    sh "docker rmi st251/petclinic:${env.BUILD_NUMBER}"
                    sh "docker rmi st251/petclinic:$GIT_HASH"
                    }
                }
            }
        } 
        
        
    }
    
       post{
  success{
    office365ConnectorSend(
        status: "Build Success",
        webhookUrl: "https://epam.webhook.office.com/webhookb2/2d1596f4-af98-49f9-8d2b-9337a0e8fb5d@b41b72d0-4e9f-4c26-8a69-f949f367c91d/JenkinsCI/d8c1fee460a74aafbb5c81a84990fd23/60be1e9f-ec66-4d5b-a6d6-ab2b7a51705b",
        color: '00ff00',
        message: "Build Success"
        )  

    }
    failure{
         office365ConnectorSend(
        status: "Build Failed",
        webhookUrl: "https://epam.webhook.office.com/webhookb2/2d1596f4-af98-49f9-8d2b-9337a0e8fb5d@b41b72d0-4e9f-4c26-8a69-f949f367c91d/JenkinsCI/d8c1fee460a74aafbb5c81a84990fd23/60be1e9f-ec66-4d5b-a6d6-ab2b7a51705b",
        color: 'ff4000',
        message: "The build has failed, please check build logs"
        )
    }
  }
 
}
