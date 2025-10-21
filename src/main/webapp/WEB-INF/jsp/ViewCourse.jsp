<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Course</title>
<style>
    body {
        background: #f0f2f5;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 20px;
        color: #333;
    }
    a {
        text-decoration: none;
        color: #42e695;
        font-weight: 600;
    }
    a:hover { color: #3bb2b8; }

    .container {
        max-width: 1000px;
        margin: 30px auto;
        padding: 30px 40px;
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }

    h1 {
        font-size: 2rem;
        font-weight: 700;
        color: #ff6a88;
        text-align: center;
        margin-bottom: 30px;
    }

    .back-link {
        display: block;
        margin-bottom: 20px;
        font-size: 14px;
        text-align: center;
    }

    .course-content {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 30px;
    }

    .card {
        background: #ffffff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .profile-img {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        display: block;
        margin: 0 auto 20px;
        border: 4px solid #42e695;
    }

    .section-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: #2C3E50;
        margin-bottom: 15px;
        text-align: center;
        border-bottom: 2px solid #42e695;
        padding-bottom: 6px;
    }

    p {
        font-size: 1rem;
        line-height: 1.6;
        margin: 8px 0;
        color: #444;
    }

    ul {
        padding-left: 20px;
    }

    .register-btn {
        display: inline-block;
        width: 100%;
        text-align: center;
        background: linear-gradient(135deg, #42e695, #3bb2b8);
        color: #fff;
        font-weight: 700;
        font-size: 1rem;
        padding: 12px 0;
        border-radius: 10px;
        margin-top: 20px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .register-btn:hover {
        opacity: 0.9;
        box-shadow: 0 6px 16px rgba(0,0,0,0.2);
    }

    .reviews {
        margin-top: 20px;
    }

    .review-box {
        background: #f7f9fa;
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 12px;
        box-shadow: inset 0 0 6px #e2e2e2;
    }

</style>
</head>
<body>

<div class="container">
    <h1>รายละเอียดคอร์ส</h1>
    <a href="goHome" class="back-link">← กลับหน้า Home</a>

    <div class="course-content">
        <!-- ผู้สอน -->
        <div class="card">
            <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" alt="Tutor Image">
            <div class="section-title">ผู้สอนคอร์สนี้</div>
            <p><strong>ชื่อ-นามสกุล:</strong> ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
            <p><strong>เพศ:</strong> ${course.tutor.user.gender}</p>
            <p><strong>เบอร์โทรศัพท์:</strong> ${course.tutor.user.phoneNumber}</p>
            <p><strong>ประสบการณ์:</strong> ${course.tutor.expertise}</p>
        </div>

        <!-- ข้อมูลคอร์ส -->
        <div class="card">
            <div class="section-title">ข้อมูลคอร์ส</div>
            <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
            <p><strong>รายละเอียด:</strong> ${course.courseDescription}</p>
            <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
            <p><strong>จำนวนนักศึกษา:</strong> ${course.maxStudents} คน</p>
            <p><strong>ประเภท:</strong> ${course.category.categoryName}</p>
            <p><strong>วันที่สอน:</strong></p>
            <ul>
                <c:forEach var="cd" items="${courseDates}">
                    <li>${cd.class_date} เวลา ${cd.startTime} - ${cd.endTime} (หัวข้อ: ${cd.topic})</li>
                </c:forEach>
            </ul>

            <c:if test="${not empty sessionScope.Stu and sessionScope.Stu.user.email ne course.tutor.user.email}">
                <c:choose>
                    <c:when test="${alreadyRegistered}">
                        <p style="color: gray; text-align: center; font-weight: bold;">คุณได้ลงทะเบียนคอร์สนี้แล้ว</p>
                    </c:when>
                    <c:when test="${!registrationOpen}">
                        <p style="color: red; text-align: center; font-weight: bold;">คอร์สนี้ปิดการลงทะเบียนแล้ว</p>
                    </c:when>
                    <c:otherwise>
                        <a href="getRegisterCourse?id=${course.courseId}" class="register-btn">ลงทะเบียนเรียน</a>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <!-- รีวิว -->
            <div class="reviews">
                <div class="section-title">รีวิวจากผู้เรียน</div>
                <c:if test="${not empty reviews}">
                    <c:forEach var="rev" items="${reviews}">
                        <div class="review-box">
                            <p><strong>${rev.user.firstName}:</strong> ${rev.comment}</p>
                            <p>คะแนน: ${rev.score}/5</p>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty reviews}">
                    <p style="text-align:center;">ยังไม่มีรีวิว</p>
                </c:if>
            </div>
        </div>
    </div>
</div>

</body>
</html>
