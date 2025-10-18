<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>คอร์สที่ลงทะเบียน</title>
<style>
    body {
        background-color: #f7f9fc;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
    }

    /* Header */
    .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 20px 40px;
        background-color: #ffffff;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 10;
    }
    .header h2 {
        margin: 0;
        color: #009639;
        font-weight: 700;
        letter-spacing: 0.5px;
    }

    /* Layout */
    .main-content {
        display: flex;
        max-width: 1100px;
        margin: 40px auto;
        gap: 30px;
    }

    .left-container {
        flex: 0 0 200px;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        padding: 25px;
        text-align: center;
    }

    .left-container a {
        display: block;
        background-color: #009639;
        color: white;
        text-decoration: none;
        border-radius: 25px;
        padding: 10px 0;
        font-weight: 600;
        transition: background-color 0.3s, transform 0.2s;
    }

    .left-container a:hover {
        background-color: #007a2f;
        transform: scale(1.03);
    }

    .right-container {
        flex: 1;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 25px 30px;
    }

    .msg {
        color: #e74c3c;
        font-weight: bold;
        margin-bottom: 15px;
        text-align: center;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 10px;
        overflow: hidden;
    }

    th, td {
        padding: 14px 16px;
        text-align: left;
    }

    th {
        background-color: #009639;
        color: #fff;
        font-size: 15px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #eafbea;
    }

    td {
        color: #333;
        vertical-align: middle;
    }

    /* ปุ่มดูรายละเอียด */
    .btn_view {
        display: inline-block;
        background-color: #009639;
        color: white;
        padding: 8px 16px;
        border-radius: 25px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        text-align: center;
        transition: background-color 0.3s, transform 0.2s;
    }

    .btn_view:hover {
        background-color: #007a2f;
        transform: translateY(-2px);
    }

    /* Empty message */
    .no-course {
        text-align: center;
        color: #555;
        font-size: 16px;
        margin-top: 20px;
    }

</style>
</head>
<body>

    <div class="header">
        <h2>📚 คอร์สที่ลงทะเบียน</h2>
    </div>

    <div class="main-content">
        <div class="left-container">
            <a href="goHome">🏠 กลับหน้า Home</a>
        </div>

        <div class="right-container">
            <p class="msg">${err_result_cancel}</p>
            <c:if test="${empty registerCourses}">
                <p class="no-course">คุณยังไม่ได้ลงทะเบียนคอร์สใดในขณะนี้</p>
            </c:if>

            <c:if test="${not empty registerCourses}">
                <table>
                    <tr>
                        <th>ชื่อคอร์ส</th>
                        <th>ชื่อผู้สอน</th>
                        <th>ราคา</th>
                        <th>รายละเอียด</th>
                    </tr>
                    <c:forEach var="rc" items="${registerCourses}">
                        <tr>
                            <td>${rc.course.courseName}</td>
                            <td>${rc.course.tutor.user.firstName} ${rc.course.tutor.user.lastName}</td>
                            <td>${rc.course.coursePrice} บาท</td>
                            <td><a href="getViewRegisterCourse?registerId=${rc.registerCourseId}" class="btn_view">ดูรายละเอียด</a></td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </div>
    </div>

</body>
</html>
