#!/bin/bash
# Deployment script for wep-tutor application

echo "🏗️  Building application..."
mvn clean package -q

if [ $? -eq 0 ]; then
    echo "✅ Build successful"
    
    echo "🐳 Deploying with Docker..."
    docker-compose down tomcat
    docker-compose up -d tomcat
    
    echo "⏳ Waiting for Tomcat to start..."
    sleep 10
    
    echo "🌐 Testing application..."
    response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/wep-tutor/goLogin)
    
    if [ "$response" = "200" ]; then
        echo "🎉 Deployment successful!"
        echo "📱 Application URL: http://localhost:8080/wep-tutor/goHome"
        echo "🗄️  Database URL: http://localhost:8082"
    else
        echo "❌ Deployment failed - HTTP $response"
        docker-compose logs tomcat --tail 10
    fi
else
    echo "❌ Build failed"
    exit 1
fi
