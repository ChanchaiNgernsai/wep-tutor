<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายงานผู้สอน</title>
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

    .header a { color: white; text-decoration: none; }
    
    .main-content {
        display: flex;
        flex-wrap: wrap;
        max-width: 950px;
        margin: 30px auto;
        gap: 20px;
        padding: 0 15px;
    }

    .left-container, .right-container {
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        padding: 20px;
    }

    .left-container {
        flex: 0 0 30%;
        text-align: center;
    }
    .left-container {
    flex: 0 0 30%;
    text-align: left; /* เปลี่ยนจาก center เป็น left */
    padding: 20px;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
}

.left-container .profile-img {
    display: block;
    margin: 0 auto 15px auto; /* รูปยังอยู่กลาง */
}

    .right-container {
        flex: 1;
    }

    .profile-img {
        border-radius: 50%;
        object-fit: cover;
        width: 140px;
        height: 140px;
        margin-bottom: 15px;
        border: 3px solid #007F3E;
    }

    h3 { color: #383838; margin-bottom: 15px; }

    .btn_cancel, .btn_submit {
        display: inline-block;
        width: 130px;
        text-align: center;
        margin: 10px 5px 0 0;
        padding: 10px 0;
        border: none;
        border-radius: 25px;
        font-weight: bold;
        cursor: pointer;
        color: white;
        text-decoration: none;
        transition: all 0.3s ease;
        font-size: 0.95rem;
    }
    .btn_cancel { background-color: #f44336; }
    .btn_cancel:hover { background-color: #c62828; transform: translateY(-2px); }
    .btn_submit { background-color: #4caf50; }
    .btn_submit:hover { background-color: #2e7d32; transform: translateY(-2px); }

    .error-msg { color: #e53935; font-weight: bold; margin-bottom: 10px; }
    .success-msg { color: #2e7d32; font-weight: bold; margin-bottom: 10px; }

    .course-info {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        margin-bottom: 20px;
        gap: 15px;
    }
    .left-info, .right-info { width: 48%; }
    .right-info ul { padding-left: 20px; margin-top: 0; }

    textarea {
        width: 100%;
        resize: vertical;
        padding: 12px;
        border-radius: 10px;
        border: 1.5px solid #ccc;
        font-size: 1rem;
        box-sizing: border-box;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }
    textarea:focus {
        border-color: #007F3E;
        outline: none;
        box-shadow: 0 0 6px rgba(0,127,62,0.3);
    }

    @media (max-width: 768px) {
        .main-content { flex-direction: column; padding: 0 10px; }
        .left-container, .right-container { width: 100%; }
        .left-info, .right-info { width: 100%; }
    }
</style>

<script>
function validateForm() {
    const details = document.getElementById("details").value.trim();
    if(details === "") {
        alert("กรุณากรอกรายละเอียดรายงาน");
        document.getElementById("details").focus();
        return false;
    }
    if(details.length < 20 || details.length > 255) {
        alert("รายละเอียดต้องมีความยาว 20-255 ตัวอักษร");
        document.getElementById("details").focus();
        return false;
    }
    return true;
}
</script>

</head>
<body>

<div class="header">
    <a href="goHome"> รายงานผู้สอน</a>
</div>

<div class="main-content">

    <div class="left-container">
        <h3>ผู้สอน</h3>
        <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" alt="Tutor Image">
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
        <form action="addReportTutor" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="courseId" value="${course.courseId}" />
            <input type="hidden" name="registerId" value="${rc.registerId}" />
            <label for="details">รายละเอียดรายงาน:</label><br>
            <textarea id="details" name="details" rows="5" placeholder="กรอกรายละเอียดรายงานอย่างน้อย 20 ตัวอักษร"></textarea><br>
            <input type="button" class="btn_cancel" value="ยกเลิก" onclick="history.back();"> 
            <input type="submit" class="btn_submit" value="ส่งรายงาน">
        </form>

    </div>

</div>

</body>
</html>
