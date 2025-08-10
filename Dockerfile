FROM openjdk:17-jdk-slim

WORKDIR /app

# Install Gradle CLI to generate wrapper
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-8.7-bin.zip && \
    unzip gradle-8.7-bin.zip -d /opt && \
    ln -s /opt/gradle-8.7/bin/gradle /usr/bin/gradle && \
    rm gradle-8.7-bin.zip


COPY ./app/ ./

RUN gradle wrapper

RUN chmod +x ./gradlew

RUN ls -la ./gradlew

RUN apt-get update && apt-get install -y file && rm -rf /var/lib/apt/lists/*

RUN file ./gradlew

RUN head -n 1 ./gradlew | cat -v

RUN ./gradlew build

EXPOSE 8080

CMD ["java", "-jar", "build/libs/springboot-postgresql-0.0.1-SNAPSHOT.jar"]