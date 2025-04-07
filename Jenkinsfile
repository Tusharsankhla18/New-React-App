pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = 'azure-service-principal-2'
        RESOURCE_GROUP = 'tushar-react-resource'
        APP_SERVICE_NAME = 'tushar-react-frontend-app'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/sherinsaji126/integrated-react.git'
            }
        }

        stage('Install & Build React App') {
            steps {
                dir('integrated-react') {
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }

        

        stage('Deploy to Azure App Service') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat 'az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant %AZURE_TENANT_ID%'
                    bat 'powershell Compress-Archive -Path integrated-react\\build\\* -DestinationPath build.zip -Force'
                    bat 'az webapp deploy --resource-group %RESOURCE_GROUP% --name %APP_SERVICE_NAME% --src-path build.zip --type zip'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
