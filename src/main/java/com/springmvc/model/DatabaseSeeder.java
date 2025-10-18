package com.springmvc.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import java.util.*;
import java.text.SimpleDateFormat;

public class DatabaseSeeder {

  private static SessionFactory sessionFactory;

  public static void seedDatabase() {
    try {
      System.out.println("🌱 Starting database seeding...");

      // Initialize Hibernate connection
      sessionFactory = HibernateConnection.doHibernateConnection();

      // Clear existing data (optional - uncomment if needed)
      // clearExistingData();

      // Seed data in order (respecting foreign key constraints)
      seedUsers();
      seedSkills();
      seedTutors();
      seedStudents();
      seedCategories();
      seedCourses();
      seedCourseDates();
      seedRegistrations();
      seedPayments();
      seedReviews();

      System.out.println("✅ Database seeding completed successfully!");

    } catch (Exception e) {
      System.err.println("❌ Database seeding failed: " + e.getMessage());
      e.printStackTrace();
      throw e;
    } finally {
      if (sessionFactory != null) {
        sessionFactory.close();
      }
    }
  }

  public static void main(String[] args) {
    seedDatabase();
  }

  private static void clearExistingData() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      // Delete in reverse order of dependencies
      session.createQuery("DELETE FROM ReviewCourse").executeUpdate();
      session.createQuery("DELETE FROM Payment").executeUpdate();
      session.createQuery("DELETE FROM RegisterCourse").executeUpdate();
      session.createQuery("DELETE FROM CourseDate").executeUpdate();
      session.createQuery("DELETE FROM Course").executeUpdate();
      session.createQuery("DELETE FROM Category").executeUpdate();
      session.createQuery("DELETE FROM Student").executeUpdate();
      session.createQuery("DELETE FROM Tutor").executeUpdate();
      session.createQuery("DELETE FROM Skill").executeUpdate();
      session.createQuery("DELETE FROM User").executeUpdate();

      tx.commit();
      System.out.println("🗑️  Existing data cleared");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedUsers() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      String[] firstNames = { "สมชาย", "สมหญิง", "วิทยา", "ประยุทธ", "ภัทรา", "อนุชา", "สุนิสา", "ธนากร", "พิมพ์ชนก",
          "รัฐพล" };
      String[] lastNames = { "ใจดี", "รักเรียน", "สอนดี", "เก่งมาก", "ช่วยเหลือ", "มีความรู้", "ใส่ใจ", "ทำดี", "สุภาพ",
          "ขยัน" };

      for (int i = 1; i <= 20; i++) {
        User user = new User();
        String firstName = firstNames[i % firstNames.length];
        String lastName = lastNames[(i + 3) % lastNames.length];

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(firstName.toLowerCase() + i + "@example.com");
        user.setPassword("password123"); // In real app, this should be hashed
        user.setPhoneNumber("08" + String.format("%08d", (1000000 + i)));

        session.save(user);

        if (i % 5 == 0) {
          session.flush();
          session.clear();
        }
      }

      tx.commit();
      System.out.println("👥 Created 20 users");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedSkills() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      String[] skillNames = {
          "Java Programming", "Python Programming", "Web Development", "Database Design",
          "Machine Learning", "Data Science", "Mobile Development", "UI/UX Design",
          "Project Management", "Digital Marketing", "Graphic Design", "English Language",
          "Mathematics", "Physics", "Chemistry", "Biology"
      };

      for (String skillName : skillNames) {
        Skill skill = new Skill();
        skill.setSkillName(skillName);
        // Note: Skill entity doesn't have setSkillDescription method - removing this
        // line
        session.save(skill);
      }

      tx.commit();
      System.out.println("🎯 Created " + skillNames.length + " skills");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedTutors() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      // Get first 10 users to make them tutors
      List<User> users = session.createQuery("FROM User", User.class)
          .setMaxResults(10)
          .list();

      List<Skill> skills = session.createQuery("FROM Skill", Skill.class).list();

      String[] expertiseAreas = { "Programming", "Mathematics", "Science", "Language", "Art" };

