package com.springmvc.model;

public class DatabaseTest {
    public static void main(String[] args) {
        try {
            System.out.println("Testing database connection...");
            
            // Test the Hibernate connection
            HibernateConnection.doHibernateConnection();
            
            System.out.println("✅ Database connection successful!");
            System.out.println("SessionFactory created successfully.");
            
        } catch (Exception e) {
            System.err.println("❌ Database connection failed!");
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
