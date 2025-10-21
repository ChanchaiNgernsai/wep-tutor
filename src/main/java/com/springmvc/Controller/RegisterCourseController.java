package com.springmvc.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Course;
import com.springmvc.model.CourseDate;
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

    @Autowired
    private MessageSource messageSource;

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
    public ModelAndView loadViewRegisterCoursePage(HttpServletRequest request, HttpSession session) {
        int registerId = Integer.parseInt(request.getParameter("registerId"));

        TutorManager tmg = new TutorManager();
        RegisterCourse rc = tmg.getRegisterCourseById(registerId);

        session.setAttribute("RegisterCourse", rc);

        List<CourseDate> courseDates = rc.getCourse().getCourseDates();
        String lastCourseEndDate = "";

        if (!courseDates.isEmpty()) {
            CourseDate lastCd = courseDates.get(courseDates.size() - 1);
            lastCourseEndDate = lastCd.getClass_date() + "T" + lastCd.getEndTime() + ":00";
        }

        ModelAndView mav = new ModelAndView("ViewRegisterCourse");
        mav.addObject("rc", rc);
        mav.addObject("course", rc.getCourse());
        mav.addObject("courseDates", courseDates);
        mav.addObject("lastCourseEndDate", lastCourseEndDate);
        return mav;
    }

    @RequestMapping(value = "/getRegisterCourse", method = RequestMethod.GET)
    public ModelAndView goRegisterCourse(HttpServletRequest request, HttpSession session) {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            return new ModelAndView("redirect:/goHome");
        }
        int id = Integer.parseInt(idStr);

        TutorManager tmg = new TutorManager();
        Course course = tmg.getCourseById(id);

        Student student = (Student) session.getAttribute("Stu");
        User us = student.getUser();
        RegisterCourse rc = tmg.getRegisterCourseById(id);

        double balance = tmg.getBalanceByStudent(us.getEmail());

        ModelAndView mav = new ModelAndView("RegisterCourse");
        mav.addObject("course", course);
        mav.addObject("User", us);
        mav.addObject("balance", balance);
        mav.addObject("RegisterCourse", rc);

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
        if (course == null) {
            return new ModelAndView("redirect:/goHome");
        }

        double balance = tmg.getBalanceByStudent(student.getUser().getEmail());
        if (balance < course.getCoursePrice()) {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_money", "ยอดเงินไม่เพียงพอ กรุณาเติมเงินก่อนลงทะเบียน");
            mav.addObject("course", course);
            mav.addObject("balance", balance);
            return mav;
        }

        int checkNumStu = tmg.getRegisterCoursesByCourse(courseId).size();
        if (checkNumStu >= course.getMaxStudents()) {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_maxstu", "จำนวนผู้เรียนเต็มแล้ว");
            mav.addObject("course", course);
            mav.addObject("balance", balance);
            return mav;
        }

        Payment payment = new Payment();
        payment.setAmount(course.getCoursePrice());
        payment.setPaymentDate(new Date());
        tmg.insertPayment(payment);

        RegisterCourse rc = new RegisterCourse();
        rc.setStudent(student);
        rc.setCourse(course);
        rc.setRegisStatus(0);
        rc.setPayment(payment);

        boolean result = tmg.insertRegisterCourse(rc);

        if (result) {
            ModelAndView mav = new ModelAndView("Payment");
            mav.addObject("result_payment", "ลงทะเบียนคอร์สเรียบร้อยแล้ว รอยืนยันการสอนก่อนหักเงิน");
            mav.addObject("student", student);
            mav.addObject("course", course);
            mav.addObject("payment", payment);
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_registerCourse", "เกิดข้อผิดพลาดในการลงทะเบียนคอร์ส");
            mav.addObject("course", course);
            mav.addObject("balance", balance);
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
            session.setAttribute("err_result_cancel",
                    messageSource.getMessage("err_result_cancel", null, Locale.forLanguageTag("th-TH")));
            return new ModelAndView("redirect:/goListRegisterCourse");
        } else {
            return new ModelAndView("ViewRegisterCourse", "err_result",
                    messageSource.getMessage("err_result", null, Locale.forLanguageTag("th-TH")));
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
        List<RegisterCourse> registerCourses = tmg.getRegisterCoursesByCourse(courseId);
        ModelAndView mav = new ModelAndView("ListStudentCourse");
        mav.addObject("course", course);
        mav.addObject("students", students);
        mav.addObject("registerCourses", registerCourses);

        return mav;
    }

    @RequestMapping(value = "/confirmLesson", method = RequestMethod.POST)
    public ModelAndView confirmLesson(HttpServletRequest request, HttpSession session) {

        String registerCourseIdStr = request.getParameter("registerCourseId");
        if (registerCourseIdStr == null || registerCourseIdStr.isEmpty()) {
            return new ModelAndView("redirect:/goListRegisterCourse");
        }
        int registerCourseId = Integer.parseInt(registerCourseIdStr);

        Student student = (Student) session.getAttribute("Stu");
        if (student == null) {
            return new ModelAndView("Login", "error", "กรุณาเข้าสู่ระบบก่อนดูรายการคอร์ส");
        }

        TutorManager tmg = new TutorManager();
        RegisterCourse rc = tmg.getRegisterCourseById(registerCourseId);

        if (rc == null) {
            ModelAndView mav = new ModelAndView("ViewRegisterCourse");
            mav.addObject("err_result_confirm", "ไม่พบข้อมูลคอร์สที่ต้องยืนยัน");
            return mav;
        }

        boolean success = tmg.confirmRegisterCourse(rc);
        rc = tmg.getRegisterCourseById(registerCourseId);

        ModelAndView mav = new ModelAndView("ViewRegisterCourse");
        mav.addObject("rc", rc);
        mav.addObject("courseDates", rc.getCourse().getCourseDates());

        if (success) {
            mav.addObject("success_msg", "ยืนยันการสอนเรียบร้อยแล้ว และเงินถูกโอนให้นักศึกษา → ติวเตอร์เรียบร้อย");
        } else {
            mav.addObject("err_result_confirm", "เกิดข้อผิดพลาดในการยืนยันการสอน/โอนเงิน");
        }

        return mav;
    }

}
