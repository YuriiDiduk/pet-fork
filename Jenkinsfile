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
   
    stage('Building our image') {
            steps {
                script {
                    dockerImage = docker.build "st251/petclinic:$BUILD_NUMBER"
                }
            }
        }
    stage('Deploy our image') {
            steps {
                script {
                    // Assume the Docker Hub registry by passing an empty string as the first parameter
                    docker.withRegistry('' , 'dockerhub-st251-jenkins') {
                        dockerImage.push()
                    }
                }
            }
        } 
 
 
  }
   
} 
