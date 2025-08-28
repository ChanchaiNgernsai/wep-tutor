package com.springmvc.model;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class HibernateConnection {
	public static SessionFactory sessionFactory;
	
	// Database configuration - Docker environment
	static String url = "jdbc:mysql://mysql:3306/project_tutor2?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
	static String uname = "tutor_user";
	static String pwd = "1234";

	public static SessionFactory doHibernateConnection() {
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