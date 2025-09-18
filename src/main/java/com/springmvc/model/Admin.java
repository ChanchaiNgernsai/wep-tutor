package com.springmvc.model;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "admins")
public class Admin extends Role {

    public Admin() {
        // TODO Auto-generated constructor stub
    }

    public Admin(User user) {
        super(user, "Admin");
    }

}