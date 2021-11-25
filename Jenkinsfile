def tomcatIp = '3.64.11.139'
def tomcatUser = 'ec2-user'
node{
	
   stage('Git Checkout') {
git url: 'https://github.com/piyalondhe/test12.git',branch: 'main'
	}
	
   stage('Maven Build'){
		sh "mvn clean package" }
   
   stage('Deploying to container'){
	   
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war ${tomcatUser}@${tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}  }
	
	 post { 
        always { 
            cleanWs()
        }
    }
		

}
