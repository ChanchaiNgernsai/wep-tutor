<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>

    <style>
        /* --- Reset & Base --- */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f2f5; color: #333; }

        a { text-decoration: none; color: inherit; }
        ul { list-style: none; }

        /* --- Header --- */
        .header {
            display: flex; align-items: center; justify-content: space-between;
            background: linear-gradient(90deg, #6a11cb 0%, #2575fc 100%);
            color: white; padding: 15px 30px; box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 0 0 20px 20px;
        }
        .header h1 { font-size: 24px; font-weight: 700; }
        .header form { display: flex; gap: 5px; }
        .header input[type="text"] {
            padding: 8px 12px; border-radius: 20px 0 0 20px; border: none; outline: none; width: 200px;
        }
        .header input[type="submit"] {
            padding: 8px 16px; border-radius: 0 20px 20px 0; border: none;
            background: #42e695; color: white; cursor: pointer; font-weight: bold;
            transition: 0.3s;
        }
        .header input[type="submit"]:hover { background: #eb6750; }

        /* --- Layout --- */
        .main { display: flex; max-width: 1000px; margin: 30px auto; gap: 25px; }
        .sidebar { flex: 0 0 280px; background: white; border-radius: 15px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
        .content { flex: 1; background: white; border-radius: 15px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }

        /* --- Profile --- */
        .profile-img { width: 120px; height: 120px; border-radius: 50%; display: block; margin: 0 auto 15px; object-fit: cover; }
        .btn {
            display: block; width: 100%; padding: 10px 0; margin: 8px 0; text-align: center; border-radius: 12px; font-weight: 600;
            cursor: pointer; transition: 0.3s; color: white; border: none; font-size: 14px;
        }
        .btn-profile { background: #ff6a88; background: linear-gradient(45deg, #ff6a88, #ff99ac); }
        .btn-profile:hover { opacity: 0.9; }
        .btn-deposit { background: #42e695; background: linear-gradient(45deg, #42e695, #3bb2b8); }
        .btn-deposit:hover { opacity: 0.9; }
        .btn-tutor { background: #4776e6; background: linear-gradient(45deg, #4776e6, #8e54e9); }
        .btn-tutor:hover { opacity: 0.9; }
        .btn-course { background: #f7971e; background: linear-gradient(45deg, #f7971e, #ffd200); }
        .btn-course:hover { opacity: 0.9; }
        .btn-registered { background: #ff9966; background: linear-gradient(45deg, #ff9966, #ff5e62); }
        .btn-registered:hover { opacity: 0.9; }
        .btn-logout { background: #e52d27; background: linear-gradient(45deg, #e52d27, #b31217); }
        .btn-logout:hover { opacity: 0.9; }

        /* --- Messages --- */
        .message { text-align: center; margin: 8px 0; font-size: 14px; color: #2ecc71; }

        /* --- Roles --- */
        .roles { margin: 15px 0; padding-left: 15px; }
        .roles li { margin-bottom: 6px; }

        /* --- Course list --- */
        .course-item { display: flex; gap: 15px; padding: 12px; border-radius: 12px; margin-bottom: 12px;
                       align-items: center; background: #f7f7f7; transition: transform 0.2s, box-shadow 0.2s; }
        .course-item:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(0,0,0,0.12); }
        .course-item img { width: 80px; height: 80px; border-radius: 12px; object-fit: cover; }
        .course-item a { color: #2ecc71; font-weight: 600; }
        .course-item a:hover { text-decoration: underline; }

        .profile-img {
            width: 120px;       
            height: 120px;
            border-radius: 50%;  
            object-fit: cover;   
            transition: transform 0.3s, box-shadow 0.3s, filter 0.3s;
            cursor: pointer;
        }

        .profile-img:hover {
            transform: scale(1.05);          
            box-shadow: 0 6px 15px rgba(0,0,0,0.2); 
            filter: brightness(1.1);        
        }

    </style>

    <script>
        // function validateSearchForm() {
        //     const keyword = document.forms["searchForm"]["keyword"].value.trim();
        //     const regex = /^[\u0E00-\u0E7Fa-zA-Z\s]{1,20}$/;
        //     if (keyword !== "" && !regex.test(keyword)) {
        //         alert("กรุณากรอกเฉพาะตัวอักษรภาษาไทยหรืออังกฤษ (ไม่เกิน 20 ตัว)");
        //         return false;
        //     }
        //     return true;
        // }

        setTimeout(function() {
            document.querySelectorAll('.message').forEach(el => el.style.display = 'none');
        }, 5000);
    </script>
</head>

<body>

    <div class="header">
        <a href="goHome">
            <h1>ช่วยติวในมหาวิทยาลัยแม่โจ้</h1>
        </a>
        
        <form name="searchForm" action="search" method="get" onsubmit="return validateSearchForm();">
            <input type="text" name="keyword" placeholder="ค้นหาคอร์ส" />
            <input type="submit" value="ค้นหา" />
        </form>
    </div>

    <div class="main">
        <div class="sidebar">
            <c:if test="${not empty sessionScope.User}">
                <a class="btn-profile" href="goProfile">
                    <img class="profile-img" src="getUserImage?email=${User.email}" alt="รูปโปรไฟล์"/>
                </a>
                <p class="message">${result_login}</p>
                <p class="message">${result_RegisTutor}</p>
                <p class="message">${result_review}</p>
                <p class="message">${message_completed}</p>

                <a class="btn btn-profile" href="goProfile">ดูโปรไฟล์</a>
                <p style="text-align:center;">${sessionScope.User.firstName} ${sessionScope.User.lastName}</p>
                <p>สถานะของคุณ:</p>
                <ul class="roles">
                    <c:forEach var="role" items="${sessionScope.Roles}">
                        <li>${role}</li>
                    </c:forEach>
                </ul>

                <a class="btn btn-deposit" href="goDeposit">💳ฝากเงิน</a>
                <c:if test="${not empty sessionScope.Tutor}">
                    <a class="btn btn-deposit" href="goWithdraw">💰 ถอนเงิน</a>
                </c:if>

                <c:if test="${empty sessionScope.Tutor}">
                    <a class="btn btn-tutor" href="goRegisterTutor">สมัครเป็นติวเตอร์</a>
                </c:if>

                <c:if test="${not empty sessionScope.Tutor}">
                    <a class="btn btn-course" href="goAddCourse?email=${sessionScope.email}"><spring:message code="home.add_course"/></a>
                    <a class="btn btn-course" href="listTutorCourses">รายการคอร์ส</a>
                </c:if>

                <a class="btn btn-registered" href="goListRegisterCourse">คอร์สที่ลงทะเบียน</a>
                <form action="logout" method="post">
                    <input class="btn btn-logout" type="submit" value="ออกจากระบบ" />
                </form>
            </c:if>

            <c:if test="${empty sessionScope.User}">
                <div style="text-align:center;">
                    <a href="goLogin">
                        <img class="profile-img" src="resources/images/login_off.png" alt="Login"/>
                    </a>
                    <a href="goRegisterStu" style="margin-top:15px;">
                        <img class="profile-img" src="resources/images/Register_off.png" alt="Register"/>
                    </a>
                </div>
            </c:if>
        </div>

        <div class="content">
            <h2>คอร์สเปิดใหม่ล่าสุด</h2>
            <c:if test="${not empty latestCourses}">
                <c:forEach var="course" items="${latestCourses}">
                    <div class="course-item">
                        <img src="getUserImage?email=${course.tutor.user.email}" alt="ติวเตอร์"/>
                        <div>
                            ผู้สอน: ${course.tutor.user.firstName} ${course.tutor.user.lastName}<br/>
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
