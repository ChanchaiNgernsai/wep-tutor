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
    body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        margin: 20px;
        background-color: #f9f9f9;
    }
    h1, h2 {
        color: #333;
    }
    table {
        width: 80%;
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
        background-color: #f2f2f2;
    }
    a {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
        color: white;
        background: #007BFF;
        padding: 8px 15px;
        border-radius: 5px;
    }
    a:hover {
        background: #0056b3;
    }
</style>
</head>
<body>

    <h1>รายชื่อนักเรียนที่ลงทะเบียนคอร์ส</h1>
    <h2>คอร์ส: ${course.courseName}</h2>

    <c:if test="${empty students}">
        <p>ยังไม่มีนักเรียนลงทะเบียนในคอร์สนี้</p>
    </c:if>
    <p>${result_confirm}</p>

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


    <a href="getViewTutorCourse?id=${course.courseId}">⬅ กลับไปหน้าคอร์ส</a>

</body>
</html>
