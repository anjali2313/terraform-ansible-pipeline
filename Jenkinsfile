pipeline {
    agent any

    environment {
        TF_DIR = '.'                 
        AWS_REGION = 'ap-northeast-1'
    }

    stages {
        stage('Terraform Init & Validate') {
            steps {
                dir("${TF_DIR}") {
                    withCredentials([aws(credentialsId: 'ec2-key', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                          echo "=== Starting Terraform Init & Validate ==="
                          terraform init -input=false
                          terraform validate
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    withCredentials([aws(credentialsId: 'ec2-key', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                          echo "=== Running Terraform Plan ==="
                          terraform plan -out=tfplan
                        '''
                    }
                }
            }
        }

        stage('Approval Step') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input message: 'Approve Terraform Apply?'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    withCredentials([aws(credentialsId: 'ec2-key', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                          echo "=== Applying Terraform Infrastructure ==="
                          terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ SUCCESS: Terraform pipeline completed successfully!"
        }
        failure {
            echo "❌ FAILURE: Something went wrong — check Jenkins logs."
        }
    }
}
