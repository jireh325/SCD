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
