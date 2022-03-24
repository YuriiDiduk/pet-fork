pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  
   stages {
    stage('Compile') {
       steps {
         sh 'mvn compile' //only compilation of the code
       }
    }   
   
   
    stage('SonarQScan') {
      steps {
       withSonarQubeEnv(installationName: 'sq2') {
        sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
        }
      }
    }
    stage('Building our image') {
            steps {
                script {
                    dockerImage = docker.build "st251/petclinicx:$BUILD_NUMBER"
                }
            }
        }
    stage('push to DHub') {
            steps {
                script {
                    // Assume the Docker Hub registry by passing an empty string as the first parameter
                    docker.withRegistry('' , 'dockerhub-cred-st251') {
                        dockerImage.push()
                    }
                }
            }
        } 
    stage('DComposeUp') {
            steps {
                      sh 'docker-compose up -d'
            }
        }
    stage('HealthCheck') {
      steps {
            
             sleep 300
             sh 'curl http://localhost:8181'
      }
   }
  }
   
}
