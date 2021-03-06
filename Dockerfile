# Inject the JAR file into a new container 
FROM  openjdk:11
WORKDIR /app
COPY /target/hello-world-*.jar /app/helloworld.jar
EXPOSE 8080
#ENTRYPOINT ["sh", "-c"]
#CMD ["java -jar helloworld.jar"]
ENTRYPOINT ["java", "-jar","/app/helloworld.jar"]
