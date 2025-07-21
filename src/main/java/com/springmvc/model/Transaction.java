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
@Table(name= "transactions")
public class Transaction {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="tran_id")
	private int tranId;
	
	@Column(name="deposit")
    private Double deposit;
	
	@Column(name="deposit_date")
	@Temporal(value=TemporalType.DATE)
    private Date depositDate;
	
	@Column(name="withdraw")
    private Double withdraw;
	
	@Column(name="withdraw_date")
	@Temporal(value=TemporalType.DATE)
    private Date withdrawDate;
	
	
    @Column(name="account_number",length = 20)
    private String accountNumber;
    
    @Column(name="tran_type",length = 50)
    private String tranType;
    
    @ManyToOne
    @JoinColumn(name = "email")
    private User user;
    
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
    
   

	public Transaction() {
		// TODO Auto-generated constructor stub
	}



	public Transaction(Double deposit, Date depositDate, Double withdraw, Date withdrawDate,
			String accountNumber, String tranType) {
		super();
		this.deposit = deposit;
		this.depositDate = depositDate;
		this.withdraw = withdraw;
		this.withdrawDate = withdrawDate;
		this.accountNumber = accountNumber;
		this.tranType = tranType;
	}

	

	public int getTranId() {
		return tranId;
	}

	public void setTranId(int tranId) {
		this.tranId = tranId;
	}

	public Double getDeposit() {
		return deposit;
	}

	public void setDeposit(Double deposit) {
		this.deposit = deposit;
	}

	public Date getDepositDate() {
		return depositDate;
	}

	public void setDepositDate(Date depositDate) {
		this.depositDate = depositDate;
	}

	public Double getWithdraw() {
		return withdraw;
	}

	public void setWithdraw(Double withdraw) {
		this.withdraw = withdraw;
	}

	public Date getWithdrawDate() {
		return withdrawDate;
	}

	public void setWithdrawDate(Date withdrawDate) {
		this.withdrawDate = withdrawDate;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getTranType() {
		return tranType;
	}

	public void setTranType(String tranType) {
		this.tranType = tranType;
	}

	
	
	
	


}
