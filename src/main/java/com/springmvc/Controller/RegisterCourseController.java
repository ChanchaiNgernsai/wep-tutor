package com.springmvc.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Course;
import com.springmvc.model.Payment;
import com.springmvc.model.RegisterCourse;
import com.springmvc.model.Student;
import com.springmvc.model.Transaction;
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

        ModelAndView mav = new ModelAndView("ViewRegisterCourse");
        mav.addObject("rc", rc);
        mav.addObject("course", rc.getCourse());
        mav.addObject("courseDates", rc.getCourse().getCourseDates());
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

        double balance = tmg.getBalance(us.getEmail());

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
        double balance = tmg.getBalance(student.getUser().getEmail());
        if (balance < course.getCoursePrice()) {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_money", messageSource.getMessage("err_money", null, Locale.forLanguageTag("th-TH")));
            mav.addObject("course", course);
            mav.addObject("balance", balance);
            return mav;
        }

        int checkNumStu = tmg.getRegisterCoursesByCourse(courseId).size();
        if (checkNumStu >= course.getMaxStudents()) {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_maxstu", messageSource.getMessage("err_maxstu", null, Locale.forLanguageTag("th-TH")));
            mav.addObject("course", course);
            mav.addObject("balance", tmg.getBalance(student.getUser().getEmail()));
            return mav;
        }

        Payment payment = new Payment();
        payment.setAmount(course.getCoursePrice());
        payment.setPaymentDate(new Date());
        payment.setPaymentStatus(0);
        tmg.insertPayment(payment);

        User tutorUser = course.getTutor().getUser();

        Transaction transaction = new Transaction();
        transaction.setDeposit(course.getCoursePrice());
        transaction.setWithdraw(0.0);
        transaction.setTranType("Course Payment");
        transaction.setDepositDate(new java.util.Date());
        transaction.setUser(tutorUser);

        User studentUser = student.getUser();

        Transaction studentTransaction = new Transaction();
        studentTransaction.setDeposit(0.0);
        studentTransaction.setWithdraw(course.getCoursePrice());
        studentTransaction.setTranType("Course Registration");
        studentTransaction.setWithdrawDate(new java.util.Date());
        studentTransaction.setUser(studentUser);
        tmg.insertTransaction(studentTransaction);

        boolean transactionResult = tmg.insertTransaction(transaction);
        if (!transactionResult) {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_result", "เกิดข้อผิดพลาดในการบันทึกธุรกรรมให้ติวเตอร์");
            mav.addObject("course", course);
            return mav;
        }

        RegisterCourse rc = new RegisterCourse();
        rc.setStudent(student);
        rc.setCourse(course);
        rc.setRegisStatus(1);
        rc.setPayment(payment);

        boolean result = tmg.insertRegisterCourse(rc);

        if (result) {
            ModelAndView mav = new ModelAndView("Payment");
            mav.addObject("result_payment",
                    messageSource.getMessage("result_registerCourse", null, Locale.forLanguageTag("th-TH")));
            mav.addObject("student", student);
            mav.addObject("course", course);
            mav.addObject("payment", payment);
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("RegisterCourse");
            mav.addObject("err_registerCourse",
                    messageSource.getMessage("err_registerCourse", null, Locale.forLanguageTag("th-TH")));
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
        ModelAndView mav = new ModelAndView("ListStudentCourse");
        mav.addObject("course", course);
        mav.addObject("students", students);

        return mav;
    }

}
