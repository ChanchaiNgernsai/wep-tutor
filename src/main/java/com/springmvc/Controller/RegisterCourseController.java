package com.springmvc.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Course;
import com.springmvc.model.Payment;
import com.springmvc.model.RegisterCourse;
import com.springmvc.model.Student;
import com.springmvc.model.TutorManager;
import com.springmvc.model.User;

import java.util.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RegisterCourseController {

    @RequestMapping(value = "/goListRegisterCourse", method = RequestMethod.GET)
    public ModelAndView loadListRegisterCoursePage(HttpSession session) {
        Student student = (Student) session.getAttribute("Stu");
        if (student == null) {
            return new ModelAndView("Login", "error", "กรุณาเข้าสู่ระบบก่อนดูรายการคอร์ส");
        }

        TutorManager tmg = new TutorManager();

        List<RegisterCourse> registerCourses = tmg.getRegisterCoursesByStudent(student);

        ModelAndView mav = new ModelAndView("ListRegisterCourse");
        mav.addObject("registerCourses", registerCourses);
        return mav;
    }

    @RequestMapping(value = "/getViewRegisterCourse", method = RequestMethod.GET)
    public ModelAndView loadViewRegisterCoursePage(HttpServletRequest request) {
        int registerId = Integer.parseInt(request.getParameter("registerId"));

        TutorManager tmg = new TutorManager();
        RegisterCourse rc = tmg.getRegisterCourseById(registerId);

        ModelAndView mav = new ModelAndView("ViewRegisterCourse");
        mav.addObject("rc", rc);
        mav.addObject("course", rc.getCourse());
        mav.addObject("courseDates", rc.getCourse().getCourseDates());
        return mav;
    }

    @RequestMapping(value = "/getRegisterCourse", method = RequestMethod.GET)
    public ModelAndView goRegisterCourse(HttpServletRequest request, HttpSession session) {
        String idStr = request.getParameter("id");
        int id = 0;
        if (idStr != null && !idStr.isEmpty()) {
            id = Integer.parseInt(idStr);
        } else {
            return new ModelAndView("redirect:/goHome");
        }

        TutorManager tmg = new TutorManager();
        Course course = tmg.getCourseById(id);

        User us = (User) session.getAttribute("us");

        ModelAndView mav = new ModelAndView("RegisterCourse");
        mav.addObject("course", course);
        mav.addObject("us", us);
        return mav;
    }

    @RequestMapping(value = "/addRegisterCourse", method = RequestMethod.POST)
    public ModelAndView addRegisterCourse(HttpServletRequest request, HttpSession session) {
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            return new ModelAndView("redirect:/goHome");
        }
        int courseId = Integer.parseInt(courseIdStr);

        Student student = (Student) session.getAttribute("Stu");
        if (student == null) {
            return new ModelAndView("Login", "error", "กรุณาเข้าสู่ระบบก่อนลงทะเบียนคอร์ส");
        }

        TutorManager tmg = new TutorManager();
        Course course = tmg.getCourseById(courseId);

        Payment payment = new Payment();
        payment.setAmount(course.getCoursePrice());
        payment.setPaymentDate(new Date());
        payment.setPaymentStatus(0);
        tmg.insertPayment(payment);

        RegisterCourse rc = new RegisterCourse();
        rc.setStudent(student);
        rc.setCourse(course);
        rc.setRegisStatus(1);
        rc.setPayment(payment);

        boolean result = tmg.insertRegisterCourse(rc);

        if (result) {
            ModelAndView mav = new ModelAndView("Payment");
            mav.addObject("msg", "ลงทะเบียนคอร์สเรียบร้อยแล้ว");
            mav.addObject("student", student);
            mav.addObject("course", course);
            mav.addObject("payment", payment);
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_result", "ไม่สามารถบันทึกการลงทะเบียนได้");
            mav.addObject("course", course);
            return mav;
        }
    }

    @RequestMapping(value = "/cancelRegisterCourse", method = RequestMethod.POST)
    public ModelAndView cancelRegisterCourse(HttpServletRequest request, HttpSession session) {
        String registerIdStr = request.getParameter("registerId");
        if (registerIdStr == null || registerIdStr.isEmpty()) {
            return new ModelAndView("redirect:/goListRegisterCourse");
        }

        int registerId = Integer.parseInt(registerIdStr);

        TutorManager tmg = new TutorManager();
        boolean result = tmg.deleteRegisterCourse(registerId);

        if (result) {
            session.setAttribute("err_result_cancel", "ยกเลิกคอร์สเรียบร้อยแล้ว");
            return new ModelAndView("redirect:/goListRegisterCourse");
        } else {
            return new ModelAndView("ViewRegisterCourse", "err_result", "ไม่สามารถยกเลิกคอร์สได้");
        }
    }

    @RequestMapping(value = "/getViewTutorCourse", method = RequestMethod.GET)
    public ModelAndView viewTutorCourse(HttpServletRequest request) {
        String idStr = request.getParameter("id");
        int courseId = 0;
        if (idStr != null && !idStr.isEmpty()) {
            try {
                courseId = Integer.parseInt(idStr);
            } catch (NumberFormatException ex) {
                return new ModelAndView("redirect:/goHome");
            }
        } else {
            return new ModelAndView("redirect:/goHome");
        }

        TutorManager tmg = new TutorManager();
        Course course = tmg.getCourseById(courseId);

        if (course == null) {
            return new ModelAndView("redirect:/goHome");
        }

        ModelAndView mav = new ModelAndView("ViewTutorCourse");
        mav.addObject("course", course);
        return mav;
    }

    @RequestMapping(value = "/getListStudentCourse", method = RequestMethod.GET)
    public ModelAndView getListStudentCourse(HttpServletRequest request) {
        TutorManager tmg = new TutorManager();
        int courseId = Integer.parseInt(request.getParameter("id"));
        Course course = tmg.getCourseById(courseId);

        List<Student> students = tmg.getStudentsByCourseId(courseId);
        ModelAndView mav = new ModelAndView("ListStudentCourse");
        mav.addObject("course", course);
        mav.addObject("students", students);

        return mav;
    }

}
