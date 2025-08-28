<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Course</title>
</head>
<body>
	<h1>Register Course</h1>
	<a href="goHome">กลับหน้า Home</a><br>
	
	<h2>Register Course</h2>
	

		<p style="color:red;">${err_result}</p>
	
	<strong>ผู้ลงทะเบียน</strong>
	<p>ชื่อ-นามสกุล: ${User.firstName}-${User.lastName} </p>
	<hr>
	 
	<strong>ชื่อผู้สอน</strong>
	<p>ชื่อ-นามสกุล: ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
	<p>ชื่อคอร์ส: ${course.courseName}</p>
	<p>ราคา: ${course.coursePrice}</p>

	<form action="addRegisterCourse" method="post">
		<input type="hidden" name="courseId" value="${course.courseId}" />
		<input type="submit" value="ลงทะเบียน" />
	</form>

</body>
</html>