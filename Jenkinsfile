properties([
  parameters([
    string(name: 'tomcatIp', defaultValue: '', description: 'Ip address', )
   ])
])
def tomcatUser = 'ec2-user'
pipeline{
  agent any
	stages{	
   stage('SCM Checkout'){
	   steps{
        git branch: 'main', 
	        url: 'https://github.com/piyalondhe/test12.git'
   }
   }
   stage('Maven Build'){
	   steps{
		sh "mvn clean package"
	   }
	   	
   }
   
   stage('Deploy Dev'){
	   
	   steps{
	   sshagent(['tomcat-deployer'])  {
    sh "scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/pipeline-demo/target/web-project.war ${tomcatUser}@${params.tomcatIp}:/home/ec2-user/apache-tomcat-9.0.54/webapps/"
		}
      
   }
   }
		
	post { 
        always { 
            echo 'It will always print!'
        }
    }
}
}
