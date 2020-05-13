pipeline {
 agent any
 stages {
  stage('checkout') {
    steps {
       git branch: 'master', url: 'https://github.com/ankababug/stage.git'
    }
  }
 stage('environment') {
    steps {
       AWS_ACCESS_KEY_ID= credentials('jenkins-aws-secret-key-id')
       AWS_SECRET_ACCESS_KEY= credentials('jenkins-aws-secret-access-key')
    }
 }
 stage('Provision infrastructure') {
 steps {
 sh "/usr/bin/terraform init"
 sh "/usr/bin/terraform plan -out=plan"
 sh "/usr/bin/terraform apply plan"
 }
}
}
}
