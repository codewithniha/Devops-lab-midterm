pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling latest code from GitHub...'
                checkout scm
            }
        }
        
        stage('Train Model') {
            steps {
                echo 'Training the model...'
                sh 'python3 train.py'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ml-api .'
            }
        }
        
        stage('Deploy Container') {
            steps {
                echo 'Deploying container...'
                sh '''
                    docker stop ml-api || true
                    docker rm ml-api || true
                    docker run -d -p 8000:8000 --name ml-api ml-api
                '''
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo 'Verifying API is accessible...'
                sh 'sleep 5'
                sh 'curl http://localhost:8000/metrics || echo "API not ready yet"'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
