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
            background: #f5f7fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 30px;
            text-align: center;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #4CAF50;
            margin-bottom: 15px;
        }
        .links a {
            display: inline-block;
            margin: 8px;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            background: #4CAF50;
            transition: 0.3s;
        }
        .links a:hover {
            background: #45a049;
        }
        .info {
            text-align: left;
            margin-top: 20px;
            line-height: 1.8;
            font-size: 15px;
        }
        .info p {
            margin: 6px 0;
        }
        #editMessage {
            margin-top: 10px;
            font-weight: bold;
            color: green;
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
            <p>เงินคงเหลือปัจจุบัน: <strong>${balance}</strong> บาท</p>
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
