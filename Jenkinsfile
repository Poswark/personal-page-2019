@Library('sharedLibrary') _
pipeline {
    agent any
    parameters {
        string(name: 'image', defaultValue: 'personal-page', description: 'Image name')
        string(name: 'tag', defaultValue: 'personal-page', description: 'Image version')
    }
    stages {
        stage('Build') {
            steps {
                script {
                    DockerBuild.build(image: "personal-page",
                                      tag: "0.0.1")
                echo 'Building..'
                }
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
