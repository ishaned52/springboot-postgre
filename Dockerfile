FROM openjdk:17-jdk-slim

WORKDIR /app

COPY ./app/ ./

RUN chmod +x ./gradlew

RUN ls -la ./gradlew

RUN apt-get update && apt-get install -y file && rm -rf /var/lib/apt/lists/*

RUN file ./gradlew

RUN head -n 1 ./gradlew | cat -v

RUN ./gradlew build

EXPOSE 8080

CMD ["java", "-jar", "build/libs/springboot-postgresql-0.0.1-SNAPSHOT.jar"]