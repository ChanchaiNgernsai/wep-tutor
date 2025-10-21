package com.springmvc.Controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Student;
import com.springmvc.model.TutorManager;
import com.springmvc.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProfileController {

    @Autowired
    private MessageSource messageSource;

    // @RequestMapping(value = "/goProfile", method = RequestMethod.GET)
    // public String loadProfilePage() {

    // return "ViewProfile";
    // }

    @RequestMapping(value = "/goProfile", method = RequestMethod.GET)
    public ModelAndView loadDepositPage(HttpSession session) {
        User user = (User) session.getAttribute("User");
        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนเข้าหน้าฝากเงิน");
            return mav;
        }

        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalanceByStudent(user.getEmail());
        session.setAttribute("balance", balance);

        ModelAndView mav = new ModelAndView("ViewProfile");
        mav.addObject("balance", balance);
        return mav;
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
    public ModelAndView loadeditProfilePage(@RequestParam("image") MultipartFile imageFile,
            HttpServletRequest request, HttpSession session) { // เพิ่ม HttpSession เข้ามา
        TutorManager tmg = new TutorManager();
        String email = request.getParameter("email");

        User us = tmg.getRegisterByEmail(email);
        Student stu = tmg.getStudentByEmail(email);

        if (us != null && stu != null) {
            us.setFirstName(request.getParameter("fname"));
            us.setLastName(request.getParameter("lname"));
            us.setPhoneNumber(request.getParameter("phon_num"));

            try {
                if (!imageFile.isEmpty()) {
                    us.setImgProfile(imageFile.getBytes());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            stu.setStudentId(request.getParameter("student_id"));
            stu.setYearOfStudy(request.getParameter("yfs"));

            tmg.updateRegister(us);
            tmg.updateStudent(stu);

            double balance = tmg.getBalanceByStudent(us.getEmail());
            session.setAttribute("balance", balance);

            ModelAndView mav = new ModelAndView("ViewProfile");
            mav.addObject("edit", messageSource.getMessage("edit", null, Locale.forLanguageTag("th-TH")));
            mav.addObject("User", us);
            mav.addObject("Stu", stu);
            mav.addObject("balance", balance);
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("EditProfile");
            mav.addObject("error_edit", messageSource.getMessage("err_edit", null, Locale.forLanguageTag("th-TH")));
            return mav;
        }
    }

}
