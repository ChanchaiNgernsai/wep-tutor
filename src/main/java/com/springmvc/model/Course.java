package com.springmvc.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "courses")
public class Course {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "course_id")
	private int courseId;

	@Column(name = "course_name", length = 50)
	private String courseName;

	@Column(name = "course_desc", length = 100)
	private String courseDescription;

	@Column(name = "course_price")
	private Double coursePrice;

	@Column(name = "max_students")
	private int maxStudents;

	@OneToMany(mappedBy = "course")
	private List<ReviewCourse> reviewCourses;

	public List<ReviewCourse> getReviewCourses() {
		return reviewCourses;
	}

	public void setReviewCourses(List<ReviewCourse> reviewCourses) {
		this.reviewCourses = reviewCourses;
	}

	@ManyToOne
	@JoinColumn(name = "tutor_role_id")
	private Tutor tutor;

	public Tutor getTutor() {
		return tutor;
	}

	public void setTutor(Tutor tutor) {
		this.tutor = tutor;
	}

	@OneToMany(mappedBy = "course", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<CourseDate> courseDates;

	public List<CourseDate> getCourseDates() {
		return courseDates;
	}

	public void setCourseDates(List<CourseDate> courseDates) {
		this.courseDates = courseDates;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "category_id")
	private Category category;

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Course() {
		// TODO Auto-generated constructor stub
	}

	public Course(String courseName, String courseDescription, Double coursePrice, int maxStudents) {
		super();
		this.courseName = courseName;
		this.courseDescription = courseDescription;
		this.coursePrice = coursePrice;
		this.maxStudents = maxStudents;
	}

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCourseDescription() {
		return courseDescription;
	}

	public void setCourseDescription(String courseDescription) {
		this.courseDescription = courseDescription;
	}

	public Double getCoursePrice() {
		return coursePrice;
	}

	public void setCoursePrice(Double coursePrice) {
		this.coursePrice = coursePrice;
	}

	public int getMaxStudents() {
		return maxStudents;
	}

	public void setMaxStudents(int maxStudents) {
		this.maxStudents = maxStudents;
	}

}
