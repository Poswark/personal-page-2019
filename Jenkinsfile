@Library('sharedLibrary') _
import boxung.DockerBuild

pipeline {
    agent any
    parameters {
        string(name: 'image', defaultValue: 'personal-page', description: 'Image name')
        string(name: 'tag', defaultValue: '0.0.1', description: 'Image version')
    }
    stages {
        stage('Build') {
            steps {
                withCredentials([file(credentialsId: 'KANIKO_JSON', variable: 'DOCKER_CONFIG_JSON')]) {
                    script {
                        sh "cp ${env.DOCKER_CONFIG_JSON} .kaniko/docker.config.json"

                        // Llama a la función DockerBuild para construir la imagen
                        DockerBuild.build(this, [image: "${params.image}", tag: "${params.tag}", dockerConfig: '.kaniko/docker.config.json'])
                        echo 'Building..'
                    }
                }
            }
        }
        stage('Unit Tests') {
            steps {
                echo 'Running Unit Tests'
                // Add your unit test commands here
            }
        }
        stage('Security Scan') {
            steps {
                sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --insecure ${params.image}:${params.tag}"
            }
        }
        stage('Push to Registry') {
            steps {
                script {
                    def imageTag = "poswark/${params.image}:${params.tag}"
                    sh "docker tag ${params.image}:${params.tag} ${imageTag}"
                    sh "docker push ${imageTag}"
                    echo 'Image pushed to: https://hub.docker.com/repository/docker/poswark/demo_web/general'
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
            // Add any success notifications or actions here
        }
        failure {
            echo 'Pipeline failed.'
            // Add any failure notifications or actions here
        }
        cleanup {
            echo 'Cleaning up...'
            // Add any cleanup actions here
        }
    }
}
