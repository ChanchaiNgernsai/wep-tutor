<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Course</title>
<style>
    body {
        background-color: #EBEBEB;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
    }

    /* Header */
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #007F3E;
        color: white;
        padding: 12px 25px;
        box-shadow: 0 3px 6px rgba(0,0,0,0.15);
    }

    .header img {
        width: 90px;
        height: 90px;
        object-fit: cover;
        margin-right: 15px;
        border-radius: 12px;
    }

    .header h2 {
        margin: 0;
        font-size: 32px;
        font-weight: bold;
    }
    .header a {
    color: white;          
    text-decoration: none; 
    font-weight: bold;
    font-size: 24px;     
}



   
    .message {
        text-align: center;
        margin: 10px 0 20px 0;
        font-style: italic;
        color: #c21030;
    }
    
    .result_message {
        text-align: center;
        margin: 10px 0 20px 0;
        font-style: italic;
        color: #10c228;
    }

    /* Center container */
    .center-container {
        background: #fff;
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    /* Left and right containers */
    .left-container {
        flex: 0.4;
        min-width: 300px;
    }
    .right-container {
        flex: 0.6;
        min-width: 400px;
        max-height: 80vh;
        overflow-y: auto;
    }

    /* ฟอร์มรีวิว */
    .course-review {
        background: #fafafa;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transition: 0.3s;
    }
    .course-review:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .course-header {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }
    .profile-img {
        border-radius: 50%;
        margin-right: 15px;
        border: 2px solid #4CAF50;
    }
    .course-info p {
        margin: 4px 0;
        color: #444;
    }

    textarea {
        width: 100%;
        border-radius: 8px;
        border: 1px solid #ccc;
        padding: 10px;
        font-size: 14px;
        resize: vertical;
        margin-top: 8px;
    }

    input[type="number"] {
        width: 80px;
        padding: 6px;
        border-radius: 6px;
        border: 1px solid #ccc;
        text-align: center;
    }

    button {
        background: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        margin-top: 10px;
        transition: 0.3s;
    }
    button:hover {
        background: #45a049;
    }
    
    .btn_cancel {
        background: #e42421;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        margin-top: 10px;
        transition: 0.3s;
    }
    button:hover {
        background: #45a049;
    }


    .review-box {
        border: 1px solid #ddd;
        padding: 15px;
        margin-bottom: 15px;
        border-radius: 12px;
        background-color: #fff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        transition: transform 0.2s;
    }
    .review-box:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    .review-header {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }
    .profile-img-reviewTutor {
        width: 60px;
        height: 60px;
        border-radius: 12%;
        object-fit: cover;
        margin-right: 15px;
        border: 1px solid #ccc;
    }
    .review-info p {
        margin: 2px 0;
    }
    .review-comment {
        margin: 10px 0;
        color: #333;
    }
    .review-link {
        text-decoration: none;
        color: #007bff;
        font-weight: bold;
    }
    .review-link:hover {
        text-decoration: underline;
    }
    .rating-box {
    display: flex;
    flex-direction: row-reverse;
    justify-content: flex-start;
}

.rating-box input[type="radio"] {
    display: none;
}

.rating-box label {
    font-size: 24px;
    color: #ccc;
    cursor: pointer;
    margin: 0 2px;
}

.rating-box input[type="radio"]:checked ~ label,
.rating-box label:hover,
.rating-box label:hover ~ label {
    color: #FFD700;
}



</style>

<script>
    const stars = document.querySelectorAll('.star');

    stars.forEach((star, idx) => {
        star.addEventListener('change', () => {
            if(star.checked) {
                for(let i=0; i<=idx; i++) {
                    stars[i].checked = true;
                }
            } else {
                for(let i=idx; i<stars.length; i++) {
                    stars[i].checked = false;
                }
            }
        });
    });

   function validateComment() {
    let comment = document.getElementById("comment").value.trim();

    const ratings = document.getElementsByName("score");
    let selected = false;

    for (let i = 0; i < ratings.length; i++) {
        if (ratings[i].checked) {
            selected = true;
            break;
        }
    }

    if (!selected) {
        alert("กรุณาเลือกจำนวนดาวก่อนส่ง ⭐");
        return false;
    }

    if (comment === "") {
        alert("กรุณากรอกข้อความรีวิว");
        return false;
    }

    
    if (comment.length > 255) {
        alert("ข้อความรีวิวต้องไม่เกิน 255 ตัวอักษร");
        return false;
    }

    
    let regex = /^[A-Za-zก-๙0-9\s.,!?]+$/;
    if (!regex.test(comment)) {
        alert("ข้อความรีวิวต้องเป็นตัวอักษรภาษาไทยหรืออังกฤษเท่านั้น");
        return false;
    }

    return true;
}
</script>
</head>
<body>

    <div class="header">
        <a href="goHome">รีวิวคอร์ส</a>
    </div>
    <br>


    <c:if test="${not empty resultReview}">
        <p class="result_message">${resultReview}</p>
    </c:if>
    <c:if test="${not empty err_result}">
        <p class="message">${err_result}</p>
    </c:if>
    <c:if test="${not empty err_Reviewcom}">
        <p class="message">${err_Reviewcom}</p>
    </c:if>

    <div class="center-container">


        <div class="right-container"> 
            <h2>รีวิวจากผู้เรียน</h2>

            <c:if test="${not empty reviews}">
                <c:forEach var="rev" items="${reviews}">
                    <div class="review-box">
                        <div class="review-header">
                            <img class="profile-img-reviewTutor" src="getUserImage?email=${rev.course.tutor.user.email}" alt="Tutor Image" />
                            <div class="review-info">
                                <p><strong>คอร์ส:</strong> ${rev.course.courseName}</p>
                                <p><strong>คะแนน:</strong> ${rev.score} / 5.0</p>
                            </div>
                        </div>
                        <p class="review-comment"><strong>รีวิว:</strong> ${rev.comment}</p>
                        <a class="review-link" href="getViewCourse?id=${rev.course.courseId}">ดูคอร์ส</a>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty reviews}">
                <p style="text-align:center; color:#666;">ยังไม่มีรีวิว</p>
            </c:if>
        </div>

        <div class="left-container">
            <div class="course-review">
                <div class="course-header">
                    <img class="profile-img" src="getUserImage?email=${course.tutor.user.email}" alt="Profile Image" height="80" width="80"/>
                    <div class="course-info">
                        <p><strong>ชื่อคอร์ส:</strong> ${course.courseName}</p>
                        <p><strong>รายละเอียด:</strong> ${course.courseDescription}</p>
                        <p><strong>ราคา:</strong> ${course.coursePrice} บาท</p>
                         <p><strong>วันที่สอน:</strong></p>
                            
                                <c:forEach var="cd" items="${course.courseDates}">
                                    <li>
                                        ${cd.class_date} เวลา ${cd.startTime} - ${cd.endTime} (หัวข้อ: ${cd.topic})
                                    </li>
                                </c:forEach>
                            
                    </div>
                </div>
                <c:if test="${not empty student}">
                    <form action="addReviewCourse" method="post" onsubmit="return validateComment()">
                        <input type="hidden" name="courseId" value="${course.courseId}" />
                        <input type="hidden" name="student" value="${student.user.email}" />
                        <div class="rating-box">
                            <c:forEach var="i" begin="1" end="5">
                                <input type="radio" name="score" value="${6-i}" id="score${i}" class="star" />
                                <label for="score${i}">★</label>
                            </c:forEach>

                        </div>
                        <textarea name="comment" id="comment" rows="4" placeholder="เขียนรีวิวที่นี่..."></textarea>
                        <br>
                        <button type="submit">ส่งรีวิว</button>
                        <input type="button" class="btn_cancel" value="ยกเลิก" onclick="history.back();"> 
                    </form>
                </c:if>
                <c:if test="${empty student}">
                    <p style="text-align:center; color:#888; margin-top:20px;">เข้าสู่ระบบเพื่อเขียนรีวิว</p>
                </c:if>
            </div>
        </div>
    </div>
    <div style="text-align: center; margin: 20px 0; color: #aaa;">
        &copy; 2024 ช่วยติวในมหาวิทยาลัยแม่โจ้
    </div>
</body>
</html>
