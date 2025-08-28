package com.springmvc.model;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class HibernateConnectionEnv {
	public static SessionFactory sessionFactory;
	
	// Dynamic database configuration
	private static String getDbUrl() {
		// Check if running in Docker by looking for environment variables
		String dbHost = System.getenv("DB_HOST");
		if (dbHost != null) {
			// Running in Docker
			return "jdbc:mysql://" + dbHost + ":3306/project_tutor2?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
		} else {
			// Running locally
			return "jdbc:mysql://localhost:3306/project_tutor2?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
		}
	}
	
	private static String getDbUser() {
		String dbUser = System.getenv("DB_USER");
		return dbUser != null ? dbUser : "tutor_user";
	}
	
	private static String getDbPassword() {
		String dbPassword = System.getenv("DB_PASSWORD");
		return dbPassword != null ? dbPassword : "1234";
	}

	public static SessionFactory doHibernateConnection() {
		Properties database = new Properties();
		
		// Get configuration from environment or use defaults
		String url = getDbUrl();
		String username = getDbUser();
		String password = getDbPassword();
		
		System.out.println("Connecting to database: " + url);
		System.out.println("Using username: " + username);
		
		// Basic connection properties
		database.setProperty("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
		database.setProperty("hibernate.connection.username", username);
		database.setProperty("hibernate.connection.password", password);
		database.setProperty("hibernate.connection.url", url);
		
		// Database dialect (updated for newer MySQL versions)
		database.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
		
		// Schema management
		database.setProperty("hibernate.hbm2ddl.auto", "update");
		
		// Connection pool settings
		database.setProperty("hibernate.connection.pool_size", "10");
		database.setProperty("hibernate.connection.autocommit", "false");
		
		// Performance settings
		database.setProperty("hibernate.cache.use_second_level_cache", "false");
		database.setProperty("hibernate.cache.use_query_cache", "false");
		database.setProperty("hibernate.show_sql", "true");
		database.setProperty("hibernate.format_sql", "true");
		
		// Connection validation
		database.setProperty("hibernate.connection.provider_disables_autocommit", "true");
		database.setProperty("hibernate.connection.autoReconnect", "true");
		database.setProperty("hibernate.connection.testOnBorrow", "true");
		database.setProperty("hibernate.connection.validationQuery", "SELECT 1");
		
		Configuration cfg = new Configuration()
				.setProperties(database)
				.addPackage("com.springmvc.model")
				.addAnnotatedClass(User.class)
				.addAnnotatedClass(Student.class)
				.addAnnotatedClass(Tutor.class)
				.addAnnotatedClass(Role.class)
				.addAnnotatedClass(Skill.class)
				.addAnnotatedClass(Transaction.class)
				.addAnnotatedClass(Report.class)
				.addAnnotatedClass(ReviewCourse.class)
				.addAnnotatedClass(Course.class)
				.addAnnotatedClass(CourseDate.class)
				.addAnnotatedClass(Category.class)
				.addAnnotatedClass(RegisterCourse.class)
				.addAnnotatedClass(Payment.class);
				
		try {
			StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties());
			sessionFactory = cfg.buildSessionFactory(ssrb.build());
			System.out.println("Hibernate SessionFactory created successfully!");
			return sessionFactory;
		} catch (Exception e) {
			System.err.println("Failed to create SessionFactory: " + e.getMessage());
			e.printStackTrace();
			throw e;
		}
	}
}
