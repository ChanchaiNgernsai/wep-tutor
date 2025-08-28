<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Register Course</title>
</head>
<script>
    function confirmCancel() {
        if (confirm("ระบบไม่มีการคืนเงินใด ๆ คุณต้องการยกเลิกคอร์สนี้หรือไม่?")) {
            document.getElementById("cancelForm").submit();
        }
}
</script>
<body>
    <h1>รายละเอียดการลงทะเบียนคอร์ส</h1>
    <a href="goHome">กลับหน้า Home</a><br><br>
    <p style="color: red;">${err_result_cancel}</p>
    <h2>ผู้สอน</h2>
    <img class="profile-img" src="${rc.course.tutor.user.imgProfile}" 
         alt="รูปโปรไฟล์ผู้สอน" width="120" height="120">
    <p>ชื่อ-นามสกุล: ${rc.course.tutor.user.firstName} ${rc.course.tutor.user.lastName}</p>
    <p>เพศ: ${rc.course.tutor.user.gender}</p>
    <p>เบอร์โทรศัพท์: ${rc.course.tutor.user.phoneNumber}</p>
    <p>ประสบการณ์: ${rc.course.tutor.expertise}</p>

    <h2>ข้อมูลคอร์ส</h2>
    <p>ชื่อคอร์ส: ${rc.course.courseName}</p>
    <p>รายละเอียดของวิชา: ${rc.course.courseDescription}</p>
    <p>ราคา: ${rc.course.coursePrice} บาท</p>
    <p>จำนวนนักศึกษาที่รับ: ${rc.course.maxStudents} คน</p>
    <p>ประเภท: ${rc.course.category.categoryName}</p>

    <h2>การจัดการคอร์ส</h2>
    <form id="cancelForm" action="cancelRegisterCourse" method="post">
        <input type="hidden" name="registerId" value="${rc.registerCourseId}" />
        <button type="button" onclick="confirmCancel()">ยกเลิกคอร์ส</button>
    </form>
    <a href="goReviewCourse">รีวิวคอร์ส</a>
    <a href="goReportTutor">รายงานผู้สอน</a>

</body>
</html>
