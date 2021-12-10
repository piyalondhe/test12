FROM public.ecr.aws/docker/library/httpd:latest
COPY /var/lib/jenkins/workspace/pipeline-test/target/web-project.war /usr/local/apache2/htdocs/
