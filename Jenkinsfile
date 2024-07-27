pipeline {
    agent any
    parameters {
        string(name: 'image', defaultValue: 'personal-page', description: 'Image name')
        string(name: 'tag', defaultValue: '0.0.1', description: 'Image version')
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh "docker  build  --no-cache -t ${image}:${tag} . "

            }
        }
        stage('Pruebas Unitarias') {
            steps {
                echo 'Unitarias Test'
            }
        }
        stage('Scan image Security') {
            steps {
                sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --insecure ${image}:${tag}"
            }
        }
        stage('Push Registry') {
            steps {
                sh "docker tag ${image}:${tag} poswark/${image}:${tag}"
                sh "docker push poswark/${image}:${tag}"
                echo 'https://hub.docker.com/repository/docker/poswark/demo_web/general'
            }
        }
    }
}
