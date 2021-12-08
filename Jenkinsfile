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

stage ('Nexus Upload') {
      steps {
      nexusArtifactUploader(
      nexusVersion: 'nexus3',
      protocol: 'http',
      nexusUrl: 'ec2-3-68-198-226.eu-central-1.compute.amazonaws.com:8081',
      groupId: 'web-project',
      version: '1.0-SNAPSHOT',
      repository: 'maven-snapshots',
      credentialsId: 'nexus',
      artifacts: [
      [artifactId: 'web-project',
      classifier: '',
      file: '/var/lib/jenkins/workspace/maven-test/target/web-project.war',
      type: 'war']
      ])
      }
    }
		stage('Artifacts to s3')
		{
withCredentials([<object of type com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding>]) {
    sh "aws s3 ls"
    sh "aws s3 mb s3://artifacts-to-upload"
    sh "aws s3 cp /var/lib/jenkins/workspace/maven-test/target/web-project.war s3://artifacts-to-upload"
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
