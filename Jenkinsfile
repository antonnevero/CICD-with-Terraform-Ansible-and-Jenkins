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
        sh 'cat $BRANCH_NAME.tfvars'
        sh 'terraform init -no-color'
        sh 'terraform force-unlock 45b2d58d-1d28-beb9-4ae8-c47819ca164a'
      }
    }
    stage('Plan') {
      steps {
        sh 'terraform plan -no-color -var-file="$BRANCH_NAME.tfvars"'
      }
    }
    stage ('Validate Apply') {
      when {
        beforeInput true
        branch "dev"
      }
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
        sh 'terraform apply -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
      }
    }
    stage ('EC2 wait') {
      steps {
        sh 'aws ec2 wait instance-status-ok --region eu-central-1'
      }
    }
    stage ('Validate Ansible') {
      when {
        beforeInput true
        branch "dev"
      }
      input {
        message "Do you want to run Ansible?"
        ok "Run Ansible!"
      }
      steps {
        echo 'Ansible run'
      }
    }
    stage ('Ansible') {
      steps {
        ansiblePlaybook(credentialsId: 'ec-2-ssh-key', inventory: 'aws_hosts', playbook: 'playbooks/main-playbook.yml')
      }
    }
    stage ('Validate Destroy') {
      input {
        message "Do you want to destroy everything?"
        ok "Destroy everything!"
      }
      steps {
        echo 'Everything has destroyed. Good bye!'
      }
    }
    stage('Destroy') {
      steps {
        sh 'terraform destroy -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
      }
    }
  }
  post {
    success {
      echo 'Success'
    }
    failure {
      sh 'terraform destroy -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
    }
    aborted {
      sh 'terraform destroy -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
    }
  }
}