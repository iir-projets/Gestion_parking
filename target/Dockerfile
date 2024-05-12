# Utilisation de l'image OpenJDK 17 alpine
FROM openjdk:17-jdk-alpine

# Arguments
ARG JAR_FILE=target/*.jar

# Copie du jar dans le conteneur avec le nom "app.jar"
COPY ${JAR_FILE} app.jar

# Commande d'exécution de l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app.jar"]
