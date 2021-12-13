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
		sh "mvn clean install" }
   }


stage('artifacts to s3') {
	steps{
withAWS(region: 'eu-central-1', role: 's3role') {
	sh "aws s3 --region eu-central-1 ls"
	 //sh "aws s3  mb s3://artifactsuploads-to-s3"
	 sh "aws s3 cp /var/lib/jenkins/workspace/pipeline-test/target/web-project.war s3://artifactsuploads-to-s3/"    

}
           
	}
   }
   
	stage('Deploy to EBS') {
	steps{
withAWS(region: 'eu-central-1', role: 's3role') {
	sh "aws elasticbeanstalk create-application-version --application-name my-application --version-label v1 --source-bundle S3Bucket=artifactsuploads-to-s3,S3Key=web-project.war"
	//sh "aws elasticbeanstalk create-environment --cname-prefix my-cname --application-name my-app --version-label v1 --environment-name my-env --solution-stack-name "64bit Amazon Linux 2015.03 v2 running Tomcat 8 Java 8""    

}
           
	}
   }
   stage('Deploying to web-server'){
	   steps{
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-test/target/web-project.war ${tomcatUser}@${tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}  }
   }
		
	}
	
		
}
