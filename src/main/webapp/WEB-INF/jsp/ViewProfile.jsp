<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>View Profile</title>
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            max-width: 700px;
            width: 100%;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            padding: 40px 50px;
            text-align: center;
        }
        .profile-img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ff6a88;
            margin-bottom: 20px;
        }
        .links a {
            display: inline-block;
            margin: 10px 8px;
            padding: 10px 20px;
            border-radius: 12px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(135deg, #42e695, #3bb2b8);
            font-weight: 600;
            transition: 0.3s;
        }
        .links a:hover {
            opacity: 0.9;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        #editMessage {
            margin-top: 15px;
            font-weight: bold;
            color: #4CAF50;
            font-size: 1rem;
        }
        .info {
            text-align: left;
            margin-top: 30px;
            line-height: 1.8;
            font-size: 1rem;
        }
        .info p {
            margin: 8px 0;
        }
        .info strong {
            color: #ff6a88;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="getUserImage?email=${User.email}" class="profile-img"/><br>
        
        <div class="links">
            <a href="goHome">🏠 กลับหน้า Home</a>
            <a href="getRegister?id=${User.email}">✏️ แก้ไขโปรไฟล์</a>
        </div>

        <div id="editMessage">${edit}</div>

        <div class="info">
            <p><strong>เงินคงเหลือปัจจุบัน:</strong> ${balance} บาท</p>
            <p><strong>อีเมล:</strong> ${User.email}</p>
            <p><strong>ชื่อ-นามสกุล:</strong> ${User.firstName} ${User.lastName}</p>
            <p><strong>รหัสนักศึกษา:</strong> ${Stu.studentId}</p>
            <p><strong>ชั้นปี:</strong> ${Stu.yearOfStudy}</p>
            <p><strong>เพศ:</strong> ${User.gender}</p>
            <p><strong>เบอร์โทรศัพท์:</strong> ${User.phoneNumber}</p>
        </div>
    </div>

<script>
    const editDiv = document.getElementById('editMessage');
    if(editDiv && editDiv.innerText.trim() !== "") {
        setTimeout(() => {
            editDiv.style.display = "none";
        }, 10000); // 10 วินาที
    }
</script>
</body>
</html>
