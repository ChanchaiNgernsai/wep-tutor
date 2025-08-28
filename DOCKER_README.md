# Docker Setup for Wep-Tutor Project

This project includes Docker Compose configuration to run the application with MySQL and Tomcat.

## Services Included

1. **MySQL 8.0** - Database server
2. **Tomcat 10.1 with JDK 17** - Application server
3. **phpMyAdmin** - Database management interface (optional)

## Prerequisites

- Docker and Docker Compose installed
- Project built with Maven (`mvn clean package`)

## Quick Start

1. **Build the project first:**
   ```bash
   mvn clean package
   ```

2. **Start all services:**
   ```bash
   docker-compose up -d
   ```

3. **Access the application:**
   - Application: http://localhost:8080/wep-tutor
   - phpMyAdmin: http://localhost:8081

## Database Configuration

- **Host:** mysql (internal) or localhost:3306 (external)
- **Database:** wep_tutor_db
- **Username:** wep_user
- **Password:** wep_password
- **Root Password:** rootpassword

## Useful Commands

### Start services
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f tomcat
docker-compose logs -f mysql
```

### Rebuild and restart
```bash
# After code changes, rebuild the WAR file
mvn clean package

# Restart only Tomcat
docker-compose restart tomcat
```

### Clean up (remove containers and volumes)
```bash
docker-compose down -v
```

## Database Initialization

The MySQL container will automatically run the initialization script located at:
`docker/mysql/init/01-init.sql`

This script creates sample tables and data. Modify it according to your schema requirements.

## Environment Variables

You can customize the configuration by creating a `.env` file:

```env
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=your_database_name
MYSQL_USER=your_username
MYSQL_PASSWORD=your_password
TOMCAT_PORT=8080
MYSQL_PORT=3306
PHPMYADMIN_PORT=8081
```

## Troubleshooting

### Application not starting
1. Check if WAR file exists: `target/SpringMVCProject-0.0.1-SNAPSHOT.war`
2. Check Tomcat logs: `docker-compose logs tomcat`

### Database connection issues
1. Wait for MySQL to be fully ready (check health status)
2. Verify database credentials in your application configuration

### Port conflicts
If ports 3306, 8080, or 8081 are already in use, modify the ports in `docker-compose.yaml`:
```yaml
ports:
  - "3307:3306"  # Change external port
```

## Development Workflow

1. Make code changes
2. Build: `mvn clean package`
3. Restart Tomcat: `docker-compose restart tomcat`
4. Test: http://localhost:8080/wep-tutor

## Production Notes

For production deployment:
- Change default passwords
- Use external volumes for data persistence
- Configure proper networking and security
- Use environment-specific configuration files
