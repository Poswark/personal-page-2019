pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh "docker  build  --no-cache -t ${image}:${tag} . "

            }
        }
        stage('scan image') {
            steps {
                sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --insecure ${image}:${tag}"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}