<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Receipt</title>
<style>
    body {
        font-family: "Arial", sans-serif;
        background-color: #f5f5f5;
        padding: 20px;
    }
    .receipt {
        max-width: 600px;
        margin: auto;
        background-color: #fff;
        border: 1px solid #ccc;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px #aaa;
    }
    .receipt h1 {
        text-align: center;
        color: #333;
    }
    .receipt table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .receipt table, .receipt th, .receipt td {
        border: 1px solid #ddd;
    }
    .receipt th, .receipt td {
        padding: 10px;
        text-align: left;
    }
    .total {
        font-weight: bold;
        text-align: right;
    }
    .footer {
        margin-top: 30px;
        text-align: center;
        color: #666;
        font-size: 14px;
    }
    .back-home {
    max-width: 600px;      /* ความกว้างเท่ากับใบเสร็จ */
    margin: 10px auto;     /* จัดให้อยู่กลางหน้า */
    text-align: right;     /* ชิดขวา */
    }

    .back-home a {
        text-decoration: none; /* ลบขีดเส้นใต้ */
        color: #0288d1;        /* สีฟ้า */
        font-weight: bold;
        transition: color 0.3s ease;
    }

    .back-home a:hover {
        color: #01579b;        /* สีเข้มขึ้นเวลาชี้เมาส์ */
    }

    
</style>
</head>
<body>
    <div class="receipt">
        <h1>ใบเสร็จรับเงิน</h1>

        <div class="back-home">
            <a href="goHome">กลับหน้า Home</a>
        </div>
        <p style="color: green; text-align: center;">${msg}</p>
        <p><strong>ผู้ลงทะเบียน:</strong> ${User.firstName} ${User.lastName}</p>
        <p><strong>อีเมล:</strong> ${User.email}</p>
        <table>
            <tr>
                <th>ชื่อคอร์ส</th>
                <td>${course.courseName}</td>
            </tr>
            <tr>
                <th>ชื่อผู้สอน</th>
                <td>${course.tutor.user.firstName} ${course.tutor.user.lastName}</td>
            </tr>
            <tr>
                <th>ราคา</th>
                <td>${payment.amount}</td>
            </tr>
            <tr>
                <th>สถานะการชำระเงิน</th>
                <td>
                    <c:choose>
                        <c:when test="${payment.paymentStatus == 0}">ชำระแล้ว</c:when>
                        <c:when test="${payment.paymentStatus == 1}">ยังไม่ชำระ</c:when>
                        <c:otherwise>ไม่ทราบสถานะ</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>วันที่ลงทะเบียน</th>
                <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy"/></td>
            </tr>
        </table>

        <p class="total">รวมชำระ: ${payment.amount} บาท</p>

        <div class="footer">
            ขอบคุณที่ใช้บริการ<br>
            ระบบช่วยติวในมหาวิทยาลัยแม่โจ้
        </div>
    </div>
</body>
</html>
