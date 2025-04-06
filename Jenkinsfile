pipeline {
    agent any

    environment {
        AZURE_SERVICE_PROVIDER = 'azure-service-principal1'
        ARM_CLIENT_ID = '2b3370f2-c07e-40f6-8a94-2e06e5ff3483'
        ARM_SUBSCRIPTION_ID = ' 9e88581e-e755-404d-819f-4d6e468ad176'
        ARM_TENANT_ID = '7a839694-b2fa-4d11-aa3e-c5b87aa6db68'
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
