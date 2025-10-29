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
import com.springmvc.model.CourseDate;
import com.springmvc.model.Report;
import com.springmvc.model.ReviewCourse;
import com.springmvc.model.Student;
import com.springmvc.model.Transaction;
import com.springmvc.model.Tutor;
import com.springmvc.model.TutorManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private MessageSource messageSource;

    @RequestMapping(value = "/getReportTutor", method = RequestMethod.GET)
    public ModelAndView getReportTutor(HttpServletRequest request) {
        int courseId = Integer.parseInt(request.getParameter("id"));
        TutorManager tmg = new TutorManager();
        Course course = tmg.getCourseById(courseId);

        List<Report> reports = tmg.getReportsByCourse(courseId);
        List<ReviewCourse> reviews = tmg.getReviewsByCourse(courseId);
        List<CourseDate> courseDates = course.getCourseDates();

        ModelAndView mav = new ModelAndView("ListReportTutor");
        mav.addObject("course", course);
        mav.addObject("reports", reports);
        mav.addObject("reviews", reviews);
        mav.addObject("courseDates", courseDates);

        return mav;
    }

    @RequestMapping(value = "/banTutor", method = RequestMethod.POST)
    public ModelAndView banTutor(HttpServletRequest request) {
        int tutorId = Integer.parseInt(request.getParameter("tutorId"));
        String banDescription = request.getParameter("banDescription");

        TutorManager tmg = new TutorManager();
        Tutor tutor = tmg.getTutorById(tutorId);
        if (tutor != null) {
            tutor.setBanStatus(0); // 1 = แบน
            tutor.setBanDescription(banDescription);
            tutor.setBanDate(new java.util.Date());

            boolean result = tmg.updateBanTutor(tutor);

            ModelAndView mav = new ModelAndView("redirect:/goListReport");
            if (result) {
                mav.addObject("result_ban",
                        messageSource.getMessage("result_ban", null, Locale.forLanguageTag("th-TH")));
            } else {
                mav.addObject("err_ban", messageSource.getMessage("err_ban", null, Locale.forLanguageTag("th-TH")));
            }
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("redirect:/goListReport");
            mav.addObject("err_noban", messageSource.getMessage("err_noban", null, Locale.forLanguageTag("th-TH")));
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
                mav.addObject("result_unban",
                        messageSource.getMessage("result_unban", null, Locale.forLanguageTag("th-TH")));
            } else {
                mav.addObject("err_unban", messageSource.getMessage("err_unban", null, Locale.forLanguageTag("th-TH")));
            }
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("redirect:/goListReport");
            mav.addObject("err_no_unban",
                    messageSource.getMessage("err_no_unban", null, Locale.forLanguageTag("th-TH")));
            return mav;
        }
    }

    @RequestMapping(value = "/goListRequesWithdraw", method = RequestMethod.GET)
    public ModelAndView loadListRequestWithdrawPage(HttpServletRequest request, HttpSession session) {
        TutorManager tmg = new TutorManager();
        List<Transaction> withdrawRequests = tmg.getAllWithdrawRequests();

        ModelAndView mav = new ModelAndView("ListRequesWithdraw");
        mav.addObject("withdrawRequests", withdrawRequests);
        return mav;
    }

    @RequestMapping(value = "/approveWithdraw", method = RequestMethod.POST)
    public ModelAndView approveWithdraw(HttpServletRequest request) {
        int tranId = Integer.parseInt(request.getParameter("tranId"));

        TutorManager tmg = new TutorManager();
        Transaction transaction = tmg.getTransactionById(tranId);

        if (transaction != null && transaction.getWithdrawStatus() == 1) { // 1 = รอดำเนินกาย
            transaction.setWithdrawStatus(2); // 2 = อนุมัติแล้ว
            tmg.updateWithdraw(transaction);
        }

        return new ModelAndView("redirect:/goListRequesWithdraw");
    }

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
}
