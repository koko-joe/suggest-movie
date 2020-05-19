# Multi stage build to have a super slim container running in the cloud.

# Build a JAR
FROM maven:3.6.3-openjdk-11 AS builder
 
# maven cache is not persisted so dependencies are downloaded everytime
# as long as pom.xml is not changed, this layer of the image is not rebuild
# this saves a lot of time cause a lot less downloads are necessary
COPY pom.xml /build/ 
WORKDIR /build
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package
 
# Run the server
FROM openjdk:11 AS server
 
VOLUME /tmp
COPY --from=builder "/build/target/suggestmovie-*-SNAPSHOT.jar" app.jar

# see https://devcenter.heroku.com/articles/java-memory-issues#configuring-java-to-run-in-a-container
CMD [ "sh", "-c", "java -Dserver.port=$PORT -Xmx300m -Xss512k -XX:CICompilerCount=2 -Dfile.encoding=UTF-8 -XX:+UseContainerSupport -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
