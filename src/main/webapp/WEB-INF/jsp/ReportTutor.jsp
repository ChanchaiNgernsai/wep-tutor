<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Tutor</title>


</head>
<body>
    <a href="goHome">กลับหน้า Home</a>
    <h2>รายงานผู้สอน</h2>

    <p class="error-msg">${err_report}</p>
    
    <img src="getUserImage?email=${course.tutor.user.email}" alt="Tutor Image" width="150" height="150"><br>
    ผู้สอน: ${course.tutor.user.firstName} ${course.tutor.user.lastName} <br>
    คอร์สที่รายงาน: ${course.courseName} <br>
    คำอธิบายคอร์ส: ${course.courseDescription} <br>
    ราคาคอร์ส: ${course.coursePrice} บาท <br><br>
    <p><strong>วันที่สอน:</strong></p>
        <ul>
            <c:forEach var="cd" items="${course.courseDates}">
                <li>
                    ${cd.class_date} เวลา ${cd.startTime} - ${cd.endTime} (หัวข้อ: ${cd.topic})
                </li>
            </c:forEach>
        </ul>


    <form action="addReportTutor" method="post">
        <input type="hidden" name="courseId" value="${course.courseId}" />
        <label for="details">รายละเอียดรายงานผู้สอน:</label><br>
        <textarea id="details" name="details" rows="4" cols="50" required></textarea><br><br>
        <input type="cancel" value="ยกเลิก">
        <input type="submit" value="ส่งรายงาน">
       
    </form>



</body>
</html>
