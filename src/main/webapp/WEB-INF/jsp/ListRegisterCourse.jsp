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
        padding: 15px 40px;
        background-color: #007F3E;
        color: #fff;
        box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 10;
    }
    .header h2 {
        margin: 0;
        font-weight: 700;
        font-size: 1.6rem;
        letter-spacing: 0.5px;
    }

    /* Layout */
    .main-content {
        display: flex;
        max-width: 1000px;
        margin: 30px auto;
        gap: 25px;
        flex-wrap: wrap;
    }

    .left-container {
        flex: 0 0 200px;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        padding: 20px;
        text-align: center;
        height: fit-content;
    }

    .left-container a {
        display: block;
        background-color: #007F3E;
        color: #fff;
        text-decoration: none;
        border-radius: 25px;
        padding: 10px 0;
        font-weight: 600;
        margin-bottom: 10px;
        transition: all 0.3s ease;
    }

    .left-container a:hover {
        background-color: #005f2e;
        transform: translateY(-2px);
    }

    .right-container {
        flex: 1;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        padding: 25px 30px;
        overflow-x: auto;
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
        font-size: 0.95rem;
    }

    th, td {
        padding: 12px 15px;
        text-align: left;
    }

    th {
        background-color: #007F3E;
        color: #fff;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    tr:nth-child(even) {
        background-color: #f7f9fc;
    }

    tr:hover {
        background-color: #e0f2e9;
    }

    td {
        color: #333;
        vertical-align: middle;
    }

    /* ปุ่มดูรายละเอียด */
    .btn_view {
        display: inline-block;
        background-color: #007F3E;
        color: white;
        padding: 6px 14px;
        border-radius: 25px;
        font-size: 0.9rem;
        font-weight: 600;
        text-decoration: none;
        text-align: center;
        transition: all 0.3s ease;
    }

    .btn_view:hover {
        background-color: #005f2e;
        transform: translateY(-2px);
    }

    /* Empty message */
    .no-course {
        text-align: center;
        color: #555;
        font-size: 16px;
        margin-top: 20px;
    }
    /* ปุ่มลิงก์ทั่วไป */
.link-btn {
    display: inline-block;
    background-color: #007F3E;
    color: white;
    padding: 8px 18px;
    border-radius: 25px;
    font-size: 0.95rem;
    font-weight: 600;
    text-decoration: none;
    margin-right: 10px;
    transition: all 0.3s ease;
}

.link-btn:hover {
    background-color: #005f2e;
    transform: translateY(-2px);
}

/* ปรับให้ container ลิงก์เรียงตัวแนวนอน */
.action-links {
    margin: 15px 0;
}


    @media (max-width: 768px) {
        .main-content { flex-direction: column; margin: 20px; gap: 15px; }
        .left-container { flex: 1; }
        .right-container { flex: 1; }
    }
</style>
</head>
<body>

    <div class="header">
        <h2> คอร์สที่ลงทะเบียน</h2>
    </div>

    <div class="main-content">

        <div class="right-container">
             <h2>คอร์สที่ลงทะเบียน</h2>
            <div class="action-links">
            <a href="goHome" class="link-btn">← กลับหน้า Home</a>
        </div>
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
