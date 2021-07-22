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
        sh "mvn clean package -Dsonar.host.url=http://192.168.1.250:9000 -Dsonar.login=ea4aa1fea8b33209c32a2fef5fd246c0f8571adb"
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
