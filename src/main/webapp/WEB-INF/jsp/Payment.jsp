<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    .actions {
        max-width: 600px;
        margin: 15px auto;
        text-align: right;
    }
    .actions a, .actions button {
        background-color: #0288d1;
        color: #fff;
        border: none;
        padding: 8px 16px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
        margin-left: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .actions a:hover, .actions button:hover {
        background-color: #01579b;
    }

    /* ซ่อนปุ่มเวลา Print */
    @media print {
        .actions {
            display: none;
        }
        body {
            background-color: #fff;
        }
    }
</style>
</head>
<body>
    <div class="receipt">
        <h1>ใบเสร็จรับเงิน</h1>

        <p style="color: green; text-align: center;">${result_registerCourse}</p>

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

    <div class="actions">
        <a href="goHome">กลับหน้า Home</a>
        <button onclick="window.print()">🖨️ พิมพ์ใบเสร็จ</button>
    </div>
</body>
</html>
