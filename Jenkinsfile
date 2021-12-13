def tomcatIp = '18.184.98.114'
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
withAWS(region: 'eu-central-1', role: 's3role')
		 
	{
	sh "aws s3 ls"
	 sh "aws s3 cp /var/lib/jenkins/workspace/pipeline-test/target/web-project.war s3://artifactsuploads-to-s3/"   
	sh "aws elasticbeanstalk create-application --application-name MyApp --description "my application""

sh "aws elasticbeanstalk --region eu-central-1 create-application-version --application-name My-App --version-label v1 --description MyAppv1 --source-bundle S3Bucket="artifactsuploads-to-s3",S3Key="web-project.war" --auto-create-application"

sh "aws elasticbeanstalk --region eu-central-1 create-environment --application-name My-app --environment-name my-env --cname-prefix My-app --version-label v1 --solution-stack-name "64bit Amazon Linux 2018.03 v3.4.0 running Tomcat 8 Java 8""



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
