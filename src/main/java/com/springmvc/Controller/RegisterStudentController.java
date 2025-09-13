package com.springmvc.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

	// @RequestMapping(value = "/goHome", method = RequestMethod.GET)
	// public ModelAndView loadHomePage(HttpSession session) {
	// TutorManager tmg = new TutorManager();

	// List<ReviewCourse> reviews = tmg.getAllReviews();

	// ModelAndView mav = new ModelAndView("Home");
	// mav.addObject("reviews", reviews);
	// return mav;
	// }

	@RequestMapping(value = "/goHome", method = RequestMethod.GET)
	public String loadgoHomePage() {
		return "Home";
	}

	@RequestMapping(value = "/addRegisterStu", method = RequestMethod.POST)
	public ModelAndView addRegisterStudent(@RequestParam("image") MultipartFile file,
			HttpServletRequest request, HttpSession session) {

		String studentId = request.getParameter("student_id");
		String email = request.getParameter("email");
		String fname = request.getParameter("fname");
		String password = request.getParameter("password");
		String lname = request.getParameter("lname");
		String gender = request.getParameter("gender");
		String phoNum = request.getParameter("phon_num");
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
		user.setBalance(0.0);

		// ถ้ามีรูป ให้เก็บลง User (byte[])
		try {
			if (!file.isEmpty()) {
				user.setImgProfile(file.getBytes()); // User ต้องมีฟิลด์ byte[] image
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		session.setAttribute("User", user);

		Student student = new Student();
		student.setUser(user);
		student.setStudentId(studentId);
		student.setYearOfStudy(yearOfStudy);
		session.setAttribute("Stu", student);

		TutorManager tmg = new TutorManager();
		boolean result = tmg.insertRegister(user, student); // ต้องปรับให้บันทึก byte[] ด้วย

		if (result) {
			ModelAndView mav = new ModelAndView("Login");
			mav.addObject("result_regis", "ลงทะเบียนสำเร็จ! กรุณาเข้าสู่ระบบ");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("RegisterStudent");
			mav.addObject("err_result", "ไม่สามารถบันทึกได้");
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
			ModelAndView mav = new ModelAndView("Home");
			mav.addObject("result_login", "เข้าสู่ระบบเรียบร้อย");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("Login");
			mav.addObject("err_login", "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
			return mav;
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		return new ModelAndView("redirect:/goLogin");
	}

	@RequestMapping(value = "/getUserImage", method = RequestMethod.GET)
	public void getUserImage(@RequestParam("email") String email, HttpServletResponse response) {
		try {
			TutorManager tmg = new TutorManager();
			User user = tmg.getRegisterByEmail(email);

			if (user != null && user.getImgProfile() != null) {
				response.setContentType("image/png");
				response.getOutputStream().write(user.getImgProfile());
				response.getOutputStream().close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
