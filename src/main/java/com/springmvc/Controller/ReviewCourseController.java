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
    public ModelAndView loadReviewCoursePage(HttpSession session) {
        Student student = (Student) session.getAttribute("Stu");
        if (student == null) {
            return new ModelAndView("Login", "error", "กรุณาเข้าสู่ระบบก่อนรีวิวคอร์ส");
        }

        TutorManager tmg = new TutorManager();
        List<RegisterCourse> registerCourses = tmg.getRegisterCoursesByStudent(student);

        ModelAndView mav = new ModelAndView("ReviewCourse");
        mav.addObject("registerCourses", registerCourses);
        mav.addObject("student", student);
        mav.addObject("reviews", tmg.getAllReviews());
        return mav;
    }

    @RequestMapping(value = "/addReviewCourse", method = RequestMethod.POST)
    public ModelAndView addReviewCourse(HttpServletRequest request, HttpSession session) {
        Student student = (Student) session.getAttribute("Stu");
        TutorManager tmg = new TutorManager();

        List<ReviewCourse> reviews = tmg.getAllReviews();

        ModelAndView mav = new ModelAndView("ReviewCourse");
        mav.addObject("reviews", reviews); // ส่งรีวิวทั้งหมด

        if (student == null) {
            mav.addObject("err_result", "กรุณาเข้าสู่ระบบก่อนรีวิวคอร์ส");
            return mav;
        }

        // ส่ง student และ registerCourses กลับไปด้วย
        List<RegisterCourse> registerCourses = tmg.getRegisterCoursesByStudent(student);
        mav.addObject("student", student);
        mav.addObject("registerCourses", registerCourses);

        // เพิ่มรีวิว
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

        return mav;
    }

}
