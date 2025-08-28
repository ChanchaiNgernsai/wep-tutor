-- Database initialization script for wep-tutor project
-- This script will run automatically when MySQL container starts

USE wep_tutor_db;

-- Create sample tables (adjust according to your actual schema)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('STUDENT', 'TUTOR', 'ADMIN') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    tutor_id INT,
    price DECIMAL(10,2),
    duration_hours INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tutor_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'COMPLETED', 'CANCELLED') DEFAULT 'ACTIVE',
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id)
);

-- Insert sample data
INSERT INTO users (username, password, email, role) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMye5YjjS6Lv6HKuv7K1M3iZqW8.zOa.1Yu', 'admin@example.com', 'ADMIN'),
('tutor1', '$2a$10$N9qo8uLOickgx2ZMRZoMye5YjjS6Lv6HKuv7K1M3iZqW8.zOa.1Yu', 'tutor1@example.com', 'TUTOR'),
('student1', '$2a$10$N9qo8uLOickgx2ZMRZoMye5YjjS6Lv6HKuv7K1M3iZqW8.zOa.1Yu', 'student1@example.com', 'STUDENT');

INSERT INTO courses (title, description, tutor_id, price, duration_hours) VALUES
('Java Programming Basics', 'Learn the fundamentals of Java programming', 2, 299.99, 40),
('Spring Framework Introduction', 'Introduction to Spring Framework and Spring Boot', 2, 399.99, 60);

-- Grant privileges
GRANT ALL PRIVILEGES ON wep_tutor_db.* TO 'wep_user'@'%';
FLUSH PRIVILEGES;
