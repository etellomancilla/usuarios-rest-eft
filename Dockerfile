FROM eclipse-temurin:17-jre-jammy
LABEL maintainer="Duoc <usuarios>"
WORKDIR /app
COPY target/usuariosBuild.jar /app/usuariosBuild.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/usuariosBuild.jar"]
