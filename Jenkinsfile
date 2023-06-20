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

 // ******************** Test ************************************   
        stage('Test') {
            steps {
              script{
                docker.image('nginx').withRun('-p 8888:80 \
                                               -v ./nginx/:/etc/nginx/conf.d/ \
                                               -v ./src/:/usr/share/nginx/html/weatherapicom/ \
                                               -v ./src/index.html:/usr/share/nginx/html/index.html') { c ->
                    sh 'curl -I -s -o /dev/null -w "%{http_code}"  http://localhost:8888/weather/ > /dev/null '
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