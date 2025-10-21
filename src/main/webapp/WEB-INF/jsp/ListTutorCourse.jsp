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
    /* 🌐 โทนสีหลัก */
    :root {
        --primary: #1e70d5;
        --primary-dark: #1559ad;
        --success: #2e7d32;
        --background: #f4f8ff;
        --text-main: #333;
        --text-secondary: #555;
        --card-bg: #fff;
    }

    /* พื้นหลังและโครงสร้างโดยรวม */
    body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, var(--background), #ffffff);
        margin: 0;
        padding: 40px;
        color: var(--text-main);
    }

    /* หัวข้อหลัก */
    h1 {
        text-align: center;
        color: var(--primary);
        font-size: 2.3rem;
        margin-bottom: 15px;
        letter-spacing: 0.5px;
    }

    /* แถบด้านบน */
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        flex-wrap: wrap;
        gap: 10px;
    }

    /* ลิงก์กลับหน้า */
    a.back-link {
        color: var(--primary);
        text-decoration: none;
        font-weight: 600;
        font-size: 1rem;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.3s ease;
    }

    a.back-link:hover {
        color: var(--primary-dark);
        transform: translateX(-3px);
    }

    /* ปุ่มถอนเงิน */
    .withdraw-btn {
        background-color: var(--primary);
        color: white;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1rem;
        box-shadow: 0 3px 6px rgba(30,112,213,0.2);
        transition: all 0.3s ease;
    }

    .withdraw-btn:hover {
        background-color: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 6px 10px rgba(30,112,213,0.25);
    }

    /* กล่องข้อความสำเร็จ */
    .success-msg {
        color: var(--success);
        background-color: #e8f5e9;
        border-left: 6px solid var(--success);
        padding: 12px 16px;
        border-radius: 10px;
        text-align: center;
        font-weight: 600;
        font-size: 1rem;
        margin: 20px auto;
        width: 80%;
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.05);
    }

    /* พื้นที่รายการคอร์ส */
    .courses-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(330px, 1fr));
        gap: 25px;
        margin-top: 25px;
    }

    /* กล่องคอร์ส */
    .course-card {
        background-color: var(--card-bg);
        border-radius: 14px;
        box-shadow: 0 6px 14px rgba(0,0,0,0.08);
        padding: 22px 25px;
        border-top: 5px solid var(--primary);
        transition: all 0.25s ease;
    }

    .course-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }

    .course-title {
        font-size: 1.4rem;
        font-weight: 600;
        color: var(--primary);
        margin-bottom: 10px;
    }

    .course-category {
        font-size: 1rem;
        color: var(--text-secondary);
        margin-bottom: 10px;
        font-style: italic;
    }

    .course-dates {
        background-color: #f9fbff;
        border-left: 4px solid var(--primary);
        padding: 10px 12px;
        border-radius: 6px;
        font-size: 0.95rem;
        color: #444;
        margin-bottom: 6px;
        line-height: 1.4;
    }

    .course-actions {
        margin-top: 15px;
        text-align: right;
    }

    .course-actions a {
        text-decoration: none;
        background-color: var(--primary);
        color: white;
        padding: 9px 16px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.95rem;
        box-shadow: 0 3px 6px rgba(30,112,213,0.2);
        transition: all 0.3s ease;
    }

    .course-actions a:hover {
        background-color: var(--primary-dark);
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
        }
        .success-msg {
            width: 100%;
        }
    }
</style>
</head>
<body>

    <div class="top-bar">
        <a href="goHome" class="back-link">⬅ กลับหน้า Home</a>
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
