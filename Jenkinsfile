node{
   def tomcatIp = '18.193.68.47'
   def tomcatUser = 'ec2-user'
   //def stopTomcat = "ssh ${tomcatUser}@${tomcatIp} /home/ec2-user/apache-tomcat-9.0.54/bin/shutdown.sh"
   //def startTomcat = "ssh ${tomcatUser}@${tomcatIp} /home/ec2-user/apache-tomcat-9.0.54/bin/startup.sh"
   //def copyWar = "scp -o StrictHostKeyChecking=no /target/web-project.war ${tomcatUser}@${tomcatIp}: /home/ec2-user/apache-tomcat-9.0.54/webapps/"
   stage('SCM Checkout'){
        git branch: 'main', 
	        url: 'https://github.com/piyalondhe/test12.git'
   }
   stage('Maven Build'){
 
		sh "mvn clean package"
	   	sh "mv target/*.war target/web-project.war"
   }
   
   stage('Deploy Dev'){
	   
	   
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war ${tomcatUser}@${tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}
      
   }
}

