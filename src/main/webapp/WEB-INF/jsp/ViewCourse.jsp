<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Course</title>
<style>
    body {
        background-color: #f9fafb;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 20px;
        color: #333;
    }

    a {
        color: #2CC06C;
        text-decoration: none;
        font-weight: 600;
    }
    a:hover {
        color: #2853B8;
    }

    .container {
        max-width: 900px;
        margin: 20px auto;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        padding: 30px 40px;
    }

    h1 {
        font-weight: 700;
        margin-bottom: 25px;
        color: #2C3E50;
        border-bottom: 3px solid #2CC06C;
        padding-bottom: 8px;
    }

    .back-link {
        display: inline-block;
        margin-bottom: 25px;
        font-size: 14px;
    }

    .course-content {
        display: flex;
        gap: 40px;
        flex-wrap: wrap;
    }

    .tutor-info, .course-info {
        flex: 1 1 400px;
        background-color: #EBEBEB;
        padding: 20px;
        border-radius: 12px;
        box-shadow: inset 0 0 8px #d0d0d0;
    }

    .profile-img {
        border-radius: 50%;
        object-fit: cover;
        width: 150px;
        height: 150px;
        margin-bottom: 20px;
        display: block;
        margin-left: auto;
        margin-right: auto;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    .section-title {
        font-size: 20px;
        font-weight: 700;
        margin-bottom: 15px;
        color: #2C3E50;
        text-align: center;
        border-bottom: 2px solid #2CC06C;
        padding-bottom: 6px;
    }

    p {
        font-size: 16px;
        line-height: 1.5;
        margin: 10px 0;
        color: #444;
    }

    .register-link {
        display: inline-block;
        margin-top: 30px;
        padding: 14px 28px;
        background-color: #2CC06C;
        color: white;
        border-radius: 8px;
        font-weight: 700;
        font-size: 18px;
        box-shadow: 0 6px 12px rgba(24, 197, 125, 0.5);
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
        text-align: center;
        width: 100%;
        max-width: 250px;
        margin-left: auto;
        margin-right: auto;
        cursor: pointer;
    }
    .register-link:hover {
        background-color: #e9f9ff;
        box-shadow: 0 8px 18px rgba(40,83,184,0.7);
    }

    hr {
        border: none;
        border-bottom: 1px solid #ccc;
        margin: 30px 0;
    }

</style>
</head>
<body>
    <div class="container">
        <h1>รายละเอียดคอร์ส</h1>
        <a href="goHome" class="back-link">← กลับหน้า Home</a>

        <div class="course-content">
            <div class="tutor-info">
                <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" >
                <div class="section-title">ผู้เปิดสอนคอร์สนี้</div>
                <p><strong>ชื่อ-นามสกุล:</strong> ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
                <p><strong>เพศ:</strong> ${course.tutor.user.gender}</p>
                <p><strong>เบอร์โทรศัพท์:</strong> ${course.tutor.user.phoneNumber}</p>
                <p><strong>ประสบการณ์:</strong> ${course.tutor.expertise}</p>
            </div>

            <div class="course-info">
                <div class="section-title">ข้อมูลคอร์ส</div>
                <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
                <p><strong>รายละเอียดของวิชา:</strong> ${course.courseDescription}</p>
                <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
                <p><strong>จำนวนนักศึกษาที่รับ:</strong> ${course.maxStudents} คน</p>
                <p><strong>ประเภท:</strong> ${course.category.categoryName}</p>

                <c:if test="${not empty sessionScope.User}">
                    <a href="getRegisterCourse?id=${course.courseId}" class="register-link">ลงทะเบียนเรียน</a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
