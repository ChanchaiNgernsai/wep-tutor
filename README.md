c:\apache-tomcat-10.1.43\bin> .\catalina.bat jpda start
c:\apache-tomcat-10.1.43\bin> .\catalina.bat start

.vscode/launch.json

```
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Debug (Attach)",
      "request": "attach",
      "hostName": "localhost",
      "port": 8000
    }
  ]
}
```

compile:
mvn compile
mvn clean package

http://localhost:8080/SpringMVCProject-0.0.1-SNAPSHOT
