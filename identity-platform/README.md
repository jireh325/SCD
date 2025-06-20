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

```bash
# Construction
make build

# Démarrage de l'infrastructure
make start-infra

# Démarrage complet
make start

# Arrêt
make stop
```

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
