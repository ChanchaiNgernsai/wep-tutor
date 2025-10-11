package com.springmvc.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Course;
import com.springmvc.model.CourseDate;
import com.springmvc.model.ReviewCourse;
import com.springmvc.model.Student;
import com.springmvc.model.Tutor;
import com.springmvc.model.TutorManager;
import com.springmvc.model.Category;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AddCourseController {

	@RequestMapping(value = "/goAddCourse", method = RequestMethod.GET)
	public ModelAndView loadAddCoursePage(HttpSession session) {
		String email = (String) session.getAttribute("email");
		if (email == null) {
			return new ModelAndView("redirect:/goLogin");
		}

		TutorManager tm = new TutorManager();
		Tutor tutor = tm.getTutorByEmail(email);

		ModelAndView mav = new ModelAndView("AddCourse");
		mav.addObject("tutor", tutor);
		return mav;
	}

	@RequestMapping(value = "/addCourse", method = RequestMethod.POST)
	public ModelAndView loadAddCourse(HttpServletRequest request, HttpSession session) {
		String tutor_email = (String) session.getAttribute("email");
		String course_Name = request.getParameter("courseName");
		String category_Name = request.getParameter("cateName");
		String course_Descrip = request.getParameter("courseDescrip");
		int maxStudents = Integer.parseInt(request.getParameter("maxStu"));
		double course_price = Double.parseDouble(request.getParameter("price"));

		String[] class_Date = request.getParameterValues("classDate");
		String[] start_Time = request.getParameterValues("startTime");
		String[] end_Time = request.getParameterValues("endTime");
		String[] topic_Name = request.getParameterValues("topicName");

		Course course = new Course();
		course.setCourseName(course_Name);
		course.setCourseDescription(course_Descrip);
		course.setMaxStudents(maxStudents);
		course.setCoursePrice(course_price);

		Category category = new Category();
		category.setCategoryName(category_Name);
		course.setCategory(category);

		List<CourseDate> cdl = new ArrayList<>();
		if (class_Date != null && start_Time != null && end_Time != null && topic_Name != null) {
			int n = class_Date.length;

			for (int i = 0; i < n; i++) {
				CourseDate cd = new CourseDate();
				cd.setClass_date(class_Date[i]);
				cd.setStartTime(start_Time[i]);
				cd.setEndTime(end_Time[i]);
				cd.setTopic(topic_Name[i]);
				cd.setCourse(course);
				cdl.add(cd);
			}

		}

		course.setCourseDates(cdl);

		TutorManager tmg = new TutorManager();
		Tutor tutor = tmg.getTutorByEmail(tutor_email);
		course.setTutor(tutor);

		boolean result = tmg.insertCourse(course, category, cdl);
		if (result) {
			List<Course> courses = tmg.getCoursesByTutorEmail(tutor_email);
			ModelAndView mav = new ModelAndView("ListTutorCourse");
			mav.addObject("courses", courses);
			mav.addObject("result_addCourse", "เพิ่มคอร์สเรียบร้อย");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("AddCourse");
			mav.addObject("error_result", "ไม่สามารถบันทึกได้");
			return mav;
		}

	}

	@RequestMapping(value = "/listTutorCourses", method = RequestMethod.GET)
	public ModelAndView listTutorCourses(HttpSession session) {
		String email = (String) session.getAttribute("email");

		TutorManager tmg = new TutorManager();
		List<Course> courses = tmg.getCoursesByTutorEmail(email);
		ModelAndView mav = new ModelAndView("ListTutorCourse");
		mav.addObject("courses", courses);
		return mav;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView lordPageSearch(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");

		TutorManager tmg = new TutorManager();
		List<Course> result = tmg.searchCoursesByKeyword(keyword);

		ModelAndView mav = new ModelAndView("SearchCourse");
		mav.addObject("results", result);
		mav.addObject("keyword", keyword);
		return mav;
	}

	@RequestMapping(value = "/getViewCourse", method = RequestMethod.GET)
	public ModelAndView getViewCourse(HttpServletRequest request, HttpSession session) {
		int courseId = Integer.parseInt(request.getParameter("id"));
		TutorManager tmg = new TutorManager();

		Course course = tmg.getCourseById(courseId);
		List<ReviewCourse> reviews = tmg.getReviewsByCourse(courseId);

		ModelAndView mav = new ModelAndView("ViewCourse");
		mav.addObject("course", course);
		mav.addObject("reviews", reviews);

		Student student = (Student) session.getAttribute("Stu");
		if (student != null) {
			boolean alreadyRegistered = tmg.checkStuRegisterCourse(student, course);
			mav.addObject("alreadyRegistered", alreadyRegistered);
		}

		return mav;
	}

}
