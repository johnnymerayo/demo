FROM maven:3.6.1-jdk-8-alpine AS MAVEN_BUILD

# copy the pom and src code to the container
COPY ./ ./

# package our application code
RUN mvn clean package -Dmaven.test.skip=true

# build using open jdk 8 on alpine 3.9
FROM openjdk:8-jre-alpine3.9

# copy jar file
COPY --from=MAVEN_BUILD target/*.jar /app.jar

# set the startup command to execute the jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /app.jar" ]
