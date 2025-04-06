pipeline {
    agent any

    environment {
        AZURE_SERVICE_PROVIDER = 'azure-service-principal1'
        AZURE_WEBAPP_NAME = "tushar-react-frontend-app"
        AZURE_RESOURCE_GROUP = "tushar-react-resource"
        AZURE_LOCATION = "East US 2"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Tusharsankhla18/New-React-App.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        stage('Build React App') {
            steps {
                bat 'npm run build'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    bat 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy to Azure Web App') {
            steps {
                bat """
                    az webapp deploy ^
                    --resource-group %AZURE_RESOURCE_GROUP% ^
                    --name %AZURE_WEBAPP_NAME% ^
                    --src-path build ^
                    --type static
                """
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully!'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}
