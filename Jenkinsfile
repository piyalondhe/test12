def tomcatIp = '18.184.98.114'
def tomcatUser = 'ec2-user'
pipeline{
	agent any
	environment {
        ARTIFACT_NAME = 'web-project.war'
        AWS_S3_BUCKET = 'artifactsuploads-to-s3'
        AWS_EB_APP_NAME = 'MyApp'
        AWS_EB_ENVIRONMENT = 'MyApp'
        AWS_EB_APP_VERSION = "${BUILD_ID}"
    }
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
	


}
           
	}
   }
   
	
   stage('Deploying to Elastic BeanStalk'){
	   steps{
		    //sh "aws elasticbeanstalk --region eu-central-1 create-application --application-name MyApp "
		   sh 'aws elasticbeanstalk --region eu-central-1  create-application-version --application-name $AWS_EB_APP_NAME --version-label $AWS_EB_APP_VERSION --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$ARTIFACT_NAME'
		


	     }
   }
		
		
	}
	
		
}
