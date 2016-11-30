mvn clean package -DskipTests
docker rmi jcito/agilefant
docker build -t jcito/agilefant .
