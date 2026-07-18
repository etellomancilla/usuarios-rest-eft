pipeline {
    agent any

    environment {
        IMAGE_NAME = "usuarios-rest"
        CONTAINER_NAME = "usuarios-rest-container"
        // Jenkins ya ocupa el 8080 del host; la app se publica en 8081
        APP_PORT = "8081"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh './mvnw test'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Deploy') {
            steps {
                sh "docker rm -f ${CONTAINER_NAME} || true"
                sh "docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:8080 ${IMAGE_NAME}:latest"
            }
        }
    }

    post {
        success {
            echo 'Despliegue completado correctamente.'
        }
        failure {
            echo 'El pipeline falló. Revisar logs de la etapa correspondiente.'
        }
    }
}
