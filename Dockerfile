# Build Stage 1
FROM eclipse-temurin:17-jdk-jammy as build

WORKDIR /build
COPY . .
RUN ./mvnw package

# Build Stage 2
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=build /build/target ./target

EXPOSE 8080

CMD java -jar target/*.jar
