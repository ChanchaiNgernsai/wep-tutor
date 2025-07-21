package com.springmvc.model;
 
import java.util.Properties;
 
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

 
public class HibernateConnection {
	public static SessionFactory sessionFactory;
	static String url = "jdbc:mysql://localhost:3306/project_tutor2?characterEncoding=UTF-8";
	static String uname = "root";
	static String pwd = "1234";
	
	public static SessionFactory doHibernateConnection(){
		Properties database = new Properties();
		database.setProperty("hibernate.hbm2ddl.auto","update");
		database.setProperty("hibernate.connection.driver_class","com.mysql.jdbc.Driver");
		database.setProperty("hibernate.connection.username",uname);
		database.setProperty("hibernate.connection.password",pwd);
		database.setProperty("hibernate.connection.url",url);
		database.setProperty("hibernate.dialect","org.hibernate.dialect.MySQL5InnoDBDialect");
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
							.addAnnotatedClass(Payment.class)
							;
		StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties());
		sessionFactory = cfg.buildSessionFactory(ssrb.build());
		return sessionFactory;
	}
}