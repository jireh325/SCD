#!/bin/bash
# generate-scid-config-repo.sh

# Création de la structure de base
mkdir -p SCD-config/services
cd SCD-config

# 1. Fichier application.yml (configuration globale)
cat > application.yml << 'EOF'
# Configuration commune à tous les services
spring:
  jackson:
    time-zone: UTC
    date-format: 'yyyy-MM-dd HH:mm:ss'

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics
  endpoint:
    health:
      show-details: always

logging:
  pattern:
    console: '%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n'
  level:
    root: INFO
    org.springframework: WARN
EOF

# 2. Fonction pour générer les configurations des services
generate_service_config() {
  local service_name=$1
  local port=$2
  
  cat > "services/${service_name}.yml" << EOF

spring:
  
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
    data:
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
      enabled: true

logging:
  level:
    com.identity.platform: DEBUG
    org.springframework.security: DEBUG
EOF
}

# 3. Génération des configurations pour tous les services
generate_service_config "api-gateway-service" 8080
generate_service_config "auth-service" 8085
generate_service_config "backup-service" 8104
generate_service_config "basic-identity-service" 8083
generate_service_config "biometric-identity-service" 8096
generate_service_config "config-service" 8888
generate_service_config "discovery-service" 8761
generate_service_config "event-bus-service" 8103
generate_service_config "family-identity-service" 8093
generate_service_config "financial-identity-service" 8095
generate_service_config "identity-aggregator-service" 8101
generate_service_config "identity-context-service" 8082
generate_service_config "identity-orchestrator-service" 8102
generate_service_config "identity-registry-service" 8081
generate_service_config "legal-identity-service" 8094
generate_service_config "medical-identity-service" 8091
generate_service_config "monitoring-service" 8086
generate_service_config "professional-identity-service" 8092
generate_service_config "security-service" 8084

