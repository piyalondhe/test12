properties([
  parameters([
    number(name: 'tomcatIp', defaultValue: '', description: 'Ip address', )
   ])
])
pipeline{
   def tomcatUser = 'ec2-user'
	agent any
	stages{	
   stage('SCM Checkout'){
        git branch: 'main', 
	        url: 'https://github.com/piyalondhe/test12.git'
   }
   stage('Maven Build'){
 
		sh "mvn clean package"
	   	
   }
   
   stage('Deploy Dev'){
	   
	   
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war ${tomcatUser}@${params.tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}
      
   }
}
}
