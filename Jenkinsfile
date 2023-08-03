pipeline {
  agent { label 'www.tugboat.qa' }

  stages {
    stage('Deploy') {
      when {
        branch 'main'
      }

      environment {
        HUGO = 'https://github.com/gohugoio/hugo/releases/download/v0.58.3/hugo_0.58.3_Linux-64bit.tar.gz'
      }

      parameters {
        string(name: 'EMAIL_TO', defaultValue: 'admin@example.com', description: '')
      }

      steps {
        sh 'curl -Ls "${HUGO}" | tar -zxf - hugo'
        sh "sed -i '/baseURL/s/#//g' config.toml"
        sh "sed -i '/googleAnalytics/s/#//g' config.toml"
        sh './hugo'
      }

      post {
        unsuccessful {
          mail (
            to: "${EMAIL_TO}",
            subject: "Build: ${env.JOB_NAME} - Deployment failed",
            body: "Job Failed - \"${env.JOB_NAME}\" build: ${env.BUILD_NUMBER}\n\nView the log at:\n ${env.BUILD_URL}"
          );
        }
      }
    }
  }
}
