package com.springmvc.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "tutors")
public class Tutor extends Role {

	@Column(name = "expertise", length = 50)
	private String expertise;

	@Column(name = "ban_status")
	private int banStatus;

	@Column(name = "ban_description", length = 200)
	private String banDescription;

	@Column(name = "ban_date")
	@Temporal(value = TemporalType.DATE) /* TIMESTAMP = เอาเวลา Date = วันที่ */
	private Date banDate;

	@OneToMany(mappedBy = "tutor", cascade = CascadeType.ALL)
	private List<Skill> skills;

	public List<Skill> getSkills() {
		return skills;
	}

	public void setSkills(List<Skill> skills) {
		this.skills = skills;
	}

	public Tutor() {
		// TODO Auto-generated constructor stub
	}

	public Tutor(User user, String expertise, int banStatus, String banDescription, Date banDate) {
		super(user, "Tutor");
		this.expertise = expertise;
		this.banStatus = banStatus;
		this.banDescription = banDescription;
		this.banDate = banDate;
	}

	public String getExpertise() {
		return expertise;
	}

	public void setExpertise(String expertise) {
		this.expertise = expertise;
	}

	public int getBanStatus() {
		return banStatus;
	}

	public void setBanStatus(int banStatus) {
		this.banStatus = banStatus;
	}

	public String getBanDescription() {
		return banDescription;
	}

	public void setBanDescription(String banDescription) {
		this.banDescription = banDescription;
	}

	public Date getBanDate() {
		return banDate;
	}

	public void setBanDate(Date banDate) {
		this.banDate = banDate;
	}

}
