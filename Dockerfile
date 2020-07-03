FROM store/softwareag/webmethods-microservicesruntime:10.5.0.3

MAINTAINER SoftwareAG

USER root

COPY ./startup/application.properties /opt/softwareag/IntegrationServer/application.properties

RUN chmod -R 777 /opt/softwareag/	
