<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="th_TH" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <style>
        /* --- Reset & Base --- */
        body {
            font-family: "Prompt", Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5; 
            color: #333;
        }
        a { text-decoration: none; color: inherit; }
        ul { list-style: none; padding: 0; margin: 0; }

        /* --- Header --- */
        .header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            background-color: #007F3E;
            color: white;
            padding: 30px 35px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }
        .header h1 {
            font-size: 26px;
            margin: 0;
            cursor: pointer;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .profile-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
            cursor: pointer;
        }
        .roles {
            display: flex;
            gap: 8px; 
            font-size: 12px;
        }
        .roles li {
            background-color: rgba(255,255,255,0.3);
            padding: 2px 8px;
            border-radius: 4px;
        }

        /* --- Dropdown --- */
        .dropdown { position: relative; }
        .btn {
            background-color: #fff;
            color: #0ba455;
            padding: 6px 14px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            transition: 0.3s;
        }
        .btn:hover { background-color: #e6f0ff; }
        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            top: 38px;
            background-color: #fff;
            min-width: 160px;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            z-index: 10;
        }
        .dropdown-content a, .dropdown-content input[type="submit"] {
            display: block;
            padding: 10px 12px;
            color: #0ba455;
            text-align: left;
            border: none;
            background: none;
            font-size: 14px;
            cursor: pointer;
        }
        .dropdown-content a:hover, .dropdown-content input[type="submit"]:hover {
            background-color: #e6f0ff;
        }
        .dropdown:hover .dropdown-content { display: block; }

        /* --- Search Form --- */
        .search-form {
            margin: 20px auto;
            max-width: 700px;
            display: flex;
            gap: 10px;
        }
        .search-form input[type="text"] {
            flex: 1;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        .search-form input[type="submit"] {
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            background-color: #007F3E;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        .search-form input[type="submit"]:hover {
            background-color: #007F3E;
        }

        /* --- Content --- */
        .content {
            margin: 25px;
        }
        .content h2 {
            margin-bottom: 20px;
            color: #383838;
        }
        .message {
            color: green;
            font-weight: bold;
            margin-bottom: 10px;
        }

        /* --- Course Items --- */
        .course-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: 0.3s;
        }
        .course-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .course-item img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #4a90e2;
        }
        .course-item a {
            font-weight: bold;
            color: #4a90e2;
            font-size: 16px;
        }
        .course-item a:hover { text-decoration: underline; }
        .course-info {
            line-height: 1.5;
            font-size: 14px;
        }
        .course-info span { font-weight: bold; }
        .dropdown {
    position: relative;
}

/* ปุ่ม dropdown */
.dropdown > a.btn {
    display: inline-block;
    background-color: #fff;
    color: #0ba455;
    padding: 6px 14px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    text-decoration: none;
}

/* เนื้อหา dropdown */
.dropdown-content {
    display: none; /* เริ่มต้นซ่อน */
    position: absolute;
    right: 0;
    top: 100%; /* อยู่ด้านล่างปุ่ม */
    background-color: #fff;
    min-width: 160px;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    z-index: 10;
}

/* แสดง dropdown เมื่อ hover ที่ parent */
.dropdown:hover .dropdown-content {
    display: block;
}

/* ลิงก์ภายใน dropdown */
.dropdown-content a,
.dropdown-content input[type="submit"] {
    display: block;
    padding: 10px 12px;
    color: #0ba455;
    text-align: left;
    background: none;
    border: none;
    font-size: 14px;
    cursor: pointer;
    text-decoration: none;
}

.dropdown-content a:hover,
.dropdown-content input[type="submit"]:hover {
    background-color: #e6f0ff;
}
/* ปุ่ม logout */
.logout-btn {
    background-color: #f32525; /* สีแดงให้โดดเด่น */
    color: rgb(255, 255, 255);
    padding: 6px 12px;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

.logout-btn:hover {
    background-color: #d9363e; /* สีเข้มเมื่อ hover */
}
.course-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
}

.course-card {
    background-color: #fff;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 0 6px 12px rgba(0,0,0,0.1);
    transition: 0.3s;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.course-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 20px rgba(0,0,0,0.15);
}

.course-header {
    display: flex;
    align-items: center;
    gap: 15px;
}

.course-header img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #007F3E;
}

.course-title a {
    font-size: 18px;
    font-weight: bold;
    color: #007F3E;
    text-decoration: none;
}

.course-title a:hover {
    text-decoration: underline;
}

.tutor-name {
    font-size: 14px;
    color: #555;
    margin-top: 4px;
}

.course-body {
    margin-top: 10px;
    font-size: 14px;
    color: #333;
}

.course-dates li {
    margin-bottom: 5px;
}

.course-price span {
    font-weight: bold;
    color: #007F3E;
}

.btn-view-course {
    margin-top: 10px;
    text-align: center;
    padding: 8px 12px;
    background-color: #007F3E;
    color: white;
    border-radius: 6px;
    font-weight: bold;
    text-decoration: none;
    transition: 0.3s;
}

