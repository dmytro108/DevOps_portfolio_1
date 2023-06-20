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
/*
 // **************** Build *****************************************   
        stage('Build') {
            steps {
                
            }                
        }
  */
 // ******************** Test ************************************   
        stage('Test') {
            steps {
              script{
                docker.image('nginx').withRun('-p 8888:80 \
                                               -v ./nginx/default.conf:/etc/nginx/conf.d/ \
                                               -v ./src/:/usr/share/nginx/html/weatherapicom/ \
                                               -v ./src/index.html:/usr/share/nginx/html/index.html') { c ->
                    sh 'cirl -I http://localhost:8888/'
                }
              }  
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