      for (int i = 0; i < users.size(); i++) {
        User user = users.get(i);

        Tutor tutor = new Tutor();
        tutor.setUser(user);
        tutor.setExpertise(expertiseAreas[i % expertiseAreas.length]);
        tutor.setRating(4.0 + (i % 6) * 0.1); // Rating between 4.0-4.5
        tutor.setBanStatus(0); // Not banned
        // Note: Removed setExperience, setEducation, setBio as they don't exist in
        // Tutor entity

        // Assign 2-3 random skills to each tutor
        List<Skill> tutorSkills = new ArrayList<>();
        Random random = new Random();
        for (int j = 0; j < 2 + random.nextInt(2); j++) {
          Skill skill = skills.get(random.nextInt(skills.size()));
          if (!tutorSkills.contains(skill)) {
            skill.setTutor(tutor); // Set the tutor for this skill
            tutorSkills.add(skill);
          }
        }
        tutor.setSkills(tutorSkills);

        session.save(tutor);
      }

      tx.commit();
      System.out.println("👨‍🏫 Created 10 tutors");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedStudents() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      // Get remaining users (11-20) to make them students
      List<User> users = session.createQuery("FROM User", User.class)
          .setFirstResult(10)
          .setMaxResults(10)
          .list();

      String[] studentIds = { "60010001", "60010002", "60010003", "60010004", "60010005",
          "60010006", "60010007", "60010008", "60010009", "60010010" };
      String[] yearOfStudyOptions = { "1", "2", "3", "4" };

      for (int i = 0; i < users.size(); i++) {
        User user = users.get(i);

        Student student = new Student();
        student.setUser(user);
        student.setStudentId(studentIds[i]);
        student.setYearOfStudy(yearOfStudyOptions[i % yearOfStudyOptions.length]);
        // Note: Removed setSchool, setMajor, setYear as they don't exist in Student
        // entity

        session.save(student);
      }

      tx.commit();
      System.out.println("👨‍🎓 Created 10 students");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedCategories() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      String[] categoryNames = {
          "Programming", "Web Development", "Mobile Development", "Data Science",
          "AI & Machine Learning", "Database", "DevOps", "UI/UX Design",
          "Digital Marketing", "Language Learning", "Mathematics", "Science"
      };

      for (String categoryName : categoryNames) {
        Category category = new Category();
        category.setCategoryName(categoryName);
        session.save(category);
      }

      tx.commit();
      System.out.println("📚 Created " + categoryNames.length + " categories");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedCourses() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      List<Tutor> tutors = session.createQuery("FROM Tutor", Tutor.class).list();
      List<Category> categories = session.createQuery("FROM Category", Category.class).list();

      String[] courseNames = {
          "Java Programming สำหรับผู้เริ่มต้น",
          "Python Data Science Workshop",
          "React.js Web Development",
          "Mobile App ด้วย React Native",
          "Machine Learning พื้นฐาน",
          "Database Design และ SQL",
          "UI/UX Design Fundamentals",
          "Digital Marketing Strategy",
          "English Conversation",
          "คณิตศาสตร์ ม.ปลาย",
          "ฟิสิกส์เตรียมสอบ",
          "เคมีเชิงอินทรีย์",
          "Web Development ขั้นสูง",
          "Android Development",
          "iOS Development",
          "DevOps และ Docker",
          "Graphic Design ด้วย Photoshop",
          "Video Editing พื้นฐาน",
          "SEO และ Content Marketing",
          "Excel ขั้นสูง"
      };

      String[] descriptions = {
          "เรียนรู้การเขียนโปรแกรม Java ตั้งแต่พื้นฐานจนถึงขั้นสูง",
          "Workshop การใช้ Python สำหรับการวิเคราะห์ข้อมูล",
          "สร้างเว็บไซต์ที่ทันสมัยด้วย React.js",
          "พัฒนาแอปพลิเคชันมือถือครอสแพลตฟอร์ม",
          "เรียนรู้พื้นฐาน Machine Learning และ AI"
      };

      Random random = new Random();

      for (int i = 0; i < Math.min(courseNames.length, 15); i++) {
        Course course = new Course();
        course.setCourseName(courseNames[i]);
        course.setCourseDescription(i < descriptions.length ? descriptions[i]
            : "คอร์สเรียนที่ออกแบบมาเพื่อให้ผู้เรียนได้รับความรู้และทักษะที่จำเป็น");

        course.setTutor(tutors.get(i % tutors.size()));
        course.setCategory(categories.get(i % categories.size()));

        course.setCoursePrice(1500.0 + (random.nextInt(30) * 100)); // 1500-4400 baht
        course.setMaxStudents(10 + random.nextInt(20)); // 10-30 students

        session.save(course);
      }

