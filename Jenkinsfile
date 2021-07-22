pipeline {
  agent any
  stages {
    stage('Code Build') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Junit Test') {
      steps {
        sh 'mvn test'
      }
    }
    stage('sonar scan') {
      steps {
        sh 'mvn clean verify sonar:sonar -Dsonar.login=9077ea18d14b7a7fd02411020f5496a90d81c9bd'
      }
    }
    stage('docker build') {
      steps {
        sh 'docker build -t helloworld/java:latest .'
      }
    }

    stage('Deploy to local docker') {
      steps {
        sh 'docker run -d -p 8081:8080 helloworld/java:latest'
      }
    }
  }
  post {
     always {
         junit 'target/surefire-reports/*.xml'
        }
    }
}
