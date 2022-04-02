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
                    dockerImage = docker.build $registry:$BUILD_NUMBER
                    dockerImage = docker.build "st251/petclinica:latest"
                }
            }
        }
    stage('push to DHub') {
            steps {
                script {
                    // Assume the Docker Hub registry by passing an empty string as the first parameter
                    docker.withRegistry('' , 'dockerhub-st251-jenkins') {
                        dockerImage.push()
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
   
