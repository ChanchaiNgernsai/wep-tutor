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
    }

    .btn_cancel, .btn_review, .btn_report {
        display: inline-block;
        width: 120px;       
        text-align: center;  
        margin: 10px 5px 10px 0;
        padding: 8px 0;      
        border: none;
        border-radius: 20px;
        font-weight: bold;
        cursor: pointer;
        color: white;
        text-decoration: none;
        transition: background-color 0.3s;
    }

    .btn_cancel {
        background-color: #f50d1c;
    }
    .btn_cancel:hover {
        background-color: #b10a15;
    }

    .btn_review {
        background-color: #f1e023;
    }
    .btn_review:hover {
        background-color: #c7b91b;
    }

    .btn_report {
        background-color: #9025dd;
    }
    .btn_report:hover {
        background-color: #5d079b;
    }

    .error-msg {
        color: red;
        font-weight: bold;
        margin-bottom: 10px;
    }

    /* สำหรับข้อมูลคอร์ส */
    .course-info {
        display: flex;
        justify-content: space-between;
        align-items: flex-start; /* ชิดด้านบน */
    }
    .left-info, .right-info {
        width: 48%; /* ขนาดเท่ากัน */
    }
    .right-info ul {
        padding-left: 20px;
        margin-top: 0;
    }
</style>
<script>
    function confirmCancel() {
        if (confirm("ระบบไม่มีการคืนเงินใด ๆ คุณต้องการยกเลิกคอร์สนี้หรือไม่?")) {
            document.getElementById("cancelForm").submit();
        }
    }
</script>
</head>
<body>

    <div class="header">
        <a href="goHome">
            <img src="resources/images/home_on.png" alt="Home" width="90" height="90" />
        </a>
        <h2>รายละเอียดการลงทะเบียนคอร์ส</h2>
    </div>

    
    <div class="main-content">

        
        <div class="left-container">
            <h2>ผู้สอน</h2>
            <img class="profile-img" src="getUserImage?email=${rc.course.tutor.user.email}" 
                 alt="รูปโปรไฟล์ผู้สอน">
            <p><strong>ชื่อ-นามสกุล:</strong> ${rc.course.tutor.user.firstName} ${rc.course.tutor.user.lastName}</p>
            <p><strong>เพศ:</strong> ${rc.course.tutor.user.gender}</p>
            <p><strong>เบอร์โทรศัพท์:</strong> ${rc.course.tutor.user.phoneNumber}</p>
            <p><strong>ประสบการณ์:</strong> ${rc.course.tutor.expertise}</p>
        </div>
  
        <div class="right-container">
            <p class="error-msg">${err_result_cancel}</p>

            <h2>ข้อมูลคอร์ส</h2>
            <div class="course-info">
                <div class="left-info">
                    <p><strong>ชื่อคอร์ส:</strong> ${rc.course.courseName}</p>
                    <p><strong>รายละเอียดของวิชา:</strong> ${rc.course.courseDescription}</p>
                    <p><strong>ราคา:</strong> ${rc.course.coursePrice} บาท</p>
                    <p><strong>จำนวนนักศึกษาที่รับ:</strong> ${rc.course.maxStudents} คน</p>
                    <p><strong>ประเภท:</strong> ${rc.course.category.categoryName}</p>
                </div>
                <div class="right-info">
                    <p><strong>วันที่สอน:</strong></p>
                    <ul>
                        <c:forEach var="cd" items="${courseDates}">
                            <li>
                                ${cd.class_date} เวลา ${cd.startTime} - ${cd.endTime} (หัวข้อ: ${cd.topic})
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <h2>การจัดการคอร์ส</h2>
            <form id="cancelForm" action="cancelRegisterCourse" method="post" style="display:inline;">
                <input type="hidden" name="registerId" value="${rc.registerCourseId}" />
                <button type="button" class="btn_cancel" onclick="confirmCancel()">ยกเลิกคอร์ส</button>
            </form>
            <a href="goReviewCourse" class="btn_review">รีวิวคอร์ส</a>
            <a href="goReportTutor" class="btn_report">รายงานผู้สอน</a> 
        </div>
    </div>
</body>
</html>
