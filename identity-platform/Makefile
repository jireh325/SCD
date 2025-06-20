.PHONY: build start stop clean logs

# Construction de tous les services
build:
	mvn clean package -DskipTests

# Démarrage de l'infrastructure
start-infra:
	docker-compose up -d postgres redis keycloak prometheus grafana elasticsearch logstash kibana

# Démarrage complet
start: start-infra
	mvn spring-boot:run -pl discovery-service &
	sleep 10
	mvn spring-boot:run -pl config-service &
	sleep 10
	mvn spring-boot:run -pl api-gateway-service &
	mvn spring-boot:run -pl auth-service &
	mvn spring-boot:run -pl identity-registry-service &
	mvn spring-boot:run -pl identity-context-service &
	mvn spring-boot:run -pl basic-identity-service &

# Arrêt
stop:
	docker-compose down
	pkill -f "spring-boot:run" || true

# Nettoyage
clean:
	mvn clean
	docker-compose down -v
	docker system prune -f

# Logs
logs:
	docker-compose logs -f