      tx.commit();
      System.out.println("📖 Created 15 courses");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedCourseDates() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      List<Course> courses = session.createQuery("FROM Course", Course.class).list();

      String[] topics = { "บทนำ", "พื้นฐาน", "การปฏิบัติ", "โปรเจ็ค", "สรุป" };
      String[] times = { "09:00", "10:00", "13:00", "14:00", "15:00", "16:00" };

      for (Course course : courses) {
        // Create 3-5 course dates for each course
        Random random = new Random();
        int numDates = 3 + random.nextInt(3);

        for (int i = 0; i < numDates; i++) {
          CourseDate courseDate = new CourseDate();
          courseDate.setCourse(course);
          courseDate.setTopic(topics[i % topics.length] + " " + (i + 1));

          // Set dates in the future
          Calendar cal = Calendar.getInstance();
          cal.add(Calendar.DAY_OF_MONTH, 7 + (i * 7)); // Weekly sessions
          courseDate.setClass_date(new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()));

          String startTime = times[random.nextInt(times.length)];
          courseDate.setStartTime(startTime);

          // End time is 2 hours after start time
          int startHour = Integer.parseInt(startTime.split(":")[0]);
          courseDate.setEndTime(String.format("%02d:00", startHour + 2));

          session.save(courseDate);
        }
      }

      tx.commit();
      System.out.println("📅 Created course dates for all courses");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedRegistrations() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      List<Student> students = session.createQuery("FROM Student", Student.class).list();
      List<Course> courses = session.createQuery("FROM Course", Course.class).list();

      Random random = new Random();

      // Create random registrations
      for (Student student : students) {
        // Each student registers for 1-3 courses
        int numCourses = 1 + random.nextInt(3);
        List<Course> selectedCourses = new ArrayList<>();

        for (int i = 0; i < numCourses; i++) {
          Course course = courses.get(random.nextInt(courses.size()));
          if (!selectedCourses.contains(course)) {
            selectedCourses.add(course);

            RegisterCourse registration = new RegisterCourse();
            registration.setStudent(student);
            registration.setCourse(course);
            registration.setRegisStatus(1); // Active

            session.save(registration);
          }
        }
      }

      tx.commit();
      System.out.println("📝 Created course registrations");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedPayments() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      List<RegisterCourse> registrations = session.createQuery("FROM RegisterCourse", RegisterCourse.class).list();

      for (RegisterCourse registration : registrations) {
        Payment payment = new Payment();
        payment.setAmount(registration.getCourse().getCoursePrice());
        payment.setPaymentDate(new Date());

        session.save(payment);

        // Update registration with payment
        registration.setPayment(payment);
        session.update(registration);
      }

      tx.commit();
      System.out.println("💳 Created payments for all registrations");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }

  private static void seedReviews() {
    Session session = sessionFactory.openSession();
    Transaction tx = session.beginTransaction();

    try {
      List<RegisterCourse> registrations = session.createQuery("FROM RegisterCourse", RegisterCourse.class).list();

      String[] reviewTexts = {
          "คอร์สนี้ดีมาก อาจารย์สอนเข้าใจง่าย",
          "เรียนรู้ได้เยอะ แนะนำเลย",
          "เนื้อหาครบถ้วน อาจารย์ใจดี",
          "คุณภาพการสอนดีเยี่ยม",
          "ประโยชน์มาก ได้ความรู้ใหม่ๆ"
      };

      Random random = new Random();

      // Create reviews for 70% of registrations
      for (int i = 0; i < registrations.size() * 0.7; i++) {
        RegisterCourse registration = registrations.get(i);

        ReviewCourse review = new ReviewCourse();
        review.setCourse(registration.getCourse());
        review.setUser(registration.getStudent().getUser()); // Set the user who made the review
        review.setScore(3.0 + random.nextDouble() * 2.0); // Score 3.0-5.0
        review.setComment(reviewTexts[random.nextInt(reviewTexts.length)]);
        review.setReviewDate(new Date());

        session.save(review);
      }

      tx.commit();
      System.out.println("⭐ Created course reviews");
    } catch (Exception e) {
      tx.rollback();
      throw e;
    } finally {
      session.close();
    }
  }
}
