def tomcatIp = '3.64.215.59'
def tomcatUser = 'ec2-user'
pipeline{
  agent any
	 triggers { pollSCM('H */4 * * 1-5') }
	stages{
		
  	 stage('Declarative SCM Checkout'){
	   steps{
        git branch: 'main', url: 'https://github.com/piyalondhe/test12.git'
   }
   }
   stage('Maven Building'){
	   steps{
		sh "mvn clean package"
	   }
	   	
   }
   
   stage('Deploying to container'){
	   
	   steps{
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war ${tomcatUser}@${tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}
      
   }
   }
		
}
}
