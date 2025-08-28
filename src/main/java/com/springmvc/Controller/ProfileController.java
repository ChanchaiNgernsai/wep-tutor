package com.springmvc.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Student;
import com.springmvc.model.TutorManager;
import com.springmvc.model.User;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ProfileController {

    @RequestMapping(value = "/goProfile", method = RequestMethod.GET)
    public String loadProfilePage() {
        return "ViewProfile";
    }

    @RequestMapping(value = "/getRegister", method = RequestMethod.GET)
    public ModelAndView loadGetRegisterPage(HttpServletRequest request) {
        TutorManager mtm = new TutorManager();
        User r = null;
        Student s = null;

        try {
            String email = request.getParameter("id");
            r = mtm.getRegisterByEmail(email);
            s = mtm.getStudentByEmail(email);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        ModelAndView mav = new ModelAndView("EditProfile");
        mav.addObject("User", r);
        mav.addObject("Stu", s);
        return mav;
    }

    @RequestMapping(value = "/editProfile", method = RequestMethod.POST)
    public ModelAndView loadeditProfilePage(HttpServletRequest request) {
        TutorManager tmg = new TutorManager();
        String email = request.getParameter("email");

        // ดึง entity
        User us = tmg.getRegisterByEmail(email);
        Student stu = tmg.getStudentByEmail(email);

        if (us != null && stu != null) {
            us.setFirstName(request.getParameter("fname"));
            us.setLastName(request.getParameter("lname"));
            us.setPhoneNumber(request.getParameter("phon_num"));
            us.setImgProfile(request.getParameter("image"));

            // แก้ studentId และ yearOfStudy
            stu.setStudentId(request.getParameter("student_id"));
            stu.setYearOfStudy(request.getParameter("yfs"));

            // เรียก update
            tmg.updateRegister(us);
            tmg.updateStudent(stu); // จะต้องใช้ session ใหม่หรือ merge ก็ได้

            ModelAndView mav = new ModelAndView("ViewProfile");
            mav.addObject("edit", "แก้ไขข้อมูลสำเร็จ");
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("EditProfile");
            mav.addObject("error_edit", "ไม่สามารถแก้ไขข้อมูลได้");
            return mav;
        }
    }

}
