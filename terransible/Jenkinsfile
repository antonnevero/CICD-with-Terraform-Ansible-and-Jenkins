pipeline {
  agent any
  stages {
    stage('Init') {
      steps {
        sh 'cd terransible && ls'
        sh 'export TF_IN_AUTOMATION=true'
        sh 'terraform init -no-color'
      }
    }
    stage('Plan'){
      steps {
        sh 'cd terransible'
        sh 'export TF_IN_AUTOMATION=true'
        sh 'terraform plan -no-color'
      }
    }
  }
}