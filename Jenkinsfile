pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = 'azure-service-principal' // Replace with your Jenkins credential ID
        AZURE_SUBSCRIPTION_ID = '9e88581e-e755-404d-819f-4d6e468ad176'   // Replace with your Azure subscription ID
        AZURE_CLIENT_ID = credentials('2b3370f2-c07e-40f6-8a94-2e06e5ff3483') // Store these values in Jenkins Credentials
        AZURE_CLIENT_SECRET = credentials('yEl8Q~rebDfBqKmdBA4P5JjEMg.5~HoUIfXN-bG9')
        AZURE_TENANT_ID = '7a839694-b2fa-4d11-aa3e-c5b87aa6db68'
        REACT_APP_NAME = 'tushar-react-frontend-app'
        RESOURCE_GROUP = 'tushar-react-resource'
    }

    stages {
        stage('Checkout React App') {
            steps {
                git url: 'https://github.com/Tusharsankhla18/New-React-App.git', branch: 'master'
            }
        }

        stage('Install Dependencies & Build React App') {
            steps {
                script {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir('terraform') {
                    script {
                        withEnv([
                            "ARM_CLIENT_ID=${env.AZURE_CLIENT_ID}",
                            "ARM_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}",
                            "ARM_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}",
                            "ARM_TENANT_ID=${env.AZURE_TENANT_ID}"
                        ]) {
                            sh 'terraform init'
                        }
                    }
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                dir('terraform') {
                    script {
                        withEnv([
                            "ARM_CLIENT_ID=${env.AZURE_CLIENT_ID}",
                            "ARM_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}",
                            "ARM_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}",
                            "ARM_TENANT_ID=${env.AZURE_TENANT_ID}"
                        ]) {
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }

        stage('Deploy React App to Azure') {
            steps {
                script {
                    sh """
                    npm install -g azure-cli
                    az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
                    az webapp deployment source config-zip \
                        --resource-group $RESOURCE_GROUP \
                        --name $REACT_APP_NAME \
                        --src build.zip
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
