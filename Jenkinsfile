pipeline {
    agent any

    environment {
        PRISMA_CLOUD_USER = credentials('PRISMA_ACCESS_KEY')
        PRISMA_CLOUD_PASSWORD = credentials('PRISMA_SECRET_KEY')
        PRISMA_CLOUD_URL = "https://us-east1.cloud.twistlock.com/us-2-158320372"
        IMAGE_NAME = "denisprisma-test:v1"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/D3nchikP/denisprisma.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Download TwistCLI') {
            steps {
                sh """
                    curl -k -u "$PRISMA_CLOUD_USER:$PRISMA_CLOUD_PASSWORD" \
                        -o twistcli \
                        $PRISMA_CLOUD_URL/api/v1/util/twistcli
                    chmod +x twistcli
                """
            }
        }

        stage('Scan Docker Image with TwistCLI') {
            steps {
                script {
                    def scanResult = sh(
                        script: """
                            ./twistcli images scan --address $PRISMA_CLOUD_URL \
                                --user "$PRISMA_CLOUD_USER" \
                                --password "$PRISMA_CLOUD_PASSWORD" \
                                --details $IMAGE_NAME \
                                --no-color
                        """,
                        returnStatus: true
                    )

                    if (scanResult != 0) {
                        error("❌ Vulnerabilities detected! Stopping the build.")
                    }
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Build failed due to vulnerabilities or errors."
        }
        success {
            echo "✅ Build completed successfully!"
        }
    }
}
