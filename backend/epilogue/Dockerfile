#FROM openjdk:17-jre-slim // 현재 사용 불가
FROM openjdk:22-ea-17-slim
COPY build/libs/epilogue-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]