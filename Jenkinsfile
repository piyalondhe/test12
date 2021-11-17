node{
   def tomcatIp = 'ec2-18-193-68-47.eu-central-1.compute.amazonaws.com'
   def tomcatUser = 'ec2-user'
   def stopTomcat = "ssh ${tomcatUser}@${tomcatIp} /home/ec2-user/apache-tomcat-9.0.54/bin/shutdown.sh"
   def startTomcat = "ssh ${tomcatUser}@${tomcatIp} /home/ec2-user/apache-tomcat-9.0.54/bin/startup.sh"
   def copyWar = "scp -o StrictHostKeyChecking=no target/myweb.war ${tomcatUser}@${tomcatIp}: /home/ec2-user/apache-tomcat-9.0.54/webapps/"
   stage('SCM Checkout'){
        git branch: 'main', 
	        url: 'https://github.com/piyalondhe/test12.git'
   }
   stage('Maven Build'){
 
		sh "mvn clean package"
   }
   
   stage('Deploy Dev'){
	   sh 'mv target/myweb*.war target/myweb.war' 
	   
       sshagent(['tomcat-dev']) {
			sh "${stopTomcat}"
			sh "${copyWar}"
			sh "${startTomcat}"
	   }
   }
}

