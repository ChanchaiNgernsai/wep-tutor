<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Tutor Course</title>
<style>
    body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 20px;
    }

    h1, h2 {
        color: #333;
    }

    a {
        text-decoration: none;
        color: #007bff;
        margin-right: 15px;
    }

    a:hover {
        text-decoration: underline;
    }

    .container {
        max-width: 900px;
        margin: auto;
        background-color: #fff;
        padding: 25px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        border-radius: 10px;
    }

    .profile {
        display: flex;
        align-items: center;
        gap: 20px;
        margin-bottom: 20px;
    }

    .profile-img {
        width: 100px;         
        height: 100px;
        border-radius: 50%;     
        border: 2px solid #ccc;
        object-fit: cover;     
    }


    .profile-details p, .course-details p {
        margin: 5px 0;
        line-height: 1.5;
    }

    .course-details {
        margin-top: 20px;
    }

    .actions {
        margin-top: 25px;
    }

    .actions a {
        padding: 8px 15px;
        background-color: #007bff;
        color: white;
        border-radius: 5px;
    }

    .actions a:hover {
        background-color: #0056b3;
    }

</style>
</head>
<body>
    <div class="container">
        <h1>รายละเอียดคอร์สผู้สอน</h1>
        <a href="goHome">กลับหน้า Home</a>

        <h2>ผู้สอน</h2>
        <div class="profile">
            <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}"  alt="รูปโปรไฟล์ผู้สอน">
            <div class="profile-details">
                <p><strong>ชื่อ-นามสกุล:</strong> ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
                <p><strong>เพศ:</strong> ${course.tutor.user.gender}</p>
                <p><strong>เบอร์โทรศัพท์:</strong> ${course.tutor.user.phoneNumber}</p>
                <p><strong>ประสบการณ์:</strong> ${course.tutor.expertise}</p>
            </div>
        </div>

        <div class="course-details">
            <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
            <p><strong>รายละเอียด:</strong> ${course.courseDescription}</p>
            <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
            <p><strong>ประเภท:</strong> ${course.category.categoryName}</p>
        </div>

        <div class="actions">
            <a href="getListStudentCourse?id=${course.courseId}">รายชื่อทั้งหมด</a>
            <a href="goWithdraw">ถอนเงิน</a>
        </div>
    </div>
</body>
</html>
