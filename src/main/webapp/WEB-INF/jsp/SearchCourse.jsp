<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ผลการค้นหา</title>
</head>
<body>
    <h2>ผลการค้นหา: ${keyword}</h2>
    <a href="goHome">กลับหน้า Home</a><br>

    <c:if test="${empty results}">
        <p>ไม่พบผลลัพธ์</p>
    </c:if>

    <c:forEach var="course" items="${results}">
        <p>ชื่อคอร์ส: ${course.courseName}</p>
        <p>ราคา: ${course.coursePrice}</p>
        <a href="getViewCourse?id=${course.courseId}">ดูคอร์ส</a>
        <hr/>
    </c:forEach>

</body>
</html>
