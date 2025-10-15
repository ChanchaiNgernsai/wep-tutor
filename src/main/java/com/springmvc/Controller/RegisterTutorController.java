package com.springmvc.Controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.User;
import com.springmvc.model.Course;
import com.springmvc.model.Skill;
import com.springmvc.model.Tutor;
import com.springmvc.model.TutorManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RegisterTutorController {
	@Autowired
	private MessageSource messageSource;

	@RequestMapping(value = "/goRegisterTutor", method = RequestMethod.GET)
	public String loadRegisterTutorPage() {
		return "RegisterTutor";
	}

	@RequestMapping(value = "/addRegisterTutor", method = RequestMethod.POST)
	public ModelAndView loadAddRegisTutor(HttpServletRequest request, HttpSession session) {
		String[] skillNames = request.getParameterValues("skill");
		String expertise = request.getParameter("expertise");

		User user = (User) session.getAttribute("User");
		if (user == null) {
			ModelAndView mav = new ModelAndView("Login");
			mav.addObject("error_null", messageSource.getMessage("error_null", null, Locale.forLanguageTag("th-TH")));
			return mav;
		}

		Tutor tutor = new Tutor();
		tutor.setExpertise(expertise);
		tutor.setUser(user);
		tutor.setBanStatus(1);
		session.setAttribute("Tutor", tutor);

		List<Skill> skillList = new ArrayList<>();
		if (skillNames != null) {
			for (String name : skillNames) {
				Skill skill = new Skill();
				skill.setSkillName(name);
				skill.setTutor(tutor);
				skillList.add(skill);
			}
		}

		TutorManager tmg = new TutorManager();
		boolean result = tmg.insertRegisterTutor(user, tutor, skillList);
		List<Course> latestCourses = tmg.getLatestCourses(5);

		if (result) {

			List<String> roleTypes = new ArrayList<>();
			roleTypes.add("Student");
			roleTypes.add("Tutor");
			session.setAttribute("Roles", roleTypes);
			ModelAndView mav = new ModelAndView("Home");
			mav.addObject("result_RegisTutor",
					messageSource.getMessage("result_RegisTutor", null, Locale.forLanguageTag("th-TH")));
			mav.addObject("latestCourses", latestCourses);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("RegisterTutor");
			mav.addObject("err_result", messageSource.getMessage("err_result", null, Locale.forLanguageTag("th-TH")));
			return mav;
		}

	}

}
