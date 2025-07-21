package com.springmvc.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class TutorManager {

	public boolean insertRegister(User m, Student s) {
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        
	        session.save(m);
	        session.save(s);

	        session.getTransaction().commit();
	        session.close();
	        return true;
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return false;
	}

	
	public User getRegisterByEmail(String email){
		User reg = new User();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			reg = (User) session.createQuery("From User where email = '"+ email +"'").uniqueResult();
			session.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return reg;
	}
	
	public User getUserByEmail(String email) {
	    User user = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        
	        String hql = "FROM User u WHERE u.member.email = :email";
	        user = (User) session.createQuery(hql)
	                             .setParameter("email", email)
	                             .uniqueResult();

	        session.getTransaction().commit();
	        session.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}

	
	public boolean insertUser(User user) {
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        session.save(user);

	        session.getTransaction().commit();
	        session.close();
	        return true;
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return false;
	}
	
	public Student getStudentByEmail(String email) {
	    Student student = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        String hql = "FROM Student s WHERE s.member.email = :email";
	        student = (Student) session.createQuery(hql)
	                                   .setParameter("email", email)
	                                   .uniqueResult();

	        session.getTransaction().commit();
	        session.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return student;
	}
	public boolean updateRegister(User r) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(r);
			session.getTransaction().commit();
			session.close();
			return true;
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		return false;
	}
	
	
	public boolean updateStudent(Student r) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(r);
			session.getTransaction().commit();
			session.close();
			return true;
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		return false;
	}
	
	public boolean insertRegisterTutor(User user, Tutor tutor, List<Skill> skillList) {
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        

	        String hql = "SELECT count(t) FROM Tutor t WHERE t.user.email = :email";
	        Long count = (Long) session.createQuery(hql)
	                            .setParameter("email", user.getEmail())
	                            .uniqueResult();

	        if (count != null && count > 0) {
	            // มีข้อมูลซ้ำ ไม่ต้องบันทึก
	            return false;
	        }

	        // เริ่ม transaction หลังจากเช็คเสร็จ
	        session.beginTransaction();
	        
	        tutor.setUser(user);
	        session.saveOrUpdate(user);

	        
	        tutor.setSkills(skillList);
	        if (skillList != null) {
	            for (Skill skill : skillList) {
	                skill.setTutor(tutor);
	            }
	        }
	        session.saveOrUpdate(tutor);

	        session.getTransaction().commit();
	        session.close();
	        return true;
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return false;
	}
	
	public List<Role> getUserRolesByEmail(String email) {
	    Session session = HibernateConnection.doHibernateConnection().openSession();
	    List<Role> roles = session.createQuery(
	            "FROM Role WHERE user.email = :email", Role.class)
	            .setParameter("email", email)
	            .list();
	    session.close();
	    return roles;
	}

	
	public Tutor getTutorByEmail(String email) {
		Tutor tutor = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        String hql = "FROM Tutor t WHERE t.member.email = :email";
	        tutor = (Tutor) session.createQuery(hql)
	                                   .setParameter("email", email)
	                                   .uniqueResult();

	        session.getTransaction().commit();
	        session.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return tutor;
	}
	
	public boolean insertCourse(Course course, Category category, List<CourseDate> cdl) {
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        
	        session.save(category); 

	      
	        course.setCategory(category);

	        session.save(course);

	        for (CourseDate cd : cdl) {
	            cd.setCourse(course); // 
	            session.save(cd);
	        }
	        

	        session.getTransaction().commit();
	        session.close();
	        return true;
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return false;
	}
	
	public List<Course> getCoursesByTutorEmail(String email) {
	    List<Course> courses = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        String hql = "SELECT DISTINCT c FROM Course c " +
	                     "LEFT JOIN FETCH c.category " +
	                     "LEFT JOIN FETCH c.courseDates " +
	                     "WHERE c.tutor.member.email = :email";

	        Query<Course> query = session.createQuery(hql, Course.class);
	        query.setParameter("email", email);

	        courses = query.getResultList();

	        session.getTransaction().commit();
	        session.close();
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return courses;
	}
	
	public List<Course> getAllCourses() {
	    List<Course> courses = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        String hql = "SELECT DISTINCT c FROM Course c " +
	                     "LEFT JOIN FETCH c.category " +
	                     "LEFT JOIN FETCH c.courseDates " +
	                     "LEFT JOIN FETCH c.tutor";

	        courses = session.createQuery(hql, Course.class).getResultList();

	        session.getTransaction().commit();
	        session.close();
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return courses;
	}
	
	public Course getCourseById(int courseId) {
	    Course course = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();
	        String hql = "SELECT c FROM Course c " +
	                     "LEFT JOIN FETCH c.tutor t " +
	                     "LEFT JOIN FETCH t.member " +
	                     "LEFT JOIN FETCH c.category " +
	                     "LEFT JOIN FETCH c.courseDates " +
	                     "WHERE c.courseId = :courseId";

	        course = session.createQuery(hql, Course.class)
	                        .setParameter("courseId", courseId)
	                        .uniqueResult();

	        session.getTransaction().commit();
	        session.close();
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return course;
	}






	
	




}