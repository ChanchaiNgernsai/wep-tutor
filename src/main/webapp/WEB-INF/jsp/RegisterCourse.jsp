<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Course</title>
<style>
    body {
        background-color: #f0f2f5;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 900px;
        margin: 30px auto;
        background: #fff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    h1 {
        text-align: center;
        color: #333;
    }

    a {
        color: #007bff;
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }

    hr {
        margin: 20px 0;
        border: 0;
        border-top: 1px solid #ddd;
    }

    .section-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 10px;
        color: #444;
    }

    .info p {
        margin: 6px 0;
        color: #555;
    }

    .err-message {
        color: red;
        font-style: italic;
        margin-bottom: 10px;
    }

    form {
        margin-top: 20px;
        padding: 15px;
        background: #fafafa;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    input[type="checkbox"] {
        margin-right: 8px;
    }

    input[type="submit"] {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        border-radius: 8px;
        cursor: pointer;
        transition: 0.3s;
    }

    input[type="submit"]:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }

    input[type="submit"]:hover:not(:disabled) {
        background-color: #218838;
    }

    ul {
        margin: 0;
        padding-left: 20px;
    }

</style>

<script>
    function toggleSubmit() {
        const checkbox = document.getElementById("agree");
        const submitBtn = document.getElementById("submitBtn");
        submitBtn.disabled = !checkbox.checked;
    }

    function checkBalance() {
        const balance = parseFloat('${balance}');
        const coursePrice = parseFloat('${course.coursePrice}');
        if(balance < coursePrice) {
            alert('ยอดเงินไม่เพียงพอ กรุณาเติมเงินก่อนลงทะเบียน');
            return false;
        }
        return true;
    }
</script>
</head>
<body>
<div class="container">
    <h1>ลงทะเบียนคอร์ส</h1>
    <a href="goHome">กลับหน้า Home</a>
    
    <c:if test="${not empty err_result}">
        <p class="err-message">${err_result}</p>
    </c:if>
    <c:if test="${not empty err_money}">
        <p class="err-message">${err_money}</p>
    </c:if>
    <c:if test="${not empty err_maxstu}">
        <p class="err-message">${err_maxstu}</p>
    </c:if>
    <c:if test="${not empty err_registerCourse}">
        <p class="err-message">${err_registerCourse}</p>
    </c:if>

    <hr>
    <div class="info">
        <div class="section-title">ข้อมูลผู้ลงทะเบียน</div>
        <p>ชื่อ-นามสกุล: ${User.firstName} ${User.lastName}</p>
        <p>เงินคงเหลือ: ${balance} บาท</p>
        <a href="goDeposit">เติมเงิน</a>
    </div>

    <hr>
    <div class="info">
        <div class="section-title">ข้อมูลคอร์ส</div>
        <p>ชื่อผู้สอน: ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
        <p>ชื่อคอร์ส: ${course.courseName}</p>
        <p>ราคา: ${course.coursePrice} บาท</p>
        <p>จำนวนผู้เรียนสูงสุด: ${course.maxStudents} คน</p>

        <c:if test="${not empty course.courseDates}">
            <div class="section-title">วันเวลาเรียน</div>
            <ul>
                <c:forEach var="cd" items="${course.courseDates}">
                    <li>${cd.class_date} เวลา ${cd.startTime} - ${cd.endTime} น.</li>
                </c:forEach>
            </ul>
        </c:if>
    </div>

    <form action="addRegisterCourse" method="post" onsubmit="return checkBalance();">
        <input type="hidden" name="courseId" value="${course.courseId}" />

        <input type="checkbox" id="agree" name="agree" onclick="toggleSubmit()">
        <label for="agree">ยอมรับเงื่อนไขการลงทะเบียน ไม่มีการคืนเงินย้อนหลัง</label><br><br>

        <input type="submit" id="submitBtn" value="ชำระเงิน & ลงทะเบียน" disabled>
    </form>
</div>
</body>
</html>
