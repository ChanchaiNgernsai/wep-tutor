package com.springmvc.Controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Course;
import com.springmvc.model.Report;
import com.springmvc.model.Student;
import com.springmvc.model.TutorManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReportTutorController {

    @Autowired
    private MessageSource messageSource;

    @RequestMapping(value = "/goListReport", method = RequestMethod.GET)
    public ModelAndView loadListReportPage(HttpServletRequest request, HttpSession session) {
        Student student = (Student) session.getAttribute("Stu");
        TutorManager tmg = new TutorManager();

        List<Report> reports = tmg.getAllReports();

        ModelAndView mav = new ModelAndView("ListReportTutor");
        mav.addObject("student", student);
        mav.addObject("reports", reports);

        return mav;
    }

    @RequestMapping(value = "/goReport", method = RequestMethod.GET)
    public ModelAndView loadReportPage(HttpServletRequest request, HttpSession session) {
        int courseId = Integer.parseInt(request.getParameter("id"));
        Student student = (Student) session.getAttribute("Stu");
        TutorManager tmg = new TutorManager();

        Course course = tmg.getCourseById(courseId);

        List<Report> reports = tmg.getReportsByCourse(courseId);

        ModelAndView mav = new ModelAndView("ReportTutor");
        mav.addObject("student", student);
        mav.addObject("course", course);
        mav.addObject("reports", reports);
        return mav;
    }

    @RequestMapping(value = "/addReportTutor", method = RequestMethod.POST)
    public ModelAndView addReportTutor(HttpServletRequest request, HttpSession session) {
        Student student = (Student) session.getAttribute("Stu");
        String details = request.getParameter("details");

        TutorManager tmg = new TutorManager();
        ModelAndView mav = new ModelAndView();

        if (student == null) {
            mav.setViewName("ReportTutor");
            mav.addObject("err_nullreport",
                    messageSource.getMessage("err_nullreport", null, Locale.forLanguageTag("th-TH")));
            return mav;
        }

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        Course course = tmg.getCourseById(courseId);

        Report report = new Report();
        report.setReportDescription(details);
        report.setReportDate(new java.util.Date());
        report.setStatus(0); // 0 = pending
        report.setReporter(student.getUser());
        report.setReported(course.getTutor());
        report.setCourse(course);

        boolean result = tmg.insertReport(report, student, course);
        if (result) {
            mav.setViewName("ReportTutor");
            mav.addObject("result_report",
                    messageSource.getMessage("result_report", null, Locale.forLanguageTag("th-TH")));
            mav.addObject("student", student);
            mav.addObject("course", course);
            mav.addObject("reports", tmg.getReportsByCourse(courseId));
            return mav;
        } else {
            mav.setViewName("ReportTutor");
            mav.addObject("err_report", messageSource.getMessage("err_report", null, Locale.forLanguageTag("th-TH")));
            return mav;
        }
    }

}
