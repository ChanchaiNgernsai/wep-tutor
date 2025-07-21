package com.springmvc.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name= "course_date")
public class CourseDate {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="course_date_id")
	private int courseDateId;
	
	@Column(name="class_date",length = 50)
	private String class_date;   /*เปลี่ยนเป็น Array*/
	
	@Column(name="start_time",length = 10)
	private String startTime; 
	
	@Column(name="end_time",length = 10)
	private String endTime; 
	
	@Column(name="topic",length = 100)
	private String topic;
	
	@ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
	

	public Course getCourse() {
		return course;
	}


	public void setCourse(Course course) {
		this.course = course;
	}


	public CourseDate() {
		// TODO Auto-generated constructor stub
	}


	public CourseDate(int courseDateId, String class_date, String startTime, String endTime, String topic) {
		super();
		this.courseDateId = courseDateId;
		this.class_date = class_date;
		this.startTime = startTime;
		this.endTime = endTime;
		this.topic = topic;
	}


	public int getCourseDateId() {
		return courseDateId;
	}


	public void setCourseDateId(int courseDateId) {
		this.courseDateId = courseDateId;
	}


	public String getClass_date() {
		return class_date;
	}


	public void setClass_date(String class_date) {
		this.class_date = class_date;
	}


	public String getStartTime() {
		return startTime;
	}


	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}


	public String getEndTime() {
		return endTime;
	}


	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}


	public String getTopic() {
		return topic;
	}


	public void setTopic(String topic) {
		this.topic = topic;
	}

}
