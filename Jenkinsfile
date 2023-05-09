pipeline {
  agent any
  environment {
    TF_IN_AUTOMATION='true'
    TF_CLI_CONFIG_FILE=credentials('tf-creds')
    AWS_SHARED_CREDENTIALS_FILE='/home/ubuntu/.aws/credentials'
  }
  stages {
    stage('Init') {
      steps {
        sh 'ls'
        sh 'terraform init -no-color'
      }
    }
    stage('Plan') {
      steps {
        sh 'terraform plan -no-color'
      }
    }
    stage ('Validate Apply') {
      input {
        message "Do you want to apply this plan?"
        ok "Apply this plan."
      }
      steps {
        echo 'Apply Accepted'
      }
    }
    stage('Apply') {
      steps {
        sh 'terraform apply -auto-approve -no-color'
      }
    }
    stage ('EC2 wait') {
      steps {
        sh 'aws ec2 wait instance-status-ok --region eu-central-1'
      }
    }
    stage ('Ansible') {
      steps {
        ansiblePlaybook(credentialsId: 'ec-2-ssh-key', inventory: 'aws_hosts', playbook: 'playbooks/main-playbook.yml')
      }
    }
    stage('Destroy') {
      steps {
        sh 'terraform destroy -auto-approve -no-color'
      }
    }
  }
}