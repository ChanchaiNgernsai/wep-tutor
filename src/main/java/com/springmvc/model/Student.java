package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "students")
public class Student extends Role {

	@Column(name = "student_id", length = 20)
	private String studentId;

	@Column(name = "year_of_study", length = 20)
	private String yearOfStudy;

	@ManyToOne
	@JoinColumn(name = "email")
	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Student() {
		// TODO Auto-generated constructor stub
	}

	public Student(User user, String studentId, String yearOfStudy) {
		super(user, "Student");
		this.studentId = studentId;
		this.yearOfStudy = yearOfStudy;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getYearOfStudy() {
		return yearOfStudy;
	}

	public void setYearOfStudy(String yearOfStudy) {
		this.yearOfStudy = yearOfStudy;
	}

}
