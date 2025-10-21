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
<style>
  body {
    background: #f0f2f5;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 20px;
    color: #333;
  }

  a {
    text-decoration: none;
    font-weight: 600;
  }
  
  .container {
    max-width: 900px;
    margin: 20px auto;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    padding: 30px;
  }

  h2 {
    font-weight: 700;
    font-size: 1.8rem;
    margin-bottom: 20px;
    text-align: center;
    color: #ff6a88;
    border-bottom: 3px solid #42e695;
    padding-bottom: 8px;
  }

  .back-link {
    display: block;
    text-align: center;
    margin-bottom: 20px;
    color: #42e695;
  }

  .back-link:hover {
    color: #3bb2b8;
  }

  .course-item {
    background: #ffffff;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .course-item img.profile-img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #42e695;
    flex-shrink: 0;
  }

  .course-info {
    flex: 1;
  }

  .course-info p {
    margin: 6px 0;
    font-size: 1rem;
  }

  .course-info a {
    display: inline-block;
    margin-top: 10px;
    padding: 10px 20px;
    background: linear-gradient(135deg, #42e695, #3bb2b8);
    color: #fff;
    border-radius: 8px;
    font-weight: 700;
    transition: all 0.3s ease;
  }

  .course-info a:hover {
    opacity: 0.9;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  }

  .no-results {
    text-align: center;
    font-weight: 600;
    font-size: 1.1rem;
    color: #d32f2f;
    margin-top: 20px;
  }

</style>
</head>
<body>

  <div class="container">
    <h2>ผลการค้นหา: ${keyword}</h2>
    <a href="goHome" class="back-link">← กลับหน้า Home</a>

    <c:if test="${empty results}">
      <p class="no-results">ไม่พบผลลัพธ์</p>
    </c:if>

    <c:forEach var="course" items="${results}">
      <div class="course-item">
        <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" alt="Tutor Image">
        <div class="course-info">
          <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
          <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
          <a href="getViewCourse?id=${course.courseId}">ดูคอร์ส</a>
        </div>
      </div>
    </c:forEach>
  </div>

</body>
</html>
