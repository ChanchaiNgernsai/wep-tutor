package com.springmvc.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;



@Entity
@Table(name= "review_corses")
public class ReviewCourse {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="review_id")
	private int reviewId;
	
	@Column(name="score")
    private Double score;
	
    @Column(name="comment",length = 100)
    private String comment;
    
    @Column(name="review_date")
    @Temporal(value=TemporalType.DATE)
    private Date reviewDate;
    
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
    @JoinColumn(name = "courseId")
    private Course course;


	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public ReviewCourse(Double score, String comment, Date reviewDate) {
		super();
		this.score = score;
		this.comment = comment;
		this.reviewDate = reviewDate;
	}



	public ReviewCourse() {
		// TODO Auto-generated constructor stub
	}



	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public Double getScore() {
		return score;
	}



	public void setScore(Double score) {
		this.score = score;
	}



	public String getComment() {
		return comment;
	}



	public void setComment(String comment) {
		this.comment = comment;
	}



	public Date getReviewDate() {
		return reviewDate;
	}



	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

}
