pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        writeFile(file: 'config/secret/mws_access_info.exs', text: 'use Mix.Config  config :exmws,   scheme: "https",   endpoint: "mws.amazonservices.com",   marketplace_id: "ATVPDKIKX0DER",   merchant_id: "Your merchant ID here",   aws_access_key_id: "You access key ID here",   aws_secret_access_key: "Your secret access key here"', encoding: 'UTF-8')
      }
    }
    stage('Test') {
      steps {
        bat 'call mix test'
      }
    }
  }
}