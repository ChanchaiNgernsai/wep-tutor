package com.springmvc.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "payments")
public class Payment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "payment_id")
	private int paymentId;

	@Column(name = "amount")
	private Double amount;

	@Column(name = "payment_date")
	@Temporal(value = TemporalType.DATE)
	private Date paymentDate;

	public Payment() {
		// TODO Auto-generated constructor stub
	}

	@OneToOne(mappedBy = "payment")
	private RegisterCourse registerCourse;

	public RegisterCourse getRegisterCourse() {
		return registerCourse;
	}

	public void setRegisterCourse(RegisterCourse registerCourse) {
		this.registerCourse = registerCourse;
	}

	public Payment(Double amount, Date paymentDate) {
		super();
		this.amount = amount;
		this.paymentDate = paymentDate;
	}

	public int getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}
}
