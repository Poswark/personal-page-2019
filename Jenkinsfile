@Library('sharedLibrary') _
import boxung.DockerBuild

pipeline {
    agent {
        kubernetes {
            label 'kaniko'
            yaml kanikoPodTemplate()
        }
    }
    parameters {
        string(name: 'image', defaultValue: 'personal-page', description: 'Image name')
        string(name: 'tag', defaultValue: '0.0.1', description: 'Image version')
    }
    stages {
        stage('Build') {
            agent {
                kubernetes {
                    label 'kaniko'
                    yaml kanikoPodTemplate()
                }
            }
            steps {
                withCredentials([file(credentialsId: 'KANIKO_JSON', variable: 'DOCKER_CONFIG_JSON')]) {
                    script {
                        sh "cp ${env.DOCKER_CONFIG_JSON} /kaniko/.docker/config.json"
                        DockerBuild.build(this, [image: "${params.image}", tag: "${params.tag}", dockerConfig: '/kaniko/.docker/config.json'])
                        echo 'Building..'
                    }
                }
            }
        }
        stage('Unit Tests') {
            agent {
                kubernetes {
                    label 'trivy'
                    yaml trivyPodTemplate()
                }
            }
            steps {
                echo 'Running Unit Tests'
                // Add your unit test commands here
            }
        }
        stage('Security Scan') {
            agent {
                kubernetes {
                    label 'trivy'
                    yaml trivyPodTemplate()
                }
            }
            steps {
                sh "docker pull poswark/${params.image}:${params.tag}"
                sh "trivy image --insecure poswark/${params.image}:${params.tag}"
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
