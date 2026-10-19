pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Zhassulan'
        STUDENT_SURNAME = 'Zhumakhan'
        STUDENT_GROUP   = 'IT2-2308'
        STUDENT_ID      = '37359'
        IMAGE_NAME      = 'zhumakhan-zhassulan-devops'
        CONTAINER_NAME  = 'zhumakhan-zhassulan-container'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'echo "Commit used by Jenkins:"; git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                echo "Student: ${env.STUDENT_NAME} ${env.STUDENT_SURNAME}"
                echo "Group: ${env.STUDENT_GROUP}"
                echo "Student ID: ${env.STUDENT_ID}"
                sh 'chmod +x scripts/*.sh'
                sh 'ls -la'
            }
        }

        stage('Test') {
            steps {
                sh './scripts/test.sh'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest .'
                sh 'docker images ${IMAGE_NAME}'
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} || true
                    docker run --name ${CONTAINER_NAME} \
                        -e STUDENT_NAME=${STUDENT_NAME} \
                        -e STUDENT_SURNAME=${STUDENT_SURNAME} \
                        -e STUDENT_GROUP=${STUDENT_GROUP} \
                        -e STUDENT_ID=${STUDENT_ID} \
                        ${IMAGE_NAME}:latest
                    docker ps -a --filter name=${CONTAINER_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline finished successfully. Git commit: ${env.GIT_COMMIT}"
        }
        failure {
            echo 'Pipeline failed. Check the stage that is marked red.'
        }
    }
}
