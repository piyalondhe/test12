def tomcatIp = '3.68.198.226'
def tomcatUser = 'ec2-user'
pipeline{
	agent any
	triggers {
        cron('* * * * 1-5')
    }
	stages{
   stage('Git Checkout') {
	steps{
	git url: 'https://github.com/piyalondhe/test12.git',branch: 'main'
	}
		}
	
   stage('Maven Build'){
	   steps{
		sh "mvn clean package" }
   }


stage('artifacts to s3') {
	steps{
 withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
	  //sh "aws sts get-session-token --profile priyanka --serial-number arn:aws:iam::995615868335:mfa/A119916966 --token-code 936959"
	 sh "aws s3 --region eu-central-1 ls"
	 sh "aws s3  mb s3://artifactsuploads-to-s3"
         sh "aws s3 cp /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war s3://artifactsuploads-to-s3/"
         }
           
	}
   }
   
   stage('Deploying to container'){
	   steps{
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war ${tomcatUser}@${tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}  }
   }
		
	}
	 post { 
        always { 
            cleanWs()
        }
    }
		
}
