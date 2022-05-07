
  
# Alpine Linux with OpenJDK JRE
FROM openjdk:8-jre-alpine

EXPOSE 8181

# copy jar into image
COPY target/spring-petclinic-2.6.0-SNAPSHOT.jar /usr/bin/spring-petclinic.jar

# run application with this command line 
ENTRYPOINT ["java","-jar","/usr/bin/spring-petclinic.jar","--server.port=8181"]
#
# Package stage
#
#FROM openjdk:11-jre-slim
#COPY --from=build /home/app/target/spring-petclinic-2.6.0-SNAPSHOT.jar /usr/local/lib/spring-petclinic.jar
#EXPOSE 8000
#ENTRYPOINT ["java","-jar","/usr/local/lib/spring-petclinic.jar"]

