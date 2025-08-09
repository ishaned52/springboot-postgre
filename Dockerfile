FROM openjdk:17-jdk-slim

WORKDIR /app

COPY ./app/ ./

RUN chmod +x ./gradlew

RUN ls -la ./gradlew

RUN apt-get update && apt-get install -y file && rm -rf /var/lib/apt/lists/*

RUN file ./gradlew

RUN head -n 1 ./gradlew | cat -v

RUN ./gradlew build
