#!/bin/bash

# Script de génération d'infrastructure microservices Spring Boot
# Architecture hexagonale pour plateforme d'identité numérique

set -e

PROJECT_ROOT="identity-platform"
JAVA_VERSION="17"
SPRING_BOOT_VERSION="3.2.0"
GROUP_ID="com.identity.platform"

echo "🚀 Génération de l'infrastructure microservices Identity Platform"
echo "================================================================"

# Création du répertoire racine
mkdir -p $PROJECT_ROOT
cd $PROJECT_ROOT

# Fonction pour créer la structure hexagonale d'un microservice
create_hexagonal_structure() {
    local service_name=$1
    local service_port=$2
    local description=$3
    
    echo "📦 Création du microservice: $service_name"
    
    # Structure de base
    mkdir -p $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}
    mkdir -p $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/application/{service,dto,port}
    mkdir -p $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/domain/{model,repository,exception}
    mkdir -p $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/infrastructure/{adapter,config,persistence,web}
    mkdir -p $service_name/src/main/resources
    mkdir -p $service_name/src/test/java/${GROUP_ID//.//}/${service_name//-//}
    
    # pom.xml pour chaque microservice
    cat > $service_name/pom.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>$GROUP_ID</groupId>
        <artifactId>identity-platform-parent</artifactId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>
    
    <artifactId>$service_name</artifactId>
    <name>$service_name</name>
    <description>$description</description>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-config</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-registry-prometheus</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
EOF

    # Application principale
    local class_name=$(echo $service_name | sed 's/-//g' | sed 's/./\U&/')
    cat > $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/${class_name}Application.java << EOF
package ${GROUP_ID}.${service_name//-/.};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class ${class_name}Application {
    public static void main(String[] args) {
        SpringApplication.run(${class_name}Application.class, args);
    }
}
EOF

    # Configuration application.yml
    cat > $service_name/src/main/resources/application.yml << EOF
server:
  port: $service_port

spring:
  application:
    name: $service_name
  
  datasource:
    url: jdbc:postgresql://localhost:5432/${service_name//-/_}_db
    username: \${DB_USERNAME:postgres}
    password: \${DB_PASSWORD:password}
    driver-class-name: org.postgresql.Driver
  
  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
  
  redis:
    host: localhost
    port: 6379
    password: \${REDIS_PASSWORD:}
  
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: http://localhost:8080/auth/realms/identity-platform

eureka:
  client:
    service-url:
      defaultZone: http://localhost:8761/eureka/
  instance:
    prefer-ip-address: true

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: always
  metrics:
    export:
      prometheus:
        enabled: true

logging:
  level:
    ${GROUP_ID}: DEBUG
    org.springframework.security: DEBUG
EOF

    # Dockerfile
    cat > $service_name/Dockerfile << EOF
FROM openjdk:$JAVA_VERSION-jre-slim

WORKDIR /app

COPY target/$service_name-*.jar app.jar

EXPOSE $service_port

ENTRYPOINT ["java", "-jar", "app.jar"]
EOF

    # Structure hexagonale - Domain
    cat > $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/domain/model/Entity.java << EOF
package ${GROUP_ID}.${service_name//-/.}.domain.model;

public abstract class Entity {
    // Base entity class
}
EOF

    cat > $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/domain/repository/Repository.java << EOF
package ${GROUP_ID}.${service_name//-/.}.domain.repository;

public interface Repository<T, ID> {
    // Base repository interface
}
EOF

    # Structure hexagonale - Application
    cat > $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/application/service/ApplicationService.java << EOF
package ${GROUP_ID}.${service_name//-/.}.application.service;

public interface ApplicationService {
    // Application service interface
}
EOF

    cat > $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/application/port/Port.java << EOF
package ${GROUP_ID}.${service_name//-/.}.application.port;

public interface Port {
    // Port interface
}
EOF

    # Structure hexagonale - Infrastructure
    cat > $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/infrastructure/config/DatabaseConfig.java << EOF
package ${GROUP_ID}.${service_name//-/.}.infrastructure.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "${GROUP_ID}.${service_name//-/.}.infrastructure.persistence")
public class DatabaseConfig {
}
EOF

    cat > $service_name/src/main/java/${GROUP_ID//.//}/${service_name//-//}/infrastructure/web/RestController.java << EOF
package ${GROUP_ID}.${service_name//-/.}.infrastructure.web;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("/api/v1")
public class RestController {
    // REST controllers
}
EOF

    echo "✅ Microservice $service_name créé avec succès"
}

# Services Core
create_hexagonal_structure "identity-registry-service" "8081" "Service de registre des identités"
create_hexagonal_structure "identity-context-service" "8082" "Service de contexte des identités"
create_hexagonal_structure "basic-identity-service" "8083" "Service d'identité de base"
create_hexagonal_structure "security-service" "8084" "Service de sécurité et chiffrement"

# Services Métier
create_hexagonal_structure "medical-identity-service" "8091" "Service d'identité médicale"
create_hexagonal_structure "professional-identity-service" "8092" "Service d'identité professionnelle"
create_hexagonal_structure "family-identity-service" "8093" "Service d'identité familiale"
create_hexagonal_structure "legal-identity-service" "8094" "Service d'identité légale"
create_hexagonal_structure "financial-identity-service" "8095" "Service d'identité financière"
create_hexagonal_structure "biometric-identity-service" "8096" "Service d'identité biométrique"

# Services Transversaux
create_hexagonal_structure "identity-aggregator-service" "8101" "Service d'agrégation des identités"
create_hexagonal_structure "identity-orchestrator-service" "8102" "Service d'orchestration"
create_hexagonal_structure "event-bus-service" "8103" "Service de bus d'événements"
create_hexagonal_structure "backup-service" "8104" "Service de sauvegarde"

# Services Infrastructure
create_hexagonal_structure "api-gateway-service" "8080" "API Gateway"
create_hexagonal_structure "auth-service" "8085" "Service d'authentification"
create_hexagonal_structure "config-service" "8888" "Service de configuration"
create_hexagonal_structure "discovery-service" "8761" "Service de découverte Eureka"
create_hexagonal_structure "monitoring-service" "8086" "Service de monitoring"

# POM parent
cat > pom.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>$SPRING_BOOT_VERSION</version>
        <relativePath/>
    </parent>
    
    <groupId>$GROUP_ID</groupId>
    <artifactId>identity-platform-parent</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>pom</packaging>
    
    <name>Identity Platform</name>
    <description>Plateforme d'identité numérique microservices</description>
    
    <properties>
        <java.version>$JAVA_VERSION</java.version>
        <spring-cloud.version>2023.0.0</spring-cloud.version>
    </properties>
    
    <modules>
        <module>identity-registry-service</module>
        <module>identity-context-service</module>
        <module>basic-identity-service</module>
        <module>security-service</module>
        <module>medical-identity-service</module>
        <module>professional-identity-service</module>
        <module>family-identity-service</module>
        <module>legal-identity-service</module>
        <module>financial-identity-service</module>
        <module>biometric-identity-service</module>
        <module>identity-aggregator-service</module>
        <module>identity-orchestrator-service</module>
        <module>event-bus-service</module>
        <module>backup-service</module>
        <module>api-gateway-service</module>
        <module>auth-service</module>
        <module>config-service</module>
        <module>discovery-service</module>
        <module>monitoring-service</module>
    </modules>
    
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>\${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>\${java.version}</source>
                    <target>\${java.version}</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF

# Docker Compose pour l'infrastructure
cat > docker-compose.yml << EOF
version: '3.8'

services:
  # Base de données PostgreSQL
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: identity_platform
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./scripts/init-databases.sql:/docker-entrypoint-initdb.d/init-databases.sql

  # Redis Cache
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # Keycloak pour l'authentification
  keycloak:
    image: quay.io/keycloak/keycloak:22.0
    environment:
      KEYCLOAK_ADMIN: admin
      KEYCLOAK_ADMIN_PASSWORD: admin
      KC_DB: postgres
      KC_DB_URL: jdbc:postgresql://postgres:5432/keycloak
      KC_DB_USERNAME: postgres
      KC_DB_PASSWORD: password
    ports:
      - "8090:8080"
    depends_on:
      - postgres
    command: start-dev

  # Prometheus
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml

  # Grafana
  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    environment:
      GF_SECURITY_ADMIN_PASSWORD: admin
    volumes:
      - grafana_data:/var/lib/grafana

  # ELK Stack - Elasticsearch
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.9.0
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
    ports:
      - "9200:9200"
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data

  # Logstash
  logstash:
    image: docker.elastic.co/logstash/logstash:8.9.0
    ports:
      - "5044:5044"
    volumes:
      - ./monitoring/logstash.conf:/usr/share/logstash/pipeline/logstash.conf

  # Kibana
  kibana:
    image: docker.elastic.co/kibana/kibana:8.9.0
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch

volumes:
  postgres_data:
  redis_data:
  grafana_data:
  elasticsearch_data:
EOF

# Script d'initialisation des bases de données
mkdir -p scripts
cat > scripts/init-databases.sql << EOF
-- Création des bases de données pour chaque microservice
CREATE DATABASE identity_registry_service_db;
CREATE DATABASE identity_context_service_db;
CREATE DATABASE basic_identity_service_db;
CREATE DATABASE security_service_db;
CREATE DATABASE medical_identity_service_db;
CREATE DATABASE professional_identity_service_db;
CREATE DATABASE family_identity_service_db;
CREATE DATABASE legal_identity_service_db;
CREATE DATABASE financial_identity_service_db;
CREATE DATABASE biometric_identity_service_db;
CREATE DATABASE identity_aggregator_service_db;
CREATE DATABASE identity_orchestrator_service_db;
CREATE DATABASE event_bus_service_db;
CREATE DATABASE backup_service_db;
CREATE DATABASE auth_service_db;
CREATE DATABASE keycloak;
EOF

# Configuration Prometheus
mkdir -p monitoring
cat > monitoring/prometheus.yml << EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'spring-boot'
    metrics_path: '/actuator/prometheus'
    static_configs:
      - targets: ['host.docker.internal:8081', 'host.docker.internal:8082', 'host.docker.internal:8083']
EOF

# Makefile pour faciliter les opérations
cat > Makefile << EOF
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
EOF

# README
cat > README.md << EOF
# Identity Platform - Microservices Architecture

## Architecture

Cette plateforme utilise une architecture microservices avec Spring Boot et suit les principes de l'architecture hexagonale.

### Services

#### Services Core
- **identity-registry-service** (8081) - Registre des identités
- **identity-context-service** (8082) - Contexte des identités  
- **basic-identity-service** (8083) - Identité de base
- **security-service** (8084) - Sécurité et chiffrement

#### Services Métier
- **medical-identity-service** (8091) - Identité médicale
- **professional-identity-service** (8092) - Identité professionnelle
- **family-identity-service** (8093) - Identité familiale
- **legal-identity-service** (8094) - Identité légale
- **financial-identity-service** (8095) - Identité financière
- **biometric-identity-service** (8096) - Identité biométrique

#### Services Transversaux
- **identity-aggregator-service** (8101) - Agrégation
- **identity-orchestrator-service** (8102) - Orchestration
- **event-bus-service** (8103) - Bus d'événements
- **backup-service** (8104) - Sauvegarde

#### Services Infrastructure
- **api-gateway-service** (8080) - API Gateway
- **auth-service** (8085) - Authentification
- **config-service** (8888) - Configuration
- **discovery-service** (8761) - Découverte de services
- **monitoring-service** (8086) - Monitoring

## Démarrage

\`\`\`bash
# Construction
make build

# Démarrage de l'infrastructure
make start-infra

# Démarrage complet
make start

# Arrêt
make stop
\`\`\`

## URLs importantes

- **Eureka Dashboard**: http://localhost:8761
- **API Gateway**: http://localhost:8080
- **Keycloak**: http://localhost:8090
- **Grafana**: http://localhost:3000 (admin/admin)
- **Prometheus**: http://localhost:9090
- **Kibana**: http://localhost:5601

## Architecture Hexagonale

Chaque microservice suit l'architecture hexagonale :

- **Domain**: Logique métier pure
- **Application**: Services applicatifs et ports
- **Infrastructure**: Adapters, persistance, web
EOF

# Script de build et déploiement
cat > build-and-deploy.sh << 'EOF'
#!/bin/bash

echo "🚀 Construction et déploiement de la plateforme Identity"

# Construction
echo "📦 Construction des microservices..."
mvn clean package -DskipTests

# Création des images Docker
echo "🐳 Création des images Docker..."
for service in */; do
    if [ -f "$service/Dockerfile" ]; then
        echo "Construction de l'image pour $service"
        cd "$service"
        docker build -t "identity-platform/$(basename $service)" .
        cd ..
    fi
done

echo "✅ Plateforme prête pour le déploiement!"
EOF

chmod +x build-and-deploy.sh

echo ""
echo "🎉 Infrastructure générée avec succès!"
echo "📁 Répertoire: $PROJECT_ROOT"
echo ""
echo "📋 Prochaines étapes:"
echo "   1. cd $PROJECT_ROOT"
echo "   2. make start-infra    # Démarre l'infrastructure (DB, Redis, etc.)"
echo "   3. make build          # Compile tous les services"
echo "   4. make start          # Démarre tous les microservices"
echo ""
echo "🌐 URLs importantes:"
echo "   - Eureka: http://localhost:8761"
echo "   - API Gateway: http://localhost:8080"  
echo "   - Keycloak: http://localhost:8090"
echo "   - Grafana: http://localhost:3000"
echo ""
echo "✨ Architecture hexagonale implémentée pour tous les services!"