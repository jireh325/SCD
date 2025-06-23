Identity Platform - Documentation Technique
Plateforme d'identité numérique microservices

📌 Table des matières
📋 Aperçu du projet

🏗 Architecture

⚙ Prérequis & Installation

🚀 Démarrage

🔗 Communication entre microservices

🔐 Sécurité

📊 Monitoring & Logs

🧪 Tests

📦 Déploiement

🛠 Développement

📚 Références

📋 Aperçu du projet
Identity Platform est une solution d'identité numérique sécurisée basée sur une architecture microservices avec :
✔ Gestion centralisée des identités (médicale, professionnelle, financière, etc.)
✔ Authentification forte (biométrie, SSO, OAuth2)
✔ Sécurité renforcée (TPM 2.0, chiffrement matériel)
✔ Monitoring complet (Prometheus, Grafana, ELK)

Technologies clés :

Backend : Spring Boot 3, Java 17, Spring Cloud

Base de données : PostgreSQL, Redis

Sécurité : Keycloak, Spring Security, Vault

Infra : Docker, Kubernetes (optionnel)

🏗 Architecture
Diagramme d'architecture
Diagram
Code















Liste des microservices
Service	Port	Description
api-gateway	8080	Route les requêtes
auth-service	8085	Gère l'authentification (Keycloak)
identity-registry	8081	Registre central des identités
medical-identity	8091	Données médicales
⚙ Prérequis & Installation
📋 Prérequis
Docker + Docker Compose

Java 17+

Maven 3.8+

Node.js (pour l'UI)

🛠 Installation
Cloner le dépôt

bash
git clone https://github.com/jireh325/SCD.git
cd identity-platform
Démarrer l'infrastructure

bash
make start-infra  # Lance Postgres, Redis, Keycloak...
Compiler les services

bash
mvn clean package
🚀 Démarrage
Lancer tous les services
bash
make start  # Démarre Eureka, Gateway, Services...
URLs d'accès
Service	URL
Eureka	http://localhost:8761
Keycloak	http://localhost:8090
Grafana	http://localhost:3000
API Gateway	http://localhost:8080
🔗 Communication entre microservices
1. Appels REST (Synchrone)
Via OpenFeign (exemple) :

java
@FeignClient(name = "medical-service", url = "http://medical-service:8091")
public interface MedicalClient {
    @GetMapping("/records/{userId}")
    MedicalRecord getRecords(@PathVariable String userId);
}
2. Événements (Asynchrone)
Via Kafka :

java
@KafkaListener(topics = "identity-events")
public void handleEvent(IdentityEvent event) {
    // Traiter l'événement
}
🔐 Sécurité
Authentification
Keycloak (OAuth2/OIDC)

JWT pour les communications internes

Endpoints sécurisés
yaml
# Dans application.yml
security:
  oauth2:
    resourceserver:
      jwt:
        issuer-uri: http://localhost:8090/realms/identity-platform
📊 Monitoring & Logs
Outil	URL
Prometheus	http://localhost:9090
Grafana	http://localhost:3000
Kibana	http://localhost:5601
Exporter des métriques
java
@RestController
public class MetricsController {
    @GetMapping("/metrics")
    public String metrics() {
        return "Expose les métriques Prometheus ici";
    }
}
🧪 Tests
Lancer les tests
bash
mvn test              # Tests unitaires
mvn verify -Pintegration  # Tests d'intégration
📦 Déploiement
Déploiement local
bash
docker-compose up --build
Déploiement Kubernetes (optionnel)
bash
kubectl apply -f k8s/
🛠 Développement
Workflow recommandé
Créer une branche

bash
git checkout -b feature/new-identity-type
Lancer les services en mode dev

bash
mvn spring-boot:run -pl auth-service
📚 Références
Spring Boot Docs

Keycloak Documentation

© 2025 - Identity Platform - Contacter l'équipe