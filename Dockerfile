FROM openjdk:11 as buildstage
WORKDIR /app
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src
RUN chmod +x mvnw
RUN ./mvnw package
RUN pwd
RUN ls -l
RUN cd target/
RUN pwd
RUN ls -l
COPY *.jar docker-app.jar
#COPY ./target/*.jar docker-app.jar

FROM openjdk:11
COPY --from=buildstage /app/docker-app.jar .
ENTRYPOINT ["java","-jar","docker-app.jar"]