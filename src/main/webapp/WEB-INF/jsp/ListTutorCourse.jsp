<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Tutor Course</title>
<style>
    /* พื้นหลังและโครงสร้างโดยรวม */
    body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #e3f2fd, #ffffff);
        margin: 0;
        padding: 40px;
        color: #333;
    }

    /* หัวข้อหลัก */
    h1 {
        text-align: center;
        color: #1565c0;
        font-size: 2.2rem;
        margin-bottom: 10px;
    }

    /* ลิงก์กลับ */
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
    }

    a.back-link {
        color: #1e88e5;
        text-decoration: none;
        font-weight: bold;
        font-size: 1rem;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        transition: 0.3s;
    }

    a.back-link:hover {
        color: #0d47a1;
        transform: translateX(-3px);
    }

    /* ปุ่มถอนเงิน */
    .withdraw-btn {
        background-color: #43a047;
        color: white;
        text-decoration: none;
        padding: 8px 18px;
        border-radius: 8px;
        font-weight: bold;
        transition: background-color 0.3s, transform 0.2s;
    }

    .withdraw-btn:hover {
        background-color: #2e7d32;
        transform: translateY(-2px);
    }

    /* ข้อความสำเร็จ */
    .success-msg {
        color: #2e7d32;
        text-align: center;
        margin: 20px 0;
        font-weight: bold;
        background-color: #e8f5e9;
        padding: 10px;
        border-radius: 8px;
        font-size: 1rem;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    }

    /* กล่องคอร์ส */
    .courses-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 25px;
    }

    .course-card {
        background-color: #ffffff;
        border-radius: 15px;
        box-shadow: 0 6px 14px rgba(0,0,0,0.08);
        padding: 20px 25px;
        transition: transform 0.25s ease, box-shadow 0.25s ease;
        border-top: 5px solid #1e88e5;
    }

    .course-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 22px rgba(0,0,0,0.15);
    }

    .course-title {
        font-size: 1.4rem;
        font-weight: 600;
        color: #1e88e5;
        margin-bottom: 10px;
    }

    .course-category {
        font-size: 1rem;
        color: #555;
        margin-bottom: 10px;
        font-style: italic;
    }

    .course-dates {
        background-color: #f9f9f9;
        border-left: 4px solid #1e88e5;
        padding: 8px 10px;
        border-radius: 5px;
        font-size: 0.95rem;
        color: #444;
        margin-bottom: 6px;
    }

    .course-actions {
        margin-top: 15px;
        text-align: right;
    }

    .course-actions a {
        text-decoration: none;
        background-color: #1e88e5;
        color: white;
        padding: 8px 14px;
        border-radius: 8px;
        font-weight: bold;
        font-size: 0.95rem;
        transition: background-color 0.3s, transform 0.2s;
    }

    .course-actions a:hover {
        background-color: #1565c0;
        transform: translateY(-2px);
    }

    /* Responsive */
    @media (max-width: 600px) {
        body {
            padding: 20px;
        }
        .top-bar {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }
        .course-card {
            padding: 15px;
        }
    }
</style>
</head>
<body>

    <div class="top-bar">
        <a href="goHome" class="back-link">⬅ กลับหน้า Home</a>
        <a href="goWithdraw" class="withdraw-btn">💰 ถอนเงิน</a>
    </div>

    <h1>📚 รายการคอร์สผู้สอน</h1>

    <c:if test="${not empty result_addCourse}">
        <div class="success-msg">${result_addCourse}</div>
    </c:if>

    <div class="courses-container">
        <c:forEach var="course" items="${courses}">
            <div class="course-card">
                <div class="course-title">${course.courseName}</div>
                <div class="course-category">ประเภท: ${course.category.categoryName}</div>

                <c:forEach var="cd" items="${course.courseDates}">
                    <div class="course-dates">
                        วันที่: ${cd.class_date} | เวลา: ${cd.startTime} - ${cd.endTime}<br>
                        หัวข้อ: ${cd.topic}
                    </div>
                </c:forEach>

                <div class="course-actions">
                    <a href="getViewTutorCourse?id=${course.courseId}">🔍 ดูรายละเอียด</a>
                </div>
            </div>
        </c:forEach>
    </div>

</body>
</html>
