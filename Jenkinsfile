pipeline {
    agent any

    environment {
        PRISMA_CLOUD_COMPUTE_API = "https://api2.prismacloud.io"
        PRISMA_ACCESS_KEY = credentials("PRISMA_ACCESS_KEY")  // Stored in Jenkins Credentials
        PRISMA_SECRET_KEY = credentials("PRISMA_SECRET_KEY")  // Stored in Jenkins Credentials
        IMAGE_NAME = "denisprisma-test:v1"
    }

    stages {
        stage("Checkout Code") {
            steps {
                git branch: "main", url: "https://github.com/D3nchikP/denisprisma.git"
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage("Download TwistCLI") {
            steps {
                sh '''
                curl -k -u "$PRISMA_ACCESS_KEY:$PRISMA_SECRET_KEY" \
                  "$PRISMA_CLOUD_COMPUTE_API/api/v1/util/twistcli" \
                  -o twistcli
                chmod +x twistcli
                '''
            }
        }

        stage("Scan Docker Image with TwistCLI") {
            steps {
                sh '''
                ./twistcli images scan --address $PRISMA_CLOUD_COMPUTE_API \
                  --user $PRISMA_ACCESS_KEY --password $PRISMA_SECRET_KEY \
                  --details $IMAGE_NAME
                '''
            }
        }
    }
}
