pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        writeFile(file: 'config/secret/mws_access_info.exs', text: 'Dummy', encoding: 'UTF-8')
      }
    }
    stage('Test') {
      steps {
        bat 'call mix test'
      }
    }
  }
}