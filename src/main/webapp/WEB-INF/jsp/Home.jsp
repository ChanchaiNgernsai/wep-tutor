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
    
            if (keyword === "") {
                alert("กรุณากรอกคำค้นหา");
                return false;
            }
    
            if (!regex.test(keyword)) {
                alert("กรุณากรอกเฉพาะตัวอักษรภาษาไทยหรืออังกฤษ (ไม่เกิน 20 ตัว)");
                return false;
            }
    
            return true;
        }
    </script>
    
    <style>
        body {
            background-color: white;
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
            background-color: #EBEBEB;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
            margin-right: 30px; /* ช่องว่างขวา */
        }
        .right-container {
            flex: 1 ;
            background-color: #EBEBEB;
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
            background-color: #2CC06C;
            color: white;
            font-weight: bold;
            border-radius: 0 20px 20px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .header input[type="submit"]:hover {
            background-color: #2853B8;
        }
    </style>
    </style>
</head>
<body>

    <div class="header">
        <a href="goHome">
            <img src="resources/images/home_on.png" width="120" height="120" alt="Home" />
        </a>
        <h2>ช่วยติวในมหาวิทยาลัยแม่โจ้ </h2>
        
            <form name="searchForm" action="search" method="get" onsubmit="return validateSearchForm();">
                <input type="text" name="keyword" placeholder="ค้นหาคอร์ส" />
                <input type="submit" value="ค้นหา" />
            </form>
    </div>

    <div class="main-content">
        <div class="left-container">
            <c:if test="${not empty sessionScope.User}">
                <img
                    class="profile-img"
                    src="${sessionScope.User.imgProfile}"
                    width="220"
                    height="120"
                    alt="รูปโปรไฟล์"
                /><br />

                <p style="color: green;">${result_login}</p>
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
                    <a class="btn" href="listTutorCourses">คอร์สของฉัน</a><br />
                </c:if>

                <form action="logout" method="post" style="margin-top: 10px;">
                    <input type="submit" value="ออกจากระบบ" />
                </form>
            </c:if>

            <c:if test="${empty sessionScope.User}">
                <a href="goLogin">
                    <img
                        src="resources/images/login_off.png"
                        width="120"
                        height="120"
                        alt="Login"
                    />
                </a><br />
                <a href="goRegisterStu">
                    <img
                        src="resources/images/Register_off.png"
                        width="120"
                        height="120"
                        alt="Register"
                    />
                </a><br />
            </c:if>
        </div>

        
        <div class="right-container">
            <p style="font-weight: bold; font-size: 20px; margin-bottom: 15px;">
                ติวเตอร์ยอดนิยม
            </p>
            <p> ***เดียว get ติวเตอร์ที่มีคะแนนรีวิวที่ดีที่สุด(กลับมาทำ)**
            <!-- ยังไม่มีข้อมูลติวเตอร์แสดง -->
        </div>
    </div>
</body>
</html>
