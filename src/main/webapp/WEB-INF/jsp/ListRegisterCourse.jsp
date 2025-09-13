<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>คอร์สที่ลงทะเบียน</title>
<style>
    body {
        background-color: #EBEBEB;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
    }
    .header {
        display: flex;
        align-items: center;
        padding: 20px;
        background-color: white;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .header img {
        margin-right: 15px;
    }
    .header h2 {
        margin: 0;
    }

    .main-content {
        display: flex;
        max-width: 900px;
        margin: 20px auto;
        justify-content: flex-start;
        padding-left: 20px;
    }
    .left-container {
        flex: 0 0 20%;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 20px;
        margin-right: 30px;
    }
    .right-container {
        flex: 1;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 20px;
    }

    .profile-img {
        border-radius: 50%;  
        object-fit: cover;   
        width: 120px;        
        height: 120px;       
        margin-bottom: 10px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #009639;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .btn_view {
        display: inline-block;
        width: 120px;
        text-align: center;
        padding: 8px 0;
        background-color: #009639;
        color: white;
        border-radius: 20px;
        font-weight: bold;
        text-decoration: none;
        transition: background-color 0.3s;
    }
    .btn_view:hover {
        background-color: #007a2f;
    }

    .msg {
        color: green;
        font-weight: bold;
    }

</style>
</head>
<body>

   
    <div class="header">
        <h2>คอร์สที่ลงทะเบียน</h2>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Left Container -->
        <div class="left-container">
              <a href="goHome" > กลับหน้า Home</a>
        </div>

        <!-- Right Container -->
        <div class="right-container">
            <p class="msg">${err_result_cancel}</p>

            <c:if test="${empty registerCourses}">
                <p>คุณยังไม่ได้ลงทะเบียนคอร์สใด</p>
            </c:if>

            <c:if test="${not empty registerCourses}">
                <table>
                    <tr>
                        <th>ชื่อคอร์ส</th>
                        <th>ชื่อผู้สอน</th>
                        <th>ราคา</th>
                        <th>รายละเอียดคอร์ส</th>

                    </tr>
                    <c:forEach var="rc" items="${registerCourses}">
                        <tr>
                            <td>${rc.course.courseName}</td>
                            <td>${rc.course.tutor.user.firstName} ${rc.course.tutor.user.lastName}</td>
                            <td>${rc.course.coursePrice} บาท</td>
                            <td>
                                <a href="getViewRegisterCourse?registerId=${rc.registerCourseId}" class="btn_view">ดูรายละเอียด</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </div>
    </div>
</body>
</html>
