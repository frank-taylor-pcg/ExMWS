pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        bat 'call elixir --version'
      }
    }
    stage('Test') {
      steps {
        bat 'mix test'
      }
    }
  }
}
