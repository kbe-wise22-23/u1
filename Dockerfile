FROM openjdk:17-jdk-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw clean install -DskipTests
RUN ./mvnw package
# RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM openjdk:17-jdk-alpine

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
ARG DEPENDENCY=/workspace/app
ARG JAR_FILE=target/*.jar
COPY --from=build ${DEPENDENCY}/${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
