package com.springmvc.model;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class HibernateConnection {
	public static SessionFactory sessionFactory;

	static String url;
	static String uname;
	static String pwd;

	static {
		// Check if running in Docker environment
		String dockerProfile = System.getProperty("spring.profiles.active");
		String dbName = System.getenv("DB_NAME");
		uname = System.getenv("DB_USER");
		pwd = System.getenv("DB_PASSWORD");

		if ("docker".equals(dockerProfile)) {
			// Docker environment - connect to mysql container
			url = "jdbc:mysql://mysql:3306/" + dbName
					+ "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
		} else {
			// Local development environment
			url = "jdbc:mysql://localhost:3306/" + dbName
					+ "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
		}
	}

	public static SessionFactory doHibernateConnection() {
		if (sessionFactory != null) {
			return sessionFactory;
		}

		Properties database = new Properties();

		// Basic connection properties
		database.setProperty("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
		database.setProperty("hibernate.connection.username", uname);
		database.setProperty("hibernate.connection.password", pwd);
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

		Configuration cfg = new Configuration()
				.setProperties(database)
				.addPackage("com.springmvc.model")
				.addAnnotatedClass(User.class)
				.addAnnotatedClass(Admin.class)
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

		StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties());
		sessionFactory = cfg.buildSessionFactory(ssrb.build());
		return sessionFactory;
	}
}