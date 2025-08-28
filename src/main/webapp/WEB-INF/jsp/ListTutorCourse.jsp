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

    h1, h2 {
        text-align: center;
        color: #333;
    }

    a {
        display: inline-block;
        margin-bottom: 15px;
        color: #007bff;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    .course-card {
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        padding: 20px;
        margin-bottom: 20px;
    }

    .course-title {
        font-size: 1.2rem;
        font-weight: bold;
        color: #1e88e5;
        margin-bottom: 10px;
    }

    .course-category {
        font-size: 1rem;
        color: #555;
        margin-bottom: 10px;
    }

    .course-dates {
        margin-left: 10px;
        margin-bottom: 5px;
    }

    .success-msg {
        color: green;
        text-align: center;
        margin-bottom: 20px;
        font-weight: bold;
    }

</style>
</head>
<body>
    <h1>List Tutor Course</h1>
    <a href="goHome">⬅ กลับหน้า Home</a>

    <c:if test="${not empty result_addCourse}">
        <div class="success-msg">${result_addCourse}</div>
    </c:if>

    <c:forEach var="course" items="${courses}">
        <div class="course-card">
            <div class="course-title">${course.courseName}</div>
            <div class="course-category">ประเภท: ${course.category.categoryName}</div>

            <c:forEach var="cd" items="${course.courseDates}">
                <div class="course-dates">
                    วันที่: ${cd.class_date} เวลา: ${cd.startTime} - ${cd.endTime}
                </div>
            </c:forEach>
            <p><a href="getViewTutorCourse?id=${course.courseId}">ดูรายละเอียดคอร์ส</a></p>
        </div>
    </c:forEach>

</body>
</html>
