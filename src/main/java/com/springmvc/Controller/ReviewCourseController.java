package com.springmvc.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Course;
import com.springmvc.model.RegisterCourse;
import com.springmvc.model.ReviewCourse;
import com.springmvc.model.Student;
import com.springmvc.model.TutorManager;

import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewCourseController {

    @RequestMapping(value = "/goReviewCourse", method = RequestMethod.GET)
    public ModelAndView loadReviewCoursePage(HttpServletRequest request, HttpSession session) {
        int courseId = Integer.parseInt(request.getParameter("id"));
        Student student = (Student) session.getAttribute("Stu");
        TutorManager tmg = new TutorManager();

        Course course = tmg.getCourseById(courseId);
        List<ReviewCourse> reviews = tmg.getReviewsByCourse(courseId);

        List<RegisterCourse> registerCourses = null;
        if (student != null) {
            registerCourses = tmg.getRegisterCoursesByStudent(student);
        }

        ModelAndView mav = new ModelAndView("ReviewCourse");
        mav.addObject("student", student);
        mav.addObject("registerCourses", registerCourses);
        mav.addObject("reviews", reviews);
        mav.addObject("course", course);
        return mav;
    }

    @RequestMapping(value = "/addReviewCourse", method = RequestMethod.POST)
    public ModelAndView addReviewCourse(HttpServletRequest request, HttpSession session) {
        Student student = (Student) session.getAttribute("Stu");
        TutorManager tmg = new TutorManager();
        ModelAndView mav = new ModelAndView("ReviewCourse");

        List<ReviewCourse> reviews = tmg.getAllReviews();
        mav.addObject("reviews", reviews);

        if (student == null) {
            mav.addObject("err_result", "กรุณาเข้าสู่ระบบก่อนรีวิวคอร์ส");
            return mav;
        }

        List<RegisterCourse> registerCourses = tmg.getRegisterCoursesByStudent(student);
        mav.addObject("student", student);
        mav.addObject("registerCourses", registerCourses);

        try {
            String comment = request.getParameter("comment");
            Double score = Double.valueOf(request.getParameter("score"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            Course course = tmg.getCourseById(courseId);

            ReviewCourse review = new ReviewCourse();
            review.setComment(comment);
            review.setScore(score);
            review.setReviewDate(new Date());
            review.setUser(student.getUser());
            review.setCourse(course);

            boolean result = tmg.addReviewCourse(review);
            if (result) {
                mav.addObject("resultReview", "บันทึกรีวิวสำเร็จ");
            } else {
                mav.addObject("err_result", "ไม่สามารถบันทึกได้");
            }
        } catch (Exception e) {
            mav.addObject("err_result", "เกิดข้อผิดพลาด กรุณาลองใหม่");
        }

        return mav;
    }
}