.btn-view-course:hover {
    background-color: #005f2e;
}
.content-container {
    max-width: 1200px;
    margin: 25px auto;
    padding: 25px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
}





    </style>
    <script>
    setTimeout(function() {
        document.querySelectorAll('.message').forEach(el => el.style.display = 'none');
    }, 5000);

    // function validateSearchForm() {
    //     const keyword = document.forms["searchForm"]["keyword"].value.trim();
    //     const regex = /^[\u0E00-\u0E7Fa-zA-Z\s]{1,20}$/;

    //     if (keyword !== "" && !regex.test(keyword)) {
    //         alert("กรุณากรอกเฉพาะตัวอักษรภาษาไทยหรืออังกฤษ (ไม่เกิน 20 ตัว)");
    //         return false;
    //     }
    //     return true;
    // }
</script>

</head>
<body>

<!-- Header -->
<div class="header">
    <a href="goHome"><h1>ช่วยติวในมหาวิทยาลัยแม่โจ้</h1></a>

    <!-- User logged in -->
    <c:if test="${not empty sessionScope.User}">
        <div class="user-info">
           

            <!-- Student Dropdown -->
            <div class="dropdown">
                <a href="#">นักศึกษา ▼</a>
                <div class="dropdown-content">
                    <a href="goProfile">ดูโปรไฟล์</a>
                    <c:if test="${not empty sessionScope.Stu}">
                        <a href="goListRegisterCourse">คอร์สที่ลงทะเบียน</a>
                    </c:if>
                 
                </div>
            </div>

            <!-- Tutor Dropdown -->
            <c:if test="${not empty sessionScope.Tutor}">
                <div class="dropdown">
                    <a href="#">ติวเตอร์ ▼</a>
                    <div class="dropdown-content">
                        <a href="goAddCourse?email=${sessionScope.email}"><spring:message code="home.add_course"/></a>
                        <a href="listTutorCourses">รายการคอร์ส</a>
                    </div>
                </div>
            </c:if>

            <!-- Register as Tutor -->
            <c:if test="${empty sessionScope.Tutor}">
                <a class="btn" href="goRegisterTutor">สมัครเป็นติวเตอร์</a>
            </c:if>

            <!-- Finance Dropdown -->
            <div class="dropdown">
                <a href="#">จัดการเงิน ▼</a>
                <div class="dropdown-content">
                    <a href="goDeposit">ฝากเงิน</a>
                    <c:if test="${not empty sessionScope.Tutor}">
                        <a href="goWithdraw">ถอนเงิน</a>
                    </c:if>
                </div>
            </div>

             <img class="profile-img" src="getUserImage?email=${User.email}" alt="รูปโปรไฟล์"/>
            <div>
                <p style="margin:0;">${sessionScope.User.firstName} ${sessionScope.User.lastName}</p>
                <ul class="roles">
                    <c:forEach var="role" items="${sessionScope.Roles}">
                        <li>${role}</li>
                    </c:forEach>
                </ul>
                <p></p>
                   <form action="logout" method="post">
                        <input type="submit"  class="logout-btn" value="ออกจากระบบ"/>
                    </form>
            </div>

        </div>
    </c:if>

    <!-- User not logged in -->
    <c:if test="${empty sessionScope.User}">
        <div class="dropdown">
            
            <a href="#">เข้าสู่ระบบ ▼</a>
            <div class="dropdown-content">
                <a href="goLogin">เข้าสู่ระบบ</a>
                <a href="goRegisterStu">ลงทะเบียน</a>
            </div>
        </div>
    </c:if>

</div>

<!-- Search Form -->
<form class="search-form" name="searchForm" action="search" method="get">
    <input type="text" name="keyword" placeholder="ค้นหาคอร์ส" />
    <input type="submit" value="ค้นหา" />
</form>

<!-- Content -->
 <div class="content-container">
<div class="content">
    <h2>คอร์สเปิดใหม่ล่าสุด</h2>
    <p class="message">${result_login}</p>
    <p class="message">${result_RegisTutor}</p>
    <p class="message">${result_review}</p>
    <p class="message">${message_completed}</p>

    <c:if test="${not empty latestCourses}">
        <div class="course-grid">
            <c:forEach var="course" items="${latestCourses}">
                <div class="course-card">
                    <div class="course-header">
                        <img src="getUserImage?email=${course.tutor.user.email}" alt="ติวเตอร์"/>
                        <div class="course-title">
                            <a href="getViewCourse?id=${course.courseId}">${course.courseName}</a>
                            <p class="tutor-name">ผู้สอน: ${course.tutor.user.firstName} ${course.tutor.user.lastName}</p>
                        </div>
                    </div>
                    <div class="course-body">
                        <c:if test="${not empty course.courseDates}">
                            <ul class="course-dates">
                                <c:forEach var="cd" items="${course.courseDates}">
                                    <li>วันที่สอน: <span>${cd.class_date}</span> เวลา <span>${cd.startTime} - ${cd.endTime}</span></li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <p class="course-price">ราคา: <span>${course.coursePrice} บาท</span></p>
                    </div>
                    <a href="getViewCourse?id=${course.courseId}" class="btn-view-course">ดูรายละเอียด</a>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>
</div>



</body>
</html>
