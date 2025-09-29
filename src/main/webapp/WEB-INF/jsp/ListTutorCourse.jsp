<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Tutor Course</title>
<style>
    body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 20px;
    }

    h1 {
        text-align: left;
        color: #333;
        margin-bottom: 30px;
    }

    a.back-link {
        display: inline-block;
        margin-bottom: 25px;
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }
    a.back-link:hover {
        text-decoration: underline;
    }

    .success-msg {
        color: green;
        text-align: center;
        margin-bottom: 20px;
        font-weight: bold;
        font-size: 1.1rem;
    }

    .courses-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
    }

    .course-card {
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        padding: 20px;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .course-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }

    .course-title {
        font-size: 1.4rem;
        font-weight: bold;
        color: #1e88e5;
        margin-bottom: 10px;
    }

    .course-category {
        font-size: 1rem;
        color: #555;
        margin-bottom: 15px;
    }

    .course-dates {
        font-size: 0.95rem;
        color: #444;
        margin-left: 10px;
        margin-bottom: 5px;
    }

    .course-actions {
        margin-top: 15px;
        text-align: left;
    }

    .course-actions a {
        text-decoration: none;
        background-color: #1e88e5;
        color: white;
        padding: 8px 15px;
        border-radius: 6px;
        font-weight: bold;
        transition: background-color 0.3s;
    }

    .course-actions a:hover {
        background-color: #1565c0;
    }

</style>
</head>
<body>
    <h1>รายการคอร์สผู้สอน</h1>
    <a href="goHome" class="back-link">⬅ กลับหน้า Home</a>

    <c:if test="${not empty result_addCourse}">
        <div class="success-msg">${result_addCourse}</div>
    </c:if>

    <div class="courses-container">
        <c:forEach var="course" items="${courses}">
            <div class="course-card">
                <div class="course-title">${course.courseName}</div>
                <div class="course-category">ประเภท: ${course.category.categoryName}</div>

                <c:forEach var="cd" items="${course.courseDates}">
                    <div class="course-dates">
                        วันที่: ${cd.class_date} เวลา: ${cd.startTime} - ${cd.endTime} (หัวข้อ: ${cd.topic})
                    </div>
                </c:forEach>

                <div class="course-actions">
                    <a href="getViewTutorCourse?id=${course.courseId}">ดูรายละเอียดคอร์ส</a>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
