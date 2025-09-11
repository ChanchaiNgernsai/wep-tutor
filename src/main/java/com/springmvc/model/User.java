package com.springmvc.model;

import java.util.*;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "users")
public class User {
	@Id
	@Column(name = "email", nullable = false, unique = true, length = 100)
	private String email;

	@Column(name = "password")
	private String password;

	@Column(name = "first_name", length = 50)
	private String firstName;

	@Column(name = "last_name", length = 50)
	private String lastName;

	@Column(name = "gender", length = 30)
	private String gender;

	@Column(name = "balance")
	private double balance;

	@Column(name = "phone_number", length = 50)
	private String phoneNumber;

	@Lob
	@Column(name = "profile_image", columnDefinition = "MEDIUMBLOB")
	private byte[] imgProfile;

	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<Role> roles;

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public User() {
		// TODO Auto-generated constructor stub
	}

	public User(String email, String password, String firstName, String lastName, String gender, double balance,
			String phoneNumber, byte[] imgProfile) {
		super();
		this.email = email;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.gender = gender;
		this.balance = balance;
		this.phoneNumber = phoneNumber;
		this.imgProfile = imgProfile;

	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public byte[] getImgProfile() {
		return imgProfile;
	}

	public void setImgProfile(byte[] imgProfile) {
		this.imgProfile = imgProfile;
	}

}
