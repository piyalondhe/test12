node{
   def tomcatIp = '3.64.215.59'
   def tomcatUser = 'ec2-user'
	
   stage('SCM Checkout'){
        git branch: 'master', 
	        url: 'https://github.com/piyalondhe/test12.git'
   }
   stage('Maven Build'){
 
		sh "mvn clean package"
	   	
   }
   
   stage('Deploy Dev'){
	   
	   
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war ${tomcatUser}@${tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}
      
   }
}

