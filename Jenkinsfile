pipeline {
    agent any
  
  environment {
    // Adjust variables below
    IMAGE_NAME  = "docker.io/atwatanmalikm/java-petclinicapp"
    TAG         = sh (script: "date +%y%m%d%H%M", returnStdout: true).trim()

    // Do not edit variables below
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
  }
  
  stages {
    stage('Preparation') {
      steps {
        sh "echo App Version = $TAG"
      }
    }

    stage('Test') {
      steps {
        sh "./mvnw test"
      }
      post {
        success {
           echo "Test Successful"
        }
        failure {
           echo "Test Failed"
        }
      }
    }
    
    stage("Build & Push Image"){
      steps{
        sh """
        docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}
        docker build -t ${IMAGE_NAME}:${TAG} .
        docker push ${IMAGE_NAME}:${TAG}
        """
      }
      post {
        success {
           echo "Build & Push Successful"
        }
        failure {
           echo "Build & Push Failed"
        }
      }
    }
  }
}
