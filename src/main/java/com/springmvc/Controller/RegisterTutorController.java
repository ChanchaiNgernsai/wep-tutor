package com.springmvc.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.User;
import com.springmvc.model.Skill;
import com.springmvc.model.Tutor;
import com.springmvc.model.TutorManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RegisterTutorController {

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
			mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนสมัครเป็นติวเตอร์");
			return mav;
		}

		Tutor tutor = new Tutor();
		tutor.setExpertise(expertise);
		tutor.setUser(user);
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

		if (result) {
			ModelAndView mav = new ModelAndView("Home");
			mav.addObject("result_RegisTutor", "ลงทะเบียนติวเตอร์สำเร็จ");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("RegisterTutor");
			mav.addObject("err_result", "ไม่สามารถบันทึกได้");
			return mav;
		}

	}

}
