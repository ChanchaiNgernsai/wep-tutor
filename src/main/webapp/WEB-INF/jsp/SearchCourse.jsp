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
<style>
  body {
    background-color: #EBEBEB;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 20px;
  }
  
  a {
    color: #2CC06C;
    text-decoration: none;
    font-weight: bold;
  }
  
  a:hover {
    color: #2853B8;
  }
  
  .container {
    max-width: 900px;
    margin: 20px auto;
    background-color: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    padding: 20px;
  }
  
  h2 {
    font-weight: bold;
    margin-bottom: 15px;
  }
  
  .course-item {
    background-color: white;
    border-radius: 10px;
    padding: 15px;
    margin-bottom: 15px;
    box-shadow: 0 1px 5px rgba(0,0,0,0.1);
  }
  
  .course-item p {
    margin: 5px 0;
  }
  
  .course-item a {
    display: inline-block;
    margin-top: 10px;
    padding: 6px 12px;
    background-color: #2CC06C;
    color: white;
    border-radius: 8px;
    transition: background-color 0.3s;
  }
  
  .course-item a:hover {
    background-color: #2853B8;
  }
  
</style>

<body>
<body>

  <div class="container">
    <h2>ผลการค้นหา: ${keyword}</h2>
    <a href="goHome">กลับหน้า Home</a><br><br>

    <c:if test="${empty results}">
      <p>ไม่พบผลลัพธ์</p>
    </c:if>

    <c:forEach var="course" items="${results}">
      <div class="course-item">
        <p>ชื่อคอร์ส: ${course.courseName}</p>
        <p>ราคา: ${course.coursePrice}</p>
        <a href="getViewCourse?id=${course.courseId}">ดูคอร์ส</a>
      </div>
    </c:forEach>
  </div>
</body>

</body>
</html>
