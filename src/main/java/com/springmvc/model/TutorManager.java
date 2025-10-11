package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class TutorManager {

	// public boolean insertRegister(User m, Student s) {
	// try {
	// SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	// Session session = sessionFactory.openSession();
	// session.beginTransaction();

	// session.save(m);
	// session.save(s);

	// session.getTransaction().commit();
	// session.close();
	// return true;
	// } catch (Exception ex) {
	// ex.printStackTrace();
	// }
	// return false;
	// }
	// สำหรับ User + Role ปกติ (Student/Tutor/Admin ทีเดียว)
	public boolean insertRegisterStu(User user, Role role) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			session.save(user);
			session.save(role);

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public User getRegisterByEmail(String email) {
		User reg = new User();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			reg = (User) session.createQuery("From User where email = '" + email + "'").uniqueResult();
			session.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return reg;
	}

	public Student getStudentByEmail(String email) {
		Student student = null;
		try {
			Session session = HibernateConnection.doHibernateConnection().openSession();
			session.beginTransaction();

			String hql = "FROM Student s WHERE s.user.email = :email";
			Query<Student> query = session.createQuery(hql, Student.class);
			query.setParameter("email", email);
			student = query.uniqueResult();

			session.getTransaction().commit();
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return student;
	}

	public User getUserByEmail(String email) {
		User user = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "FROM User u WHERE u.user.email = :email";
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

	public boolean updateRegister(User r) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(r);
			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public boolean updateStudent(Student r) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			session.merge(r); // <-- ใช้ merge แทน saveOrUpdate

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
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
				return false;
			}

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

			String hql = "FROM Tutor t WHERE t.user.email = :email";
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
		Session session = null;
		try {
			session = HibernateConnection.doHibernateConnection().openSession();
			session.beginTransaction();

			if (category.getCategoryID() == 0) {
				session.save(category);
			}
			course.setCategory(category);

			Tutor tutor = course.getTutor();
			if (tutor != null && tutor.getRoleId() == 0) {
				session.save(tutor);
			}

			course.setTutor(tutor);

			session.save(course);

			for (CourseDate cd : cdl) {
				cd.setCourse(course);
				session.save(cd);
			}

			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			if (session != null)
				session.getTransaction().rollback();
			return false;
		} finally {
			if (session != null)
				session.close();
		}
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
					"WHERE c.tutor.user.email = :email";

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
					"LEFT JOIN FETCH t.user u " +
					"LEFT JOIN FETCH c.category cat " +
					"LEFT JOIN FETCH c.courseDates cd " +
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

	public List<Course> searchCoursesByKeyword(String keyword) {
		List<Course> courses = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "SELECT DISTINCT c FROM Course c " +
					"LEFT JOIN FETCH c.category " +
					"LEFT JOIN FETCH c.courseDates " +
					"LEFT JOIN FETCH c.tutor t " +
					"LEFT JOIN FETCH t.user " +
					"WHERE lower(c.courseName) LIKE :kw OR lower(c.courseDescription) LIKE :kw";

			Query<Course> query = session.createQuery(hql, Course.class);
			query.setParameter("kw", "%" + keyword.toLowerCase() + "%");

			courses = query.getResultList();

			session.getTransaction().commit();
			session.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return courses;
	}

	public boolean insertPayment(Payment payment) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			session.save(payment);

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public boolean insertRegisterCourse(RegisterCourse registerCourse) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			session.save(registerCourse);

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public List<RegisterCourse> getRegisterCoursesByUserEmail(String email) {
		List<RegisterCourse> list = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "FROM RegisterCourse rc "
					+ "LEFT JOIN FETCH rc.course c "
					+ "LEFT JOIN FETCH rc.payment p "
					+ "WHERE rc.user.email = :email";

			list = session.createQuery(hql, RegisterCourse.class)
					.setParameter("email", email)
					.getResultList();

			session.getTransaction().commit();
			session.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return list;
	}

	public Payment getPaymentById(int paymentId) {
		Payment payment = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			payment = session.get(Payment.class, paymentId);

			session.getTransaction().commit();
			session.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return payment;
	}

	public List<RegisterCourse> getRegisterCoursesByStudent(Student student) {
		SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
		Session session = null;
		List<RegisterCourse> registerCourses = null;

		try {
			session = sessionFactory.openSession();
			session.beginTransaction();

			registerCourses = session.createQuery(
					"SELECT DISTINCT rc FROM RegisterCourse rc " +
							"JOIN FETCH rc.course c " +
							"LEFT JOIN FETCH c.courseDates " +
							"WHERE rc.student = :stu",
					RegisterCourse.class)
					.setParameter("stu", student)
					.getResultList();

			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (session != null)
				session.getTransaction().rollback();
		} finally {
			if (session != null)
				session.close();
		}

		return registerCourses;
	}

	// public List<RegisterCourse> getRegisterCoursesByStudent(Student student) {
	// SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	// Session session = null;
	// List<RegisterCourse> registerCourses = null;

	// try {
	// session = sessionFactory.openSession();
	// session.beginTransaction();

	// registerCourses = session.createQuery(
	// "FROM RegisterCourse rc WHERE rc.student = :stu", RegisterCourse.class)
	// .setParameter("stu", student)
	// .getResultList();

	// session.getTransaction().commit();
	// } catch (Exception e) {
	// e.printStackTrace();
	// if (session != null)
	// session.getTransaction().rollback();
	// } finally {
	// if (session != null)
	// session.close();
	// }

	// return registerCourses;
	// }

	public RegisterCourse getRegisterCourseById(int registerId) {
		RegisterCourse rc = null;
		try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
			session.beginTransaction();

			String hql = "SELECT rc FROM RegisterCourse rc "
					+ "JOIN FETCH rc.course c "
					+ "JOIN FETCH c.category "
					+ "JOIN FETCH c.tutor t "
					+ "JOIN FETCH t.user "
					+ "LEFT JOIN FETCH c.courseDates " // <-- เพิ่มตรงนี้
					+ "WHERE rc.registerCourseId = :rid";

			rc = session.createQuery(hql, RegisterCourse.class)
					.setParameter("rid", registerId)
					.uniqueResult();

			session.getTransaction().commit();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return rc;
	}

	public boolean deleteRegisterCourse(int registerId) {
		try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
			session.beginTransaction();
			RegisterCourse rc = session.get(RegisterCourse.class, registerId);
			if (rc != null) {
				session.delete(rc);
			}
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<Student> getStudentsByCourseId(int courseId) {
		List<Student> students = new ArrayList<>();
		try {
			Session session = HibernateConnection.doHibernateConnection().openSession();

			String hql = "SELECT rc.student FROM RegisterCourse rc WHERE rc.course.courseId = :courseId";
			Query<Student> query = session.createQuery(hql, Student.class);
			query.setParameter("courseId", courseId);

			students = query.getResultList();

			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return students;
	}

	public boolean addReviewCourse(ReviewCourse review) {
		try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
			session.beginTransaction();
			session.save(review);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<ReviewCourse> getAllReviews() {
		SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
		Session session = sessionFactory.openSession();
		List<ReviewCourse> reviews = null;

		try {
			session.beginTransaction();

			String hql = "SELECT r FROM ReviewCourse r "
					+ "LEFT JOIN FETCH r.user u "
					+ "LEFT JOIN FETCH r.course c "
					+ "LEFT JOIN FETCH c.tutor t";

			reviews = session.createQuery(hql, ReviewCourse.class).list();

			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
		} finally {
			session.close();
		}

		return reviews;
	}

	public List<ReviewCourse> getReviewsByCourse(int courseId) {
		List<ReviewCourse> reviews = new ArrayList<>();
		Session session = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "SELECT r FROM ReviewCourse r " +
					"LEFT JOIN FETCH r.user u " +
					"LEFT JOIN FETCH r.course c " +
					"LEFT JOIN FETCH c.tutor t " +
					"WHERE c.courseId = :courseId";

			Query<ReviewCourse> query = session.createQuery(hql, ReviewCourse.class);
			query.setParameter("courseId", courseId);

			reviews = query.getResultList();

			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (session != null && session.getTransaction().isActive()) {
				session.getTransaction().rollback();
			}
		} finally {
			if (session != null)
				session.close();
		}
		return reviews;
	}

	public List<Course> getLatestCourses(int limit) {
		Session session = HibernateConnection.doHibernateConnection().openSession();
		try {
			String hql = "FROM Course c ORDER BY c.courseId DESC";
			return session.createQuery(hql, Course.class)
					.setMaxResults(limit)
					.getResultList();
		} finally {
			session.close();
		}
	}

	public List<Report> getReportsByCourse(int courseId) {
		List<Report> reports = new ArrayList<>();
		Session session = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "SELECT r FROM Report r " +
					"LEFT JOIN FETCH r.course c " +
					"LEFT JOIN FETCH c.tutor t " +
					"LEFT JOIN FETCH t.user " +
					"LEFT JOIN FETCH c.courseDates " +
					"WHERE c.courseId = :courseId";

			Query<Report> query = session.createQuery(hql, Report.class);
			query.setParameter("courseId", courseId);

			reports = query.getResultList();

			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (session != null && session.getTransaction().isActive()) {
				session.getTransaction().rollback();
			}
		} finally {
			if (session != null)
				session.close();
		}
		return reports;
	}

	public long countAllUsers() {
		SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
		Session session = sessionFactory.openSession();
		long count = 0;
		try {
			String hql = "SELECT COUNT(u) FROM User u";
			count = (Long) session.createQuery(hql).uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}

	public boolean insertReport(Report report, Student student, Course course) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			session.save(report);

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public List<Report> getAllReports() {
		SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
		Session session = sessionFactory.openSession();
		List<Report> reports = null;

		try {
			session.beginTransaction();

			String hql = "SELECT r FROM Report r "
					+ "LEFT JOIN FETCH r.reporter "
					+ "LEFT JOIN FETCH r.reported "
					+ "LEFT JOIN FETCH r.course ";

			reports = session.createQuery(hql, Report.class).list();

			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
		} finally {
			session.close();
		}

		return reports;
	}

	public Tutor getTutorById(int tutorId) {
		try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
			return session.get(Tutor.class, tutorId);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean updateBanTutor(Tutor tutor) {
		try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
			session.beginTransaction();
			session.update(tutor);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean insertDeposit(Transaction transaction) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			session.saveOrUpdate(transaction);

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public double getBalance(String email) {
		double balance = 0.0;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "SELECT COALESCE(SUM(t.deposit),0) - COALESCE(SUM(t.withdraw),0) "
					+ "FROM Transaction t WHERE t.user.email = :email";

			Double result = (Double) session.createQuery(hql)
					.setParameter("email", email)
					.uniqueResult();

			if (result != null) {
				balance = result;
			}

			session.getTransaction().commit();
			session.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return balance;
	}

	public boolean updateWithdraw(Transaction transaction) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			double currentBalance = getBalance(transaction.getUser().getEmail());
			if (transaction.getWithdraw() > currentBalance) {
				session.getTransaction().rollback();
				session.close();
				return false;
			}

			session.saveOrUpdate(transaction);

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}

	public List<RegisterCourse> getRegisterCoursesByCourse(int courseId) {
		List<RegisterCourse> registerCourses = null;
		SessionFactory sessionFactory = null;
		Session session = null;

		try {
			sessionFactory = HibernateConnection.doHibernateConnection();
			session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "FROM RegisterCourse rc WHERE rc.course.courseId = :courseId";
			registerCourses = session.createQuery(hql, RegisterCourse.class)
					.setParameter("courseId", courseId)
					.getResultList();

			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (session != null)
				session.getTransaction().rollback();
		} finally {
			if (session != null)
				session.close();
		}

		return registerCourses;
	}

	public void payCourse(Transaction tran) {
		SessionFactory sessionFactory = null;
		Session session = null;
		try {
			sessionFactory = HibernateConnection.doHibernateConnection();
			session = sessionFactory.openSession();
			session.beginTransaction();

			session.saveOrUpdate(tran);

			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (session != null)
				session.getTransaction().rollback();
		} finally {
			if (session != null)
				session.close();
		}
	}

	public boolean insertTransaction(Transaction transaction) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			session.saveOrUpdate(transaction);

			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return false;
	}

	public ReviewCourse getReviewByUserAndCourse(User user, Course course) {
		ReviewCourse review = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "FROM ReviewCourse rc WHERE rc.user = :user AND rc.course = :course";
			review = session.createQuery(hql, ReviewCourse.class)
					.setParameter("user", user)
					.setParameter("course", course)
					.uniqueResult();

			session.getTransaction().commit();
			session.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return review;
	}

	public boolean checkStuRegisterCourse(Student student, Course course) {
		boolean isRegistered = false;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			String hql = "FROM RegisterCourse rc WHERE rc.student = :student AND rc.course = :course";
			RegisterCourse rc = session.createQuery(hql, RegisterCourse.class)
					.setParameter("student", student)
					.setParameter("course", course)
					.uniqueResult();

			if (rc != null) {
				isRegistered = true;
			}

			session.getTransaction().commit();
			session.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return isRegistered;
	}

}