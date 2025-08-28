<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Register Course</title>
</head>
<body>
    <h1>คอร์สที่ลงทะเบียน</h1>
    <a href="goHome">กลับหน้า Home</a><br><br>

    <p style="color: green;">${err_result_cancel}</p>
    <c:if test="${empty registerCourses}">
        <p>คุณยังไม่ได้ลงทะเบียนคอร์สใด</p>
    </c:if>

    <c:if test="${not empty registerCourses}">
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>ชื่อคอร์ส</th>
                <th>ชื่อผู้สอน</th>
                <th>ราคา</th>
                <th>สถานะการชำระเงิน</th>
            </tr>
            <c:forEach var="rc" items="${registerCourses}">
                <tr>
                    <td>${rc.course.courseName}</td>
                    <td>${rc.course.tutor.user.firstName} ${rc.course.tutor.user.lastName}</td>
                    <td>${rc.course.coursePrice}</td>
                    <td>
                        <a href="getViewRegisterCourse?registerId=${rc.registerCourseId}">ดูรายที่ลงทะเบียน</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</body>
</html>
