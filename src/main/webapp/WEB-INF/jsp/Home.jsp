<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html> 
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Home</title>
    
    <script>
        function validateSearchForm() {
            const keyword = document.forms["searchForm"]["keyword"].value.trim();
            const regex = /^[\u0E00-\u0E7Fa-zA-Z\s]{1,20}$/;
            if (keyword !== "" && !regex.test(keyword)) {
                alert("กรุณากรอกเฉพาะตัวอักษรภาษาไทยหรืออังกฤษ (ไม่เกิน 20 ตัว)");
                return false;
            }
            return true;
        }

        setTimeout(function() {
            const loginMsg = document.getElementById("resultLogin");
            const tutorMsg = document.getElementById("resultTutor");
            const reviewMsg = document.getElementById("resultReview");
            if (loginMsg) loginMsg.style.display = "none";
            if (tutorMsg) tutorMsg.style.display = "none";
            if (reviewMsg) reviewMsg.style.display = "none";
        }, 5000);
    </script>
    
    <style>
        body {
            background-color: #f2f2f2;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0; padding: 0;
        }

        .header {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background-color: #fff;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .header h2 {
            margin-left: 15px;
            font-size: 22px;
            color: #2c3e50;
        }

        .header form {
            margin-left: auto;
            display: flex;
        }

        .header input[type="text"] {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 20px 0 0 20px;
            outline: none;
            font-size: 16px;
            width: 180px;
            transition: border-color 0.3s;
        }

        .header input[type="text"]:focus {
            border-color: #009639;
        }

        .header input[type="submit"] {
            padding: 8px 18px;
            border: none;
            background-color: #009639;
            color: white;
            font-weight: bold;
            border-radius: 0 20px 20px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .header input[type="submit"]:hover {
            background-color: #007a2f;
        }

        .main-content {
            display: flex;
            max-width: 950px;
            margin: 25px auto;
            gap: 25px;
            padding: 0 15px;
        }

        .left-container, .right-container {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            padding: 20px;
        }

        .left-container { flex: 0 0 25%; }
        .right-container { flex: 1; }

        .profile-img {
            border-radius: 50%;
            object-fit: cover;
            width: 120px; height: 120px;
            display: block;
            margin: 0 auto 10px;
        }

        .profile-img-reviewTutor {
            border-radius: 12px;
            object-fit: cover;
            width: 120px; height: 120px;
            border: 2px solid #ccc;
            margin-bottom: 8px;
        }

        .hover-shadow {
            width: 120px; height: 120px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            transition: box-shadow 0.2s ease;
            margin-bottom: 10px;
        }
        .hover-shadow:hover {
            box-shadow: 0 0 12px rgba(0,0,0,0.4);
        }

        .course-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 12px;
            background-color: #fdfdfd;
        }
        .course-item a {
            color: #009639;
            font-weight: bold;
            text-decoration: none;
        }
        .course-item a:hover { text-decoration: underline; }

        #resultLogin, #resultTutor, #resultReview {
            font-size: 14px;
            margin: 6px 0;
        }

        .role-list { padding-left: 20px; margin-bottom: 10px; }

        /* ปุ่มหลายสีไม่ซ้ำกัน */
        .btn-profile { background-color: #28a745; } /* เขียว */
        .btn-profile:hover { background-color: #1e7e34; }

        .btn-deposit { background-color: #fd7e14; } /* ส้ม */
        .btn-deposit:hover { background-color: #e06a00; }

        .btn-tutor { background-color: #007bff; } /* น้ำเงิน */
        .btn-tutor:hover { background-color: #0056b3; }

        .btn-course { background-color: #6f42c1; } /* ม่วง */
        .btn-course:hover { background-color: #4b2e91; }

        .btn-registered { background-color: #2d82ea; } /* ฟ้า */
        .btn-registered:hover { background-color: #117a8b; }

        .btn-logout { background-color: #dc3545; } /* แดง */
        .btn-logout:hover { background-color: #a71d2a; }

        .btn, .btn-profile, .btn-deposit, .btn-tutor, .btn-course, .btn-registered, .btn-logout {
            display: inline-block;
            margin: 8px 5px 8px 0;
            padding: 6px 12px;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            transition: background-color 0.3s;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="header">
    <a href="goHome">
        <img src="resources/images/home_on.png" alt="Home" width="120" height="120" />
    </a>
    <h2>ช่วยติวในมหาวิทยาลัยแม่โจ้</h2>
    <form name="searchForm" action="search" method="get" onsubmit="return validateSearchForm();">
        <input type="text" name="keyword" placeholder="ค้นหาคอร์ส" />
        <input type="submit" value="ค้นหา" />
    </form>
</div>

<div class="main-content">
    <div class="left-container">
        <c:if test="${not empty sessionScope.User}">
            <img class="profile-img" src="getUserImage?email=${User.email}" alt="รูปโปรไฟล์"/>
            <p id="resultLogin" style="color: green;">${result_login}</p>
            <p id="resultTutor" style="color: green;">${result_RegisTutor}</p>
            <p id="resultReview" style="color: green;">${result_review}</p>
            <p id="resultReview" style="color: green;">${message_completed}</p>

            <a class="btn-profile" href="goProfile">ดูโปรไฟล์</a><br/>
            <p>ชื่อ: ${sessionScope.User.firstName} ${sessionScope.User.lastName}</p>
            <p>สถานะของคุณ</p>
            <ul class="role-list">
                <c:forEach var="role" items="${sessionScope.Roles}">
                    <li>${role}</li>
                </c:forEach>
            </ul>

            <a class="btn-deposit" href="goDeposit">ฝากเงิน</a><br/>

            <c:if test="${empty sessionScope.Tutor}">
                <a class="btn-tutor" href="goRegisterTutor">สมัครเป็นติวเตอร์</a><br/>
            </c:if>

            <c:if test="${not empty sessionScope.Tutor}">
                <a class="btn-course" href="goAddCourse?email=${sessionScope.email}"><spring:message code="home.add_course"/></a><br />
                <a class="btn-course" href="listTutorCourses"><spring:message code="home.course_list"/></a><br />
            </c:if>

            <a class="btn-registered" href="goListRegisterCourse">คอร์สที่ลงทะเบียน</a><br/>

            <form action="logout" method="post" style="margin-top: 10px;">
                <input class="btn-logout" type="submit" value="ออกจากระบบ" />
            </form>
        </c:if>

        <c:if test="${empty sessionScope.User}">
            <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;">
                <a href="goLogin">
                    <img class="hover-shadow" src="resources/images/login_off.png" alt="Login" />
                </a>
                <a href="goRegisterStu" style="margin-top: 15px;">
                    <img class="hover-shadow" src="resources/images/Register_off.png" alt="Register" />
                </a>
            </div>
        </c:if>

    </div>

    <div class="right-container">
        <h2>คอร์สเปิดใหม่ล่าสุด</h2>
        <c:if test="${not empty latestCourses}">
            <c:forEach var="course" items="${latestCourses}">
                <div class="course-item">
                    <img class="profile-img-reviewTutor" src="getUserImage?email=${course.tutor.user.email}" alt="รูปโปรไฟล์ติวเตอร์"/>
                    <div>
                        ผู้สอน: ${course.tutor.user.firstName} ${course.tutor.user.lastName} <br/>
                        <a href="getViewCourse?id=${course.courseId}">${course.courseName}</a>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty latestCourses}">
            <p>ยังไม่มีคอร์สล่าสุดให้แสดง</p>
        </c:if>
    </div>
</div>

</body>
</html>
