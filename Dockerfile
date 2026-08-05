FROM gradle:9.5-jdk17 as build
WORKDIR /app
COPY . .
RUN ./gradlew clean build --no-daemon --refresh-dependencies

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/build/libs/*.jar notificacao.jar

EXPOSE 8082

CMD ["java", "-jar", "/app/notificacao.jar"]