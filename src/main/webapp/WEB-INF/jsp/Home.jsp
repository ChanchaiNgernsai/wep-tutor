<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html> 
<html>
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
        if (loginMsg) loginMsg.style.display = "none";
        if (tutorMsg) tutorMsg.style.display = "none";
    }, 5000); // 5000 = 5 วินาที
    </script>
    
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
        .header form {
        margin-left: auto;
        }
        .header img {
            margin-right: 15px;
        }
        .main-content {
            display: flex;
            max-width: 900px;
            margin: 20px 0 20px 0; /* เอาชิดบนล่าง ปรับซ้าย */
            justify-content: flex-start; /* ชิดซ้าย */
            padding-left: 20px; /* เว้นขอบซ้ายให้ชิดจอไม่ติด */
        }
        .left-container {
            flex: 0 0 20%;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
            margin-right: 30px; /* ช่องว่างขวา */
        }
        .right-container {
            flex: 1 ;
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
        .profile-img-reviewTutor {
            border-radius: 12px;  /* มุมโค้งเล็ก */
            object-fit: cover;   
            width: 120px;        
            height: 120px;       
            border: 2px solid #ccc; /* ถ้าต้องการขอบบาง */
        }



        .btn {
            display: inline-block;
            margin: 10px 5px 10px 0;
        }
        .role-list {
            padding-left: 20px;
        }
        
        .header form {
            margin-left: auto;
            display: flex;
            align-items: center;
        }
        
        .header input[type="text"] {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 20px 0 0 20px;
            outline: none;
            font-size: 16px;
            width: 200px;
            transition: border-color 0.3s;
        }
        
        
        .header input[type="submit"] {
            padding: 8px 18px;
            border: 1px solid #ccc;
            border-radius: 20px 0 0 20px;
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

        .hover-shadow {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover; 
            display: block;
            transition: box-shadow 0.2s ease;
        }
        .hover-shadow:hover {
             box-shadow: 0 0 10px rgba(0,0,0,0.5);
        }

    </style>
</head>
<body>

    <div class="header">
        <div >
            <a href="goHome">
                <img src="resources/images/home_on.png" alt="Home"width="120" height="120" alt="Home" />
            </a>
        </div>
    
        
        <h2>ช่วยติวในมหาวิทยาลัยแม่โจ้ </h2>
        
            <form name="searchForm" action="search" method="get" onsubmit="return validateSearchForm();">
                <input type="text" name="keyword" placeholder="ค้นหาคอร์ส" />
                <input type="submit" value="ค้นหา" />
            </form>
    </div>

    <div class="main-content">
        <div class="left-container">
            <c:if test="${not empty sessionScope.User}">
                <img class="profile-img" src="getUserImage?email=${User.email}" width="120" height="120" alt="รูปโปรไฟล์"/><br />

                <p id="resultLogin" style="color: green;">${result_login}</p>
                <p id="resultTutor" style="color: green;">${result_RegisTutor}</p>
                <p id="resultReview" style="color: green;">${result_review}</p>
                <a class="btn" href="goProfile">ดูโปรไฟล์</a><br />
                <p>ชื่อ: ${sessionScope.User.firstName} ${sessionScope.User.lastName}</p>
                <p>สถานะของคุณ</p>
                <ul class="role-list">
                    <c:forEach var="role" items="${sessionScope.Roles}"> 
                        <li>${role}</li>
                    </c:forEach>
                </ul>
                
                <c:if test="${empty sessionScope.Tutor}">
                    <a class="btn" href="goRegisterTutor">สมัครเป็นติวเตอร์</a><br />
                </c:if>
            
                <c:if test="${sessionScope.User == 'Admin'}">
                    <a class="btn" href="goListReport">--หน้ารายงาน--</a><br />
                </c:if>

                <c:if test="${not empty sessionScope.Tutor}">
                    <a class="btn" href="goAddCourse?email=${sessionScope.email}">เพิ่มคอร์ส</a><br />
                    <a class="btn" href="listTutorCourses">รายการคอร์ส</a><br />
                </c:if>

                <a class="btn" href="goListRegisterCourse">คอร์สที่ลงทะเบียน</a><br />

                <form action="logout" method="post" style="margin-top: 10px;">
                    <input type="submit" value="ออกจากระบบ" />
                </form>
            </c:if>

            <c:if test="${empty sessionScope.User}">
                <a href="goLogin">
                   <img class="hover-shadow" src="resources/images/login_off.png" alt="Login" />
                </a><br />
                <a href="goRegisterStu">
                    <img class="hover-shadow" src="resources/images/Register_off.png" alt="Register" />
                </a><br />
            </c:if>
        </div>

        
       <div class="right-container">
    <h2>คอร์สเปิดใหม่ล่าสุด</h2>
    <c:if test="${not empty latestCourses}">
        <c:forEach var="course" items="${latestCourses}">
            <div class="course-item" style="margin-bottom:15px; padding:10px; border:1px solid #ccc; border-radius:8px;">
                <img class="profile-img-reviewTutor" src="getUserImage?email=${course.tutor.user.email}" alt="รูปโปรไฟล์ติวเตอร์" /><br/>
                ผู้สอน: ${course.tutor.user.firstName} ${course.tutor.user.lastName} <br/>
                <a href="getViewCourse?id=${course.courseId}" style="font-weight:bold; font-size:16px; color:#2CC06C;" >
                    ${course.courseName}
                </a>
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
