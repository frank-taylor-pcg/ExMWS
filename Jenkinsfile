pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        pwd()
      }
    }
    stage('Test') {
      steps {
        bat 'call mix test'
      }
    }
  }
}
