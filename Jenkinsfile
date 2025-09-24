pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'mythili121'
        DOCKERHUB_CREDENTIAL_ID = 'dockerhub-cred'
        AWS_SSH_CREDENTIAL_ID = 'aws-ec2-key'
        EC2_IP = '98.84.168.134'
        TARGET_BRANCH = 'main' // Set the branch you want to build
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${TARGET_BRANCH}",
                    url: 'https://github.com/mythili1-14/devops-build.git'
            }
        }

        stage('Verify') {
            steps {
                sh "ls -l"
            }
        }

        stage('Build and Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIAL_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"
                }
                sh "chmod +x build.sh"
                sh "./build.sh ${TARGET_BRANCH}"  // pass the branch explicitly
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(credentials: [AWS_SSH_CREDENTIAL_ID]) {
                    sh "scp -o StrictHostKeyChecking=no deploy.sh ubuntu@${EC2_IP}:/tmp/deploy.sh"
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${EC2_IP} \
                        bash /tmp/deploy.sh ${TARGET_BRANCH == 'main' ? 'prod main' : 'dev dev'}
                    """
                }
            }
        }
    }
}
