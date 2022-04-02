pipeline {
  environment {
    registry = "st251/petclinica"
    registryCredential = 'dockerhub-st251-jenkins'
    dockerImage = ''
  }
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
 stages { 
  stage('DockerLint') {
      steps {       
            sh 'docker run --rm -i hadolint/hadolint < Dockerfile' 
             }
        }
    stage('Building our image') {
            steps {
                script {
                    app = docker.build("st251/petclinica")
                }  
            }
        }
   stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-st251-jenkins') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    
   stage('Remove Unused docker image') {
      steps{
        sh 'docker rmi st251/petclinica:latest'
      }
    }
  }
}
   
