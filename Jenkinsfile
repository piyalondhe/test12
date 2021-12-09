def tomcatIp = '18.196.15.151'
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
		sh "mvn clean install -Dv=${BUILD_NUMBER}" }
   }


stage('artifacts to s3') {
	steps{
withAWS(region: 'eu-central-1', role: 's3role') {
	sh "aws s3 --region eu-central-1 ls"
	 //sh "aws s3  mb s3://artifactsuploads-to-s3"
	 sh "aws s3 cp /var/lib/jenkins/workspace/pipeline-demo/target/*.war s3://artifactsuploads-to-s3/"    

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
	
		
}
