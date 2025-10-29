<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายละเอียดคอร์สผู้สอน</title>
<style>
     body {
        background-color: #f0f2f5;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        color: #333;
    }

    /* Header */
    .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background-color: #007F3E;
        color: white;
        padding: 15px 30px;
        box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        position: sticky;
        top: 0;
        z-index: 10;
    }

    .header a {
        color: white;
        text-decoration: none;
        font-weight: 700;
        font-size: 1.5rem;
    }

    .header a:hover {
        color: #e0e0e0;
    }

    .container {
        max-width: 900px;
        margin: 30px auto;
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
        color: #007F3E;
        font-size: 2rem;
        margin-bottom: 30px;
    }

    h2 {
        color: #007F3E;
        border-left: 6px solid #007F3E;
        padding-left: 10px;
        margin-top: 30px;
        margin-bottom: 15px;
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
        border: 3px solid #007F3E;
        object-fit: cover;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }

    .profile-details p {
        margin: 6px 0;
        line-height: 1.6;
        font-size: 1rem;
    }

    .profile-details strong {
        color: #007F3E;
    }

    .course-details {
        background-color: #f7f9fc;
        padding: 20px;
        border-radius: 10px;
        border-left: 5px solid #007F3E;
        margin-top: 10px;
    }

    .course-details p {
        margin: 8px 0;
        font-size: 1rem;
        color: #444;
    }

    .course-details strong {
        color: #007F3E;
    }

    .actions {
        margin-top: 25px;
        text-align: right;
    }

    .actions a {
        padding: 10px 20px;
        background-color: #007F3E;
        color: white;
        border-radius: 8px;
        font-weight: bold;
        font-size: 0.95rem;
        transition: 0.3s;
        text-decoration: none;
    }

    .actions a:hover {
        background-color: #005f2e;
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
    }
</style>
</head>
<body>

    <div class="header">
        <a href="goHome">รายละเอียดคอร์สผู้สอน</a>
    </div>

    <div class="container">
        <h1> รายละเอียดคอร์สผู้สอน</h1>

        <h2> ข้อมูลผู้สอน</h2>
        <div class="profile">
            <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" alt="รูปโปรไฟล์ผู้สอน">
            <div class="profile-details">
                <p><strong>ชื่อ-นามสกุล:</strong> ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
                <p><strong>เพศ:</strong> ${course.tutor.user.gender}</p>
                <p><strong>เบอร์โทรศัพท์:</strong> ${course.tutor.user.phoneNumber}</p>
                <p><strong>ประสบการณ์:</strong> ${course.tutor.expertise}</p>
            </div>
        </div>

        <h2> ข้อมูลคอร์ส</h2>
        <div class="course-details">
            <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
            <p><strong>รายละเอียด:</strong> ${course.courseDescription}</p>
            <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
            <p><strong>ประเภท:</strong> ${course.category.categoryName}</p>
        </div>

        <div class="actions">
            <a href="getListStudentCourse?id=${course.courseId}"> รายชื่อนักเรียนทั้งหมด</a>
        </div>
    </div>

</body>
</html>
