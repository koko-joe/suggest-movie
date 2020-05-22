FROM openjdk:11
 
WORKDIR /app

# download dependencies can take minutes
# separate dependency download and installation to use doctrine cache
COPY pom.xml mvnw migrate_database.sh ./
COPY .mvn ./.mvn
RUN ./mvnw dependency:go-offline

COPY src ./src
RUN ./mvnw clean package -Dmaven.test.skip=true

# non-root user for better security 
RUN useradd -m myuser
USER myuser

# see https://devcenter.heroku.com/articles/java-memory-issues#configuring-java-to-run-in-a-container
CMD [ "sh", "-c", "java -Dserver.port=${PORT} -Xmx300m -Xss512k -XX:CICompilerCount=2 -Dfile.encoding=UTF-8 -XX:+UseContainerSupport -Djava.security.egd=file:/dev/./urandom -jar /app/target/app.jar" ]
