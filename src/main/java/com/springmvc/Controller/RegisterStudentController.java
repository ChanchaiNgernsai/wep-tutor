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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import java.util.Locale;

@Controller
public class RegisterStudentController {

	@Autowired
	private MessageSource messageSource;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView loadHomePage() {
		TutorManager tmg = new TutorManager();
		List<Course> latestCourses = tmg.getLatestCourses(5); // ดึงล่าสุด 5 คอร์ส
		ModelAndView mav = new ModelAndView("Home");
		mav.addObject("latestCourses", latestCourses); // ส่งไป JSP
		return mav;
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
	// public String loadgoHomePage() {
	// return "Home";
	// }
	@RequestMapping(value = "/goAdminHome", method = RequestMethod.GET)
	public String loadAdminHomePage() {
		return "AdminHome";
	}

	@RequestMapping(value = "/goHome", method = RequestMethod.GET)
	public ModelAndView loadgoHomePage() {
		TutorManager tmg = new TutorManager();
		List<Course> latestCourses = tmg.getLatestCourses(5);
		ModelAndView mav = new ModelAndView("Home");
		mav.addObject("latestCourses", latestCourses);
		return mav;
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

		try {
			if (!file.isEmpty()) {
				user.setImgProfile(file.getBytes());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		session.setAttribute("User", user);

		TutorManager tmg = new TutorManager();
		boolean result = false;

		Student student = new Student();
		student.setUser(user);
		student.setStudentId(studentId);
		student.setYearOfStudy(yearOfStudy);
		session.setAttribute("Stu", student);
		result = tmg.insertRegisterStu(user, student);

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

			List<Role> roles = tmg.getUserRolesByEmail(email);
			for (Role role : roles) {
				if (role instanceof Tutor) {
					Tutor tutor = (Tutor) role;
					if (tutor.getBanStatus() == 0) {
						ModelAndView mav = new ModelAndView("Login");
						mav.addObject("err_login",
								messageSource.getMessage("err_banned", new Object[] { tutor.getBanDescription() },
										Locale.forLanguageTag("th-TH")));
						return mav;
					}
				}
			}

			session.setAttribute("email", email);
			session.setAttribute("User", user);

			List<String> roleTypes = new ArrayList<>();
			boolean isAdmin = false;
			for (Role role : roles) {
				String roleName = role.getClass().getSimpleName();
				roleTypes.add(roleName);

				if ("Student".equals(roleName))
					session.setAttribute("Stu", role);
				if ("Tutor".equals(roleName))
					session.setAttribute("Tutor", role);
				if ("Admin".equals(roleName))
					isAdmin = true;
			}

			session.setAttribute("Roles", roleTypes);
			List<Course> latestCourses = tmg.getLatestCourses(5);

			if (isAdmin) {
				// ถ้าเป็น Admin ให้ไปหน้า AdminHome
				ModelAndView mav = new ModelAndView("AdminHome");
				mav.addObject("result_login", "เข้าสู่ระบบเรียบร้อย (Admin)");
				return mav;
			} else {
				ModelAndView mav = new ModelAndView("Home");
				mav.addObject("result_login", "เข้าสู่ระบบเรียบร้อย");
				mav.addObject("latestCourses", latestCourses);
				return mav;
			}

		} else {
			ModelAndView mav = new ModelAndView("Login");

			// use existing err_login key from messages.properties and hard-code Thai locale
			mav.addObject("err_login", messageSource.getMessage("err_login", null, Locale.forLanguageTag("th-TH")));
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
