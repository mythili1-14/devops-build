pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'mythili121'
        DOCKERHUB_CREDENTIAL_ID = 'dockerhub-cred'
        AWS_SSH_CREDENTIAL_ID = 'aws-ec2-key'
        EC2_IP = '98.84.168.134'
    }

    stages {
        stage('Build and Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIAL_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"
                }
                sh "bash ./build.sh"
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(credentials: [AWS_SSH_CREDENTIAL_ID]) {
                    sh "scp -o StrictHostKeyChecking=no deploy.sh ubuntu@${EC2_IP}:/tmp/deploy.sh"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@${EC2_IP} bash /tmp/deploy.sh ${env.BRANCH_NAME == 'main' ? 'prod main' : 'dev dev'}"
                }
            }
        }
    }
}
