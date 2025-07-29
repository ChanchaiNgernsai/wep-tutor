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
</head>
<body>
	<h1>List Tutor Course</h1>

	<h2>คอร์สที่คุณเปิดสอน</h2>
	<a href="goHome">กลับหน้า Home</a><br>
	<c:forEach var="course" items="${courses}">
    	<p>ชื่อวิชา: ${course.courseName} - ประเภท: ${course.category.categoryName}</p>

    	<c:forEach var="cd" items="${course.courseDates}">
        	<p>วันที่: ${cd.class_date} เวลา: ${cd.startTime} - ${cd.endTime}</p>
    	</c:forEach>

    	<hr>
	</c:forEach>



	
	

</body>
</html>