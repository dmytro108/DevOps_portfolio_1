pipeline {
    agent any

// ******************* Settings ************************************
    environment {
        registry = 'dmytro108/weatherapp'
    }

   stages {

// ******************** GIT Checkout *******************************
        stage('Git checkout') {
            steps {
                checkout scm
            }
        }

 // **************** Build *****************************************   
        stage('Build') {
            steps {
                
            }                
        }
 
 // ******************** Test ************************************   
        stage('Test') {
            steps {

            }        
        }

// ************************ Docker Build *************************
        stage('Docker Build') {
            steps {
                script{
                    docker.build("${registry}:${env.BUILD_ID}")
                }
            }
        }

// ******************* Docker Hub Publish *****************************
        stage('Publish') {
            steps {
                script {
                        docker.withRegistry('', 'dockerhub-id') {
                            docker.image("${registry}:${env.BUILD_ID}").push('latest')
                        }         
                }

            }
        } 
    }
}