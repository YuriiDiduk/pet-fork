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
     
  }
   
}
