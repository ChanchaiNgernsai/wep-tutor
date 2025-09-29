package com.springmvc.Controller;

import java.util.List;

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
            mav.addObject("err_report", "กรุณาเข้าสู่ระบบก่อนรายงานผู้สอน");
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
            mav.addObject("result_report", "รายงานผู้สอนสำเร็จ");
            mav.addObject("student", student);
            mav.addObject("course", course);
            mav.addObject("reports", tmg.getReportsByCourse(courseId));
            return mav;
        } else {
            mav.setViewName("ReportTutor");
            mav.addObject("err_report", "ไม่สามารถบันทึกได้");
            return mav;
        }
    }

}
