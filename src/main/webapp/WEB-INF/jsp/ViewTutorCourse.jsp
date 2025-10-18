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
        background: linear-gradient(135deg, #e3f2fd, #ffffff);
        margin: 0;
        padding: 40px;
        color: #333;
    }

    .container {
        max-width: 900px;
        margin: auto;
        background-color: #fff;
        padding: 30px 40px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        border-radius: 15px;
        transition: 0.3s;
    }

    .container:hover {
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }

    h1 {
        text-align: center;
        color: #1565c0;
        font-size: 2rem;
        margin-bottom: 30px;
    }

    h2 {
        color: #1e88e5;
        border-left: 6px solid #1e88e5;
        padding-left: 10px;
        margin-top: 30px;
        margin-bottom: 15px;
    }

    a {
        text-decoration: none;
        color: #1e88e5;
        font-weight: bold;
        transition: 0.3s;
    }

    a:hover {
        color: #0d47a1;
        text-decoration: underline;
    }

    .back-link {
        display: inline-block;
        margin-bottom: 15px;
        color: #1e88e5;
        font-weight: bold;
    }

    .profile {
        display: flex;
        align-items: center;
        gap: 25px;
        margin-bottom: 25px;
    }

    .profile-img {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        border: 3px solid #1e88e5;
        object-fit: cover;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }

    .profile-details p {
        margin: 6px 0;
        line-height: 1.6;
        font-size: 1rem;
    }

    .profile-details strong {
        color: #0d47a1;
    }

    .course-details {
        background-color: #f7f9fc;
        padding: 20px;
        border-radius: 10px;
        border-left: 5px solid #64b5f6;
        margin-top: 10px;
    }

    .course-details p {
        margin: 8px 0;
        font-size: 1rem;
        color: #444;
    }

    .course-details strong {
        color: #1e88e5;
    }

    .actions {
        margin-top: 25px;
        text-align: right;
    }

    .actions a {
        padding: 10px 20px;
        background-color: #1e88e5;
        color: white;
        border-radius: 8px;
        font-weight: bold;
        font-size: 0.95rem;
        transition: 0.3s;
    }

    .actions a:hover {
        background-color: #1565c0;
        transform: translateY(-2px);
    }

    /* Responsive */
    @media (max-width: 700px) {
        .profile {
            flex-direction: column;
            align-items: flex-start;
        }
        .profile-img {
            width: 100px;
            height: 100px;
        }
        .container {
            padding: 20px;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <a href="goHome" class="back-link">⬅ กลับหน้า Home</a>
        <h1>📘 รายละเอียดคอร์สผู้สอน</h1>

        <h2>👩‍🏫 ข้อมูลผู้สอน</h2>
        <div class="profile">
            <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" alt="รูปโปรไฟล์ผู้สอน">
            <div class="profile-details">
                <p><strong>ชื่อ-นามสกุล:</strong> ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
                <p><strong>เพศ:</strong> ${course.tutor.user.gender}</p>
                <p><strong>เบอร์โทรศัพท์:</strong> ${course.tutor.user.phoneNumber}</p>
                <p><strong>ประสบการณ์:</strong> ${course.tutor.expertise}</p>
            </div>
        </div>

        <h2>📚 ข้อมูลคอร์ส</h2>
        <div class="course-details">
            <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
            <p><strong>รายละเอียด:</strong> ${course.courseDescription}</p>
            <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
            <p><strong>ประเภท:</strong> ${course.category.categoryName}</p>
        </div>

        <div class="actions">
            <a href="getListStudentCourse?id=${course.courseId}">📋 รายชื่อนักเรียนทั้งหมด</a>
        </div>
    </div>
</body>
</html>
