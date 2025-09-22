<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Tutor</title>
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
    .header a {
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

    .left-container, .right-container {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 20px;
    }

    .left-container {
        flex: 0 0 25%;
        margin-right: 30px;
    }
    .right-container {
        flex: 1;
    }

    .profile-img {
        border-radius: 50%;  
        object-fit: cover;   
        width: 150px;        
        height: 150px;       
    }

    .btn_cancel, .btn_submit {
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

    .btn_submit {
        background-color: #9025dd;
    }
    .btn_submit:hover {
        background-color: #5d079b;
    }

    .error-msg {
        color: red;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .success-msg {
        color: green;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .course-info {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 20px;
    }
    .left-info, .right-info {
        width: 48%;
    }
    .right-info ul {
        padding-left: 20px;
        margin-top: 0;
    }

    textarea {
        width: 100%;
        resize: vertical;
    }
</style>
</head>
<body>

<div class="header">
    <a href="goHome">
            <img src="resources/images/home_on.png" alt="Home" width="90" height="90" />
    </a>
    <h2>รายงานผู้สอน</h2>
</div>

<div class="main-content">

    <div class="left-container">
        <h3>ผู้สอน</h3>
        <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" alt="Tutor Image"><br><br>
        <p><strong>ชื่อ-นามสกุล:</strong> ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
        <p><strong>เพศ:</strong> ${course.tutor.user.gender}</p>
        <p><strong>เบอร์โทรศัพท์:</strong> ${course.tutor.user.phoneNumber}</p>
        <p><strong>ประสบการณ์:</strong> ${course.tutor.expertise}</p>
    </div>

    <div class="right-container">
        <p class="error-msg">${err_report}</p>
        <p class="success-msg">${result_report}</p>

        <h3>ข้อมูลคอร์ส</h3>
        <div class="course-info">
            <div class="left-info">
                <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
                <p><strong>รายละเอียด:</strong> ${course.courseDescription}</p>
                <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
            </div>
            <div class="right-info">
                <p><strong>วันที่สอน:</strong></p>
                <ul>
                    <c:forEach var="cd" items="${course.courseDates}">
                        <li>${cd.class_date} เวลา ${cd.startTime} - ${cd.endTime} (หัวข้อ: ${cd.topic})</li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <h3>รายงานผู้สอน</h3>
        <form action="addReportTutor" method="post">
            <input type="hidden" name="courseId" value="${course.courseId}" />
            <input type="hidden" name="registerId" value="${rc.registerId}" />
            <label for="details">รายละเอียดรายงาน:</label><br>
            <textarea id="details" name="details" rows="4" required></textarea><br><br>
            <input type="button" class="btn_cancel" value="ยกเลิก" onclick="history.back();"> 
            <input type="submit" class="btn_submit" value="ส่งรายงาน">
        </form>

    </div>

</div>

</body>
</html>
