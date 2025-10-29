<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายการคอร์สผู้สอน</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f0f2f5;
    margin: 0;
    padding: 0;
    color: #333;
}

/* Header */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #007F3E;
    color: white;
    padding: 15px 30px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.15);
    position: sticky;
    top: 0;
    z-index: 10;
    font-size: 1.6rem;
    font-weight: 700;
    text-align: center;
}

.header a {
    color: white;
    text-decoration: none;
}
.header a:hover {
    color: #e0e0e0;
}

/* Main layout */
.main-content {
    display: flex;
    max-width: 1000px;
    margin: 30px auto;
    gap: 25px;
    flex-wrap: wrap;
    padding: 0 15px;
}
/* ปุ่มลิงก์ทั่วไป */
.link-btn {
    display: inline-block;
    background-color: #007F3E;
    color: white;
    padding: 8px 18px;
    border-radius: 25px;
    font-size: 0.95rem;
    font-weight: 600;
    text-decoration: none;
    margin-right: 10px;
    transition: all 0.3s ease;
}

.link-btn:hover {
    background-color: #005f2e;
    transform: translateY(-2px);
}

/* ปรับให้ container ลิงก์เรียงตัวแนวนอน */
.action-links {
    margin: 15px 0;
}




.right-container {
    flex: 1;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    padding: 25px 30px;
    overflow-x: auto;
}

/* Success message */
.success-msg {
    color: #2e7d32;
    background-color: #e8f5e9;
    padding: 12px 16px;
    font-weight: 600;
    margin-bottom: 20px;
    text-align: center;
    border-radius: 10px;
    font-size: 1rem;
}

/* Course card */
.course-card {
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    padding: 20px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    min-height: 180px;
    margin-bottom: 20px;
    position: relative;
}

.course-title {
    font-size: 1.2rem;
    font-weight: 600;
    margin-bottom: 8px;
    color: #007F3E;
}

.course-category {
    font-size: 0.95rem;
    font-style: italic;
    color: #555;
    margin-bottom: 10px;
}

.course-dates {
    font-size: 0.9rem;
    background-color: #f7f9fc;
    padding: 8px 10px;
    border-left: 4px solid #007F3E;
    border-radius: 6px;
    margin-bottom: 6px;
}

/* ปุ่มดูรายละเอียดติดขวาล่าง */
.course-actions {
    display: flex;
    justify-content: flex-end;
    margin-top: auto;
}

.btn_view {
    display: inline-block;
    background-color: #007F3E;
    color: white;
    padding: 6px 14px;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.btn_view:hover {
    background-color: #005f2e;
    transform: translateY(-2px);
}

/* Empty message */
.no-course {
    text-align: center;
    color: #555;
    font-size: 16px;
    margin-top: 20px;
}

@media (max-width: 768px) {
    .main-content { flex-direction: column; margin: 20px; gap: 15px; }
    .left-container, .right-container { flex: 1; }
}
</style>
</head>
<body>

<div class="header">รายการคอร์สผู้สอน</div>

<div class="main-content">
    

    <div class="right-container">
        <h2> คอร์สที่ผู้สอนลงทะเบียน</h2>
        <div class="action-links">
            <a href="goHome" class="link-btn">← กลับหน้า Home</a>
            <a href="goAddCourse" class="link-btn">เพิ่มคอร์สใหม่</a>
        </div>

    

        <c:if test="${not empty result_addCourse}">
            <div class="success-msg">${result_addCourse}</div>
        </c:if>

        <c:if test="${empty courses}">
            <p class="no-course">ยังไม่มีคอร์สที่ผู้สอนลงทะเบียน</p>
        </c:if>

        <c:forEach var="course" items="${courses}">
            <div class="course-card">
                <div>
                    <div class="course-title">${course.courseName}</div>
                    <div class="course-category">ประเภท: ${course.category.categoryName}</div>

                    <c:forEach var="cd" items="${course.courseDates}">
                        <div class="course-dates">
                            วันที่: ${cd.class_date} | เวลา: ${cd.startTime} - ${cd.endTime}<br>
                            หัวข้อ: ${cd.topic}
                        </div>
                    </c:forEach>
                </div>

                <div class="course-actions">
                    <a href="getViewTutorCourse?id=${course.courseId}" class="btn_view">ดูรายละเอียด</a>
                </div>
            </div>
        </c:forEach>

    </div>
</div>

</body>
</html>
