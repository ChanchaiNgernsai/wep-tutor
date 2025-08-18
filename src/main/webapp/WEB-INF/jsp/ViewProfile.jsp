<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>View Profile</title>
</head>
<body>
    <img src="${User.imgProfile}" width="120" height="120" alt="รูปโปรไฟล์" /><br>
    <a href="goHome">กลับหน้า Home</a><br>
    <a href="getRegister?id=${User.email}">แก้ไขโปรไฟล์</a><br>

    <div id="editMessage" style="color:green;">${edit}</div>

    <p>จำนวนเงินของคุณ: ${User.balance}</p>
    <p>อีเมล: ${User.email}</p>
    <p>ชื่อ-นามสกุล: ${User.firstName} ${User.lastName}</p>
    <p>รหัสนักศึกษา: ${Stu.studentId}</p>
    <p>ชั้นปี: ${Stu.yearOfStudy} เพศ: ${User.gender}</p>
    <p>เบอร์โทรศัพท์: ${User.phoneNumber}</p>
    

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
