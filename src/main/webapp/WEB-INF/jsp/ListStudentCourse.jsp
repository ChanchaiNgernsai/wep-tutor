<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายชื่อนักเรียนที่ลงทะเบียนคอร์ส</title>
<style>
    /* รีเซ็ต margin/padding เพื่อให้ header ชิดบนสุด */
    html, body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f2f5;
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
        font-size: 1.5rem; /* ตัวหนังสือใหญ่ */
    }

    .header a:hover {
        color: #e0e0e0;
    }

    .container {
        max-width: 900px;
        margin: 20px auto;
        padding: 20px 30px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    h1 {
        text-align: center;
        color: #007F3E;
        margin-bottom: 10px;
    }

    h2 {
        text-align: center;
        color: #007F3E;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background: #fff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    table th, table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }

    table th {
        background-color: #007F3E;
        color: white;
    }

    .status-pending {
        color: #e67e22;
        font-weight: bold;
    }

    .status-confirm {
        color: #2e7d32;
        font-weight: bold;
    }

    a.btn-back {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
        color: white;
        background: #007F3E;
        padding: 8px 15px;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    a.btn-back:hover {
        background: #005f2e;
    }

    p.result-msg {
        text-align: center;
        color: #2e7d32;
        font-weight: bold;
        margin-top: 15px;
    }

    @media (max-width: 600px) {
        .container {
            padding: 15px 20px;
        }
        table th, table td {
            padding: 8px;
            font-size: 0.9rem;
        }
        .header a {
            font-size: 1.3rem;
        }
    }
</style>
</head>
<body>

    <div class="header">
        <a href="goHome">รายชื่อนักเรียนที่ลงทะเบียนคอร์ส</a>
    </div>

    <div class="container">
        <h1>รายชื่อนักเรียนที่ลงทะเบียนคอร์ส</h1>
        <h2>คอร์ส: ${course.courseName}</h2>

        <c:if test="${not empty result_confirm}">
            <p class="result-msg">${result_confirm}</p>
        </c:if>

        <c:if test="${empty students}">
            <p style="text-align:center; color:#555;">ยังไม่มีนักเรียนลงทะเบียนในคอร์สนี้</p>
        </c:if>

        <c:if test="${not empty registerCourses}">
        <table>
            <tr>
                <th>ลำดับ</th>
                <th>ชื่อ-นามสกุล</th>
                <th>เบอร์โทรศัพท์</th>
                <th>สถานะ</th>
            </tr>
            <c:forEach var="rc" items="${registerCourses}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${rc.student.user.firstName} ${rc.student.user.lastName}</td>
                    <td>${rc.student.user.phoneNumber}</td>
                    <td>
                        <c:choose>
                            <c:when test="${rc.regisStatus == 0}">
                                <span class="status-pending">รอยืนยัน</span>
                            </c:when>
                            <c:when test="${rc.regisStatus == 1}">
                                <span class="status-confirm">ยืนยันแล้ว</span>
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </c:if>

        <a class="btn-back" href="getViewTutorCourse?id=${course.courseId}">⬅ กลับไปหน้าคอร์ส</a>
    </div>

</body>
</html>
