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
        withSonarQubeEnv('SonarQube'){
        sh "mvn clean verify sonar:sonar -Dsonar.host.url=http://192.168.1.250:9000 -Dsonar.login=${SONAR_AUTH_TOKEN}"
        }
      }
    }
    stage('docker build') {
      steps {
        sh 'docker build -t helloworld/java:latest .'
      }
    }

    stage('Deploy to local docker') {
      steps {
        sh 'docker container run -itd -p 8081:8080 helloworld/java:latest'
      }
    }
    stage('Report') {
      steps {
        script {
          if (currentBuild.currentResult == 'UNSTABLE') {
            currentBuild.result = "UNSTABLE"
          } 
          if (currentBuild.currentResult == 'SUCCESS') {
            currentBuild.result = "SUCCESS"
          }
          else {
            currentBuild.result = "FAILURE"
          }
        step([$class: 'InfluxDbPublisher', target: 'grafana'])
        }
      }
    }
    
  }
  post {
     always {
         junit 'target/surefire-reports/*.xml'
        }
    }
}
