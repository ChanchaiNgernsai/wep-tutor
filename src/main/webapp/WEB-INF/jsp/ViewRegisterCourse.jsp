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
        background-color: #f0f2f5;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        color: #333;
    }

   .header {
    display: flex;
    align-items: center;
    padding: 15px 25px;
    background-color: #007F3E;
    color: white;
    box-shadow: 0 3px 6px rgba(0,0,0,0.15);
    font-size: 1.6rem;
    font-weight: 700;
    gap: 10px; /* เพิ่มช่องว่างระหว่างลิงก์กับชื่อ */
}


.header h2 {
    margin: 0;
    font-size: 1.6rem;
    font-weight: 700;
}


    .main-content {
        display: flex;
        max-width: 1100px ;
        margin: 30px auto;
        gap: 25px;
        flex-wrap: wrap;
    }

    .left-container, .right-container {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 20px;
    }

    .left-container {
        flex: 0 0 500px auto;
        text-align: left;
    }

    .profile-img {
    border-radius: 50%;  
    object-fit: cover;   
    width: 120px;        
    height: 120px;       
    margin: 0 auto 15px auto; 
    display: block; 
}


    .right-container {
        flex: 1 1 700px;
    }

    .btn_common {
        display: inline-block;
        width: 180px;       
        text-align: center;  
        margin: 8px 5px 8px 0;
        padding: 10px 0;      
        border: none;
        border-radius: 25px;
        font-weight: bold;
        cursor: pointer;
        color: white;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .btn_cancel {
        background-color: #f44336;
    }
    .btn_cancel:hover { background-color: #c62828; transform: translateY(-2px); }

    .btn_review {
        background-color: #FF9800;
    }
    .btn_review:hover { background-color: #e68900; transform: translateY(-2px); }

    .btn_report {
        background-color: #9C27B0;
    }
    .btn_report:hover { background-color: #6d1b9a; transform: translateY(-2px); }

    .btn_confirm {
        background-color: #4CAF50;
    }
    .btn_confirm:hover { background-color: #388E3C; transform: translateY(-2px); }

    .btn_home {
        display: inline-block;
        padding: 10px 18px;
        background-color: #007F3E;
        color: white;
        font-weight: bold;
        text-decoration: none;
        border-radius: 25px;
        margin-top: 15px;
        transition: all 0.3s ease;
    }
    .btn_home:hover { background-color: #005f2e; transform: translateY(-2px); }

    .error-msg { color: #e53935; font-weight: bold; margin-bottom: 10px; }
    .success-msg { color: #43a047; font-weight: bold; margin-bottom: 10px; }

    .course-info {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
    }
    .left-info, .right-info {
        width: 48%;
        margin-bottom: 15px;
    }
    .right-info ul {
        padding-left: 20px;
        margin-top: 0;
    }

    @media (max-width: 768px) {
        .main-content { flex-direction: column; margin: 20px; gap: 20px; }
        .left-info, .right-info { width: 100%; }
        .left-container { flex: 1; }
        .right-container { flex: 1; }
        .btn_common { width: 100%; }
        .btn_home { width: 100%; }
    }
</style>

<script>
    function confirmCancel() {
        if (confirm("ระบบไม่มีการคืนเงินใด ๆ คุณต้องการยกเลิกคอร์สนี้หรือไม่?")) {
            document.getElementById("cancelForm").submit();
        }
    }

    function confirmLesson() {
    if(confirm("คุณแน่ใจหรือไม่ว่าติวเตอร์มาสอน?")) {
        document.getElementById("confirmForm").submit();
    }
}

document.addEventListener("DOMContentLoaded", function() {
    const endDateStr = "${lastCourseEndDate}";
    if (endDateStr) {
        
        const fixedDateStr = endDateStr.replace(" ", "T"); 
        const endDate = new Date(fixedDateStr);
        const now = new Date();

        const btnReview = document.getElementById("btnReview");
        const btnReport = document.getElementById("btnReport");
        const btn_confirm = document.getElementById("btn_confirm");

        
        if (now < endDate) {
            if (btnReview) btnReview.style.display = "none";
            if (btnReport) btnReport.style.display = "none";
            if (btn_confirm) btn_confirm.style.display = "none";
        } 
        
        else {
            if (btnReview) {
                btnReview.style.display = "inline-block";
                btnReview.innerText = "รีวิวคอร์ส";
            }
            if (btnReport) {
                btnReport.style.display = "inline-block";
                btnReport.innerText = "ร้องเรียนผู้สอน";
            }
            if (btn_confirm) {
                btn_confirm.style.display = "inline-block";
                btn_confirm.innerText = "ยืนยันสอนแล้ว";
            }
        }
    }
});

</script>
</head>
<body>

<div class="header">
    <a href="goHome" style="margin-right: 15px; color: white; text-decoration: none;">รายละเอียดการลงทะเบียนคอร์ส</a>
</div>




<div class="main-content">
    <div class="left-container">
        <h2>ผู้สอน</h2>
        <img class="profile-img" src="getUserImage?email=${rc.course.tutor.user.email}" alt="รูปโปรไฟล์ผู้สอน">
        <p><strong>ชื่อ-นามสกุล:</strong> ${rc.course.tutor.user.firstName} ${rc.course.tutor.user.lastName}</p>
        <p><strong>เพศ:</strong> ${rc.course.tutor.user.gender}</p>
        <p><strong>เบอร์โทร:</strong> ${rc.course.tutor.user.phoneNumber}</p>
        <p><strong>ประสบการณ์:</strong> ${rc.course.tutor.expertise}</p>
        <a class="btn_home" onclick="history.back();">&#8592; คอร์สที่ลงทะเบียน</a>
    </div>

    <div class="right-container">
        <p class="error-msg">${err_result_cancel}</p>
        <p class="error-msg">${err_result_confirm}</p>

        <h2>ข้อมูลคอร์ส</h2>
        <div class="course-info">
            <div class="left-info">
                <p><strong>ชื่อคอร์ส:</strong> ${rc.course.courseName}</p>
                <p><strong>รายละเอียด:</strong> ${rc.course.courseDescription}</p>
                <p><strong>ราคา:</strong> ${rc.course.coursePrice} บาท</p>
                <p><strong>จำนวนนักศึกษา:</strong> ${rc.course.maxStudents} คน</p>
                <p><strong>ประเภท:</strong> ${rc.course.category.categoryName}</p>
            </div>
            <div class="right-info">
                <p><strong>วันที่สอน:</strong></p>
                <ul>
                    <c:forEach var="cd" items="${courseDates}">
                        <li>${cd.class_date} เวลา ${cd.startTime} - ${cd.endTime} (หัวข้อ: ${cd.topic})</li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <h2>การจัดการคอร์ส</h2>

<form id="cancelForm" action="cancelRegisterCourse" method="post" style="display:inline-block;">
    <input type="hidden" name="registerId" value="${rc.registerCourseId}" />
    <button type="button" class="btn_common btn_cancel" onclick="confirmCancel()">ออกจากคอร์ส</button>
</form>

<a id="btnReview" class="btn_common btn_review" href="goReviewCourse?id=${rc.course.courseId}" style="display:inline-block;">รีวิวคอร์ส</a>
<a id="btnReport" class="btn_common btn_report" href="goReport?id=${rc.course.courseId}" style="display:inline-block;">ร้องเรียนผู้สอน</a>

<form id="confirmForm" action="confirmLesson" method="post" style="display:inline-block;">
    <input type="hidden" name="registerCourseId" value="${rc.registerCourseId}" />
    <c:if test="${rc.regisStatus != 1}">
        <button type="button" id="btn_confirm" class="btn_common btn_confirm" onclick="confirmLesson()">ยืนยันสอนแล้ว</button>
    </c:if>
    <c:if test="${rc.regisStatus == 1}">
        <span style="color:green; font-weight:bold;">✔ ยืนยันแล้ว</span>
    </c:if>
</form>

    </div>
</div>
</body>
</html>
