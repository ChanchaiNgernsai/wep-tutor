<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Course</title>
</head>
<body>
			<h1>View Course</h1>
			 <a href="goHome">กลับหน้า Home</a><br>
			<hr>
			
			<img class="profile-img" src="${course.tutor.user.imgProfile}" width="220" height="120" alt="รูปโปรไฟล์">
			<br>
			<h2>ผู้เปิดสอนคอร์สนี้ </h2>
			<p>ชื่อ-นามสกุล:  ${course.tutor.user.firstName}-${course.tutor.user.lastName}   
			<p>เพศ:  ${course.tutor.user.gender}</p>
			<p>เบอร์โทรศัพท์:  ${course.tutor.user.phoneNumber}</p>
			
			<p>ประสบการณ์: ${course.tutor.expertise}</p>
				 
		 
		 
	        <p>ชื่อคอร์ส: ${course.courseName}</p>
       		<p>รายละเอียดของวิชา: ${course.courseDescription}</p>
       		<p>ราคา: ${course.coursePrice}</p>
       		<p>จำนวนนักศึกษาที่รับ: ${course.maxStudents}</p>
       		<p>ประเภท: ${course.category.categoryName}</p>
       		
       		<c:if test="${not empty sessionScope.User}">
       			<a href="goRegisterCourse?id=${course.courseId}">ลงทะเบียนเรียน</a>
       		</c:if>

</body>
</html>