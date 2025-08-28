@echo off
REM Deployment script for wep-tutor application (Windows)

echo 🏗️  Building application...
call mvn clean package -q

if %ERRORLEVEL% == 0 (
    echo ✅ Build successful
    
    echo 🐳 Deploying with Docker...
    docker-compose down tomcat
    docker-compose up -d tomcat
    
    echo ⏳ Waiting for Tomcat to start...
    timeout /t 10 /nobreak > nul
    
    echo 🌐 Testing application...
    curl -s -o nul -w "%%{http_code}" http://localhost:8080/wep-tutor/goLogin > temp_response.txt
    set /p response=<temp_response.txt
    del temp_response.txt
    
    if "!response!" == "200" (
        echo 🎉 Deployment successful!
        echo 📱 Application URL: http://localhost:8080/wep-tutor/goHome
        echo 🗄️  Database URL: http://localhost:8082
    ) else (
        echo ❌ Deployment failed - HTTP !response!
        docker-compose logs tomcat --tail 10
    )
) else (
    echo ❌ Build failed
    exit /b 1
)
