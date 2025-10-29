<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>View Profile</title>
    <style>
        /* --- Reset & Base --- */
        body {
            font-family: "Prompt", Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
            color: #333;
        }
        a { text-decoration: none; color: inherit; }
        ul { list-style: none; padding: 0; margin: 0; }

        /* --- Header --- */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007F3E;
            color: white;
            padding: 12px 25px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }
        .header h1 {
            font-size: 26px;
            margin: 0;
            cursor: pointer;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .profile-img-header {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
        }

        /* --- Container --- */
        .container {
            max-width: 700px;
            width: 100%;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            padding: 40px 50px;
            margin: 25px auto;
            text-align: center;
        }

        /* --- Profile Image --- */
        .profile-img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #007F3E;
            margin-bottom: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        /* --- Buttons / Links --- */
        .links a {
            display: inline-block;
            margin: 10px 8px;
            padding: 10px 20px;
            border-radius: 12px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(135deg, #007F3E, #04d167);
            font-weight: 600;
            transition: 0.3s;
        }
        .links a:hover {
            opacity: 0.9;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        /* --- Messages --- */
        #editMessage {
            margin-top: 15px;
            font-weight: bold;
            color: #007F3E;
            font-size: 1rem;
            text-align: center;
        }

        /* --- Info Section --- */
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
            color: #007F3E;
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
    <a href="goHome"><h1>หน้าโปรไฟล์</h1></a>
    <c:if test="${not empty sessionScope.User}">
        <div class="user-info">
            <img src="getUserImage?email=${User.email}" class="profile-img-header" alt="รูปโปรไฟล์"/>
            <p>${User.firstName} ${User.lastName}</p>
        </div>
    </c:if>
</div>

<!-- Main Container -->
<div class="container">
    <img src="getUserImage?email=${User.email}" class="profile-img"/>

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
        setTimeout(() => { editDiv.style.display = "none"; }, 10000); // 10 วินาที
    }
</script>

</body>
</html>
