package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;



@Entity
@Table(name= "register_courses")
public class RegisterCourse {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="register_course_id")
	private int registerCourseId;
	
	@Column(name="regis_status")
    private int regisStatus;
    
    
    
    @ManyToOne
    @JoinColumn(name = "student_role_id")
    private User user;
    
	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}

	@ManyToOne
	@JoinColumn(name="course_id")  
	private Course course;
	
	

	

	public Course getCourse() {
		return course;
	}


	public void setCourse(Course course) {
		this.course = course;
	}

	@OneToOne
	@JoinColumn(name = "payment_id") 
	private Payment payment;
	
	
	public Payment getPayment() {
		return payment;
	}


	public void setPayment(Payment payment) {
		this.payment = payment;
	}
	


	public RegisterCourse(int regisStatus) {
		super();
		this.regisStatus = regisStatus;
	}


	public RegisterCourse() {
		// TODO Auto-generated constructor stub
	}


	public int getRegisterCourseId() {
		return registerCourseId;
	}


	public void setRegisterCourseId(int registerCourseId) {
		this.registerCourseId = registerCourseId;
	}


	public int getRegisStatus() {
		return regisStatus;
	}


	public void setRegisStatus(int regisStatus) {
		this.regisStatus = regisStatus;
	}

}
