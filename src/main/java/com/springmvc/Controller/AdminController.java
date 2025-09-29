package com.springmvc.Controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Course;
import com.springmvc.model.Report;
import com.springmvc.model.Tutor;
import com.springmvc.model.TutorManager;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminController {

    @RequestMapping(value = "/getReportTutor", method = RequestMethod.GET)
    public ModelAndView getReportTutor(HttpServletRequest request) {
        int courseId = Integer.parseInt(request.getParameter("id"));
        TutorManager tmg = new TutorManager();
        Course course = tmg.getCourseById(courseId);

        List<Report> reports = tmg.getReportsByCourse(courseId);

        ModelAndView mav = new ModelAndView("ListReportTutor");
        mav.addObject("course", course);
        mav.addObject("reports", reports);

        return mav;
    }

    @RequestMapping(value = "/banTutor", method = RequestMethod.POST)
    public ModelAndView banTutor(HttpServletRequest request) {
        int tutorId = Integer.parseInt(request.getParameter("tutorId"));
        String banDescription = request.getParameter("banDescription");

        TutorManager tmg = new TutorManager();
        Tutor tutor = tmg.getTutorById(tutorId);
        if (tutor != null) {
            tutor.setBanStatus(0); // 0 = แบน
            tutor.setBanDescription(banDescription);
            tutor.setBanDate(new java.util.Date());

            boolean result = tmg.updateBanTutor(tutor);

            ModelAndView mav = new ModelAndView("redirect:/goListReport");
            if (result) {
                mav.addObject("result_ban", "แบนผู้สอนสำเร็จ");
            } else {
                mav.addObject("err_ban", "ไม่สามารถบันทึกได้");
            }
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("redirect:/goListReport");
            mav.addObject("err_ban", "ไม่พบผู้สอน");
            return mav;
        }
    }

    @RequestMapping(value = "/unBanTutor", method = RequestMethod.POST)
    public ModelAndView unBanTutor(HttpServletRequest request) {
        int tutorId = Integer.parseInt(request.getParameter("tutorId"));

        TutorManager tmg = new TutorManager();
        Tutor tutor = tmg.getTutorById(tutorId);
        if (tutor != null) {
            tutor.setBanStatus(1); // 1 = ปลดแบน
            boolean result = tmg.updateBanTutor(tutor);

            ModelAndView mav = new ModelAndView("redirect:/goListReport");
            if (result) {
                mav.addObject("result_unban", "ปลดแบนผู้สอนสำเร็จ");
            } else {
                mav.addObject("err_unban", "ไม่สามารถบันทึกได้");
            }
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("redirect:/goListReport");
            mav.addObject("err_unban", "ไม่พบผู้สอน");
            return mav;
        }
    }

}
