pipeline {
  agent {
    cloud 'kubernetes'
    label 'agent-docker'
    defaultContainer "agent-docker"
  }
  environment {
    REG_OWNER="helxplatform"
    REG_APP="jupyter-datascience-db"
    COMMIT_HASH="${sh(script:"git rev-parse --short HEAD", returnStdout: true).trim()}"
    IMAGE_NAME="${REG_OWNER}/${REG_APP}"
    TAG1="$BRANCH_NAME"
    TAG2="$COMMIT_HASH"
  }
  stages {
    stage('Build') {
      steps {
        sh '''
        docker build -t $IMAGE_NAME:$TAG1 -t $IMAGE_NAME:$TAG2 .
        '''
      }
    }
    stage('Test') {
      steps {
        sh '''
        echo "Test Stage"
        '''
      }
    }
    stage('Publish') {
      environment {
        DOCKERHUB_CREDS = credentials("${env.CONTAINERS_REGISTRY_CREDS_ID_STR}")
        DOCKER_REGISTRY = "${env.REGISTRY}"
      }
      steps {
        sh '''
        echo publish
        echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin $DOCKER_REGISTRY
        docker push $IMAGE_NAME:$TAG1
        docker push $IMAGE_NAME:$TAG2
        '''
      }
    }
  }
}