pipeline {
  agent any
  stages {
    stage('Configure') {
      steps {
        writeFile(file: 'config/secret/mws_access_info.exs', text: '''use Mix.Config
config :exmws,
  scheme: "https",
  endpoint: "mws.amazonservices.com",
  marketplace_id: "ATVPDKIKX0DER",
  merchant_id: "Your merchant ID here",
  aws_access_key_id: "Your access key ID here",
  aws_secret_access_key: "Your secret access key here"''', encoding: 'UTF-8')
        bat 'mix local.hex --force'
        bat 'mix local.rebar --force'
        bat 'mix deps.get'
      }
    }
    stage('Test') {
      steps {
        bat 'call mix test'
      }
    }
    stage('Update coveralls.io') {
      steps {
        bat 'call mix coveralls.post -t ${env.Coverall_Token} -b ${env.GIT_BRANCH} -s ${env.GIT_COMMIT}'
      }
    }
  }
}
