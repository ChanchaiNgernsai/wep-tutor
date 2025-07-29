package com.springmvc.Controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;




import com.springmvc.model.*;

@Controller
public class RegisterStudentController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String loadHomePage() {
        return "Home";
    }
	
	 @RequestMapping(value = "/goRegisterStu", method = RequestMethod.GET)
	    public String loadRegisterPage() {
	        return "RegisterStudent";
	    }
	 
	 @RequestMapping(value = "/goLogin", method = RequestMethod.GET)
	    public String loadLoginPage() {
	        return "Login";
	    }
	 
	 @RequestMapping(value = "/goHome", method = RequestMethod.GET)
	    public String goHomePage() {
	        return "Home";
	    }
	 
	 @RequestMapping(value = "/addRegisterStu", method = RequestMethod.POST)
	 public ModelAndView addRegisterStudent(HttpServletRequest request, HttpSession session) {
	     String studentId = request.getParameter("student_id");
	     String email = request.getParameter("email");
	     String fname = request.getParameter("fname");
	     String password = request.getParameter("password");
	     String lname = request.getParameter("lname");
	     String gender = request.getParameter("gender");
	     String phoNum = request.getParameter("phon_num");
	     String image = request.getParameter("image");
	     String yearOfStudy = request.getParameter("yfs");
	     
	   try {
	            password = PasswordUtil.getInstance().createPassword(password, "itmjusci");
	        } catch (Exception e) {
	            ModelAndView mav = new ModelAndView("RegisterUser");
	            mav.addObject("add_result", "ไม่สามารถสร้างรหัสผ่านได้");
	            return mav;
	        }

	     
	     User user = new User();
	     user.setEmail(email);
	     user.setPassword(password);
	     user.setFirstName(fname);
	     user.setLastName(lname);
	     user.setGender(gender);
	     user.setPhoneNumber(phoNum);
	     user.setImgProfile(image);
	     user.setBalance(0.0); 
	     session.setAttribute("User", user);

	     Student student = new Student();
	     student.setUser(user);
	     student.setStudenId(studentId);
	     student.setYearOfStudy(yearOfStudy);
	     session.setAttribute("Stu", student);

	     
	     TutorManager tmg = new TutorManager();
	     boolean result = tmg.insertRegister(user, student);
	        if (result) {
	            return new ModelAndView("Login");
	        } else {
	            ModelAndView mav = new ModelAndView("RegisterStudent");
	            mav.addObject("add_result", "ไม่สามารถบันทึกได้");
	            return mav;
	 }

	}
	 
	 
	 
	 
	 @RequestMapping(value = "/loginUser", method = RequestMethod.POST)
	    public ModelAndView loginUser(HttpServletRequest request, HttpSession session) {	 
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        
	        try {
	            password = PasswordUtil.getInstance().createPassword(password, "itmjusci");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        TutorManager tmg = new TutorManager();
	        User user = tmg.getRegisterByEmail(email);

	        if (user != null && user.getPassword() != null && user.getPassword().equals(password)) {
	        	session.setAttribute("email", email);
	        	session.setAttribute("User", user);
	            
	        	List<Role> roles = tmg.getUserRolesByEmail(email);

	        	List<String> roleTypes = new ArrayList<>();

	        	for (Role role : roles) {
	        	    if (role instanceof Student) {
	        	        session.setAttribute("Stu", (Student) role);
	        	        roleTypes.add("Student");
	        	    } else if (role instanceof Tutor) {
	        	        session.setAttribute("Tutor", (Tutor) role);
	        	        roleTypes.add("Tutor");
	        	    } else {
	        	        roleTypes.add("Unknown");
	        	    }
	        	}
	        	session.setAttribute("Roles", roleTypes);
	            
	            Student student = tmg.getStudentByEmail(email);
	            session.setAttribute("Stu", student);
	            
	            Tutor tutor = tmg.getTutorByEmail(email);
	            if (tutor != null) {
	                session.setAttribute("Tutor", tutor);
	            }
	            
	            return new ModelAndView("Home");
	        } else {
	            ModelAndView mav = new ModelAndView("Login");
	            mav.addObject("add_result", "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
	            return mav;
	        }
	    }
	

	 
	 @RequestMapping(value = "/logout", method = RequestMethod.POST)
	 public ModelAndView logout(HttpSession session) {
	     session.invalidate(); 
	     return new ModelAndView("redirect:/goLogin"); 
	 } 

}
