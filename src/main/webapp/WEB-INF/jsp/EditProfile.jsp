<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<style>
    body {
        background: linear-gradient(135deg, #e0f7fa, #e8f5e9);
        font-family: "Prompt", "Segoe UI", Tahoma, sans-serif;
        margin: 0;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .main-container {
        width: 100%;
        max-width: 720px;
        background: #ffffff;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        padding: 40px 50px;
        display: flex;
        flex-direction: column;
        align-items: center;
        animation: fadeIn 0.6s ease;
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(10px);}
        to {opacity: 1; transform: translateY(0);}
    }

    h1 {
        color: #00bfa5;
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 25px;
        text-align: center;
        letter-spacing: 0.5px;
    }

    .profile-img {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border-radius: 50%;
        margin-bottom: 20px;
        border: 4px solid #00bfa5;
        transition: transform 0.3s ease;
    }

    .profile-img:hover {
        transform: scale(1.05);
    }

    form {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    input[type="text"],
    input[type="file"],
    select {
        width: 100%;
        padding: 12px 15px;
        margin: 8px 0 15px 0;
        border: 2px solid #d0d0d0;
        border-radius: 10px;
        font-size: 1rem;
        color: #333;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
        box-sizing: border-box;
        background: #fafafa;
    }

    input[type="text"]:focus,
    input[type="file"]:focus,
    select:focus {
        border-color: #00bfa5;
        box-shadow: 0 0 5px rgba(0,191,165,0.3);
        outline: none;
        background: #fff;
    }

    input::placeholder {
        color: #9e9e9e;
        font-style: italic;
    }

    .btn-group {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 20px;
        width: 100%;
    }

    input[type="submit"],
    input[type="button"] {
        flex: 1;
        padding: 12px 0;
        font-weight: 700;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 1rem;
        color: #fff;
        transition: all 0.3s ease;
        box-shadow: 0 5px 12px rgba(0,0,0,0.15);
    }

    input[type="submit"] {
        background: linear-gradient(135deg, #00bfa5, #1de9b6);
    }

    input[type="submit"]:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 15px rgba(0,191,165,0.3);
    }

    input[type="button"] {
        background: linear-gradient(135deg, #ff6a88, #ff99ac);
    }

    input[type="button"]:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 15px rgba(255,105,135,0.3);
    }

    span.error {
        color: #e53935;
        font-size: 0.9rem;
        margin-bottom: 5px;
        display: block;
        width: 100%;
        text-align: left;
        animation: fadeIn 0.3s ease;
    }

    #err_image {
        margin-bottom: 10px;
    }

    .error-msg {
        color: #e53935;
        width: 100%;
        text-align: left;
        margin-top: 5px;
    }
</style>

<script>
    // Validation script (เหมือนเดิม)
    function validate(frm1) {
        var stuId = frm1.student_id?.value?.trim?.() ?? "";
        var stuIdPattern = /^\d{10}$/;
        if(document.getElementById('err_stu_id')) document.getElementById('err_stu_id').innerHTML = "";
        if(stuId && !stuIdPattern.test(stuId)){
            document.getElementById('err_stu_id').innerHTML = "กรุณากรอกเป็นตัวเลข 10 ตัวเท่านั้น";
            frm1.student_id.focus();
            return false;
        }

        var fname = frm1.fname.value.trim();
        var fnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,40}$/;
        document.getElementById('err_fname').innerHTML = "";
        if(fname === ""){
            document.getElementById('err_fname').innerHTML = "กรุณากรอกชื่อ";
            frm1.fname.focus();
            return false;
        }
        if(!fnamePattern.test(fname)){
            document.getElementById('err_fname').innerHTML = "ชื่อต้องเป็นภาษาไทยหรืออังกฤษ 2-40 ตัวอักษร";
            frm1.fname.focus();
            return false;
        }

        var lname = frm1.lname.value.trim();
        var lnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,85}$/;
        document.getElementById('err_lname').innerHTML = "";
        if(lname === ""){
            document.getElementById('err_lname').innerHTML = "กรุณากรอกนามสกุล";
            frm1.lname.focus();
            return false;
        }
        if(!lnamePattern.test(lname)){
            document.getElementById('err_lname').innerHTML = "นามสกุลต้องเป็นภาษาไทยหรืออังกฤษ 2-85 ตัวอักษร";
            frm1.lname.focus();
            return false;
        }

        var phone = frm1.phon_num.value.trim();
        var phonePattern = /^(06|07|08|09)\d{8}$/;
        document.getElementById('err_phone').innerHTML = "";
        if(phone === ""){
            document.getElementById('err_phone').innerHTML = "กรุณากรอกเบอร์โทรศัพท์";
            frm1.phon_num.focus();
            return false;
        }
        if(/\s/.test(phone)){
            document.getElementById('err_phone').innerHTML = "เบอร์โทรต้องไม่มีช่องว่าง";
            frm1.phon_num.focus();
            return false;
        }
        if(!phonePattern.test(phone)){
            document.getElementById('err_phone').innerHTML = "เบอร์โทรต้องขึ้นต้น 06-09 และมี 10 หลัก";
            frm1.phon_num.focus();
            return false;
        }

        var yfs = frm1.yfs.value.trim();
        document.getElementById('err_yfs').innerHTML = "";
        if(yfs === ""){
            document.getElementById('err_yfs').innerHTML = "กรุณาเลือกชั้นปี";
            frm1.yfs.focus();
            return false;
        }

        var imgInput = frm1.image;
        document.getElementById('err_image').innerHTML = "";
        if(imgInput.files.length > 0){
            var file = imgInput.files[0];
            var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
            if(!allowedExtensions.exec(file.name)){
                document.getElementById('err_image').innerHTML = "*ไฟล์ต้องเป็น .jpg, .jpeg, .png หรือ .gif เท่านั้น";
                imgInput.focus();
                return false;
            }
            var maxSize = 5 * 1024 * 1024; // 5MB
            if(file.size > maxSize){
                document.getElementById('err_image').innerHTML = "*ขนาดไฟล์ต้องไม่เกิน 5MB";
                imgInput.focus();
                return false;
            }
        }

        return true;
    }

    function previewImage(event) {
        const input = event.target;
        const preview = document.getElementById("preview");
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</head>
<body>
<div class="main-container">
    <h1>แก้ไขโปรไฟล์</h1>
    <img id="preview" class="profile-img" src="getUserImage?email=${User.email}" alt="Profile Image"/>

    <form name="frm1" action="editProfile" method="post" onsubmit="return validate(this);" enctype="multipart/form-data">
        <input type="hidden" name="email" value="${User.email}">

        <span class="error" id="err_fname"></span>
        <input type="text" name="fname" id="fname" placeholder="ชื่อ" value="${User.firstName}">

        <span class="error" id="err_lname"></span>
        <input type="text" name="lname" id="lname" placeholder="นามสกุล" value="${User.lastName}">

        <span class="error" id="err_phone"></span>
        <input type="text" name="phon_num" id="phon_num" placeholder="เบอร์โทรศัพท์" value="${User.phoneNumber}">

        <span class="error" id="err_yfs"></span>
        <select name="yfs" id="yfs">
            <option value="">-- เลือกชั้นปี --</option>
            <option value="Y1" ${Stu.yearOfStudy == 'ชั้นปีที่ 1' ? 'selected' : ''}>ชั้นปีที่ 1</option>
            <option value="Y2" ${Stu.yearOfStudy == 'ชั้นปีที่ 2' ? 'selected' : ''}>ชั้นปีที่ 2</option>
            <option value="Y3" ${Stu.yearOfStudy == 'ชั้นปีที่ 3' ? 'selected' : ''}>ชั้นปีที่ 3</option>
            <option value="Y4" ${Stu.yearOfStudy == 'ชั้นปีที่ 4' ? 'selected' : ''}>ชั้นปีที่ 4</option>
        </select>

        <span class="error" id="err_image"></span>
        <input type="file" name="image" id="image" accept="image/*" onchange="previewImage(event)">

        <div class="error-msg">${error_edit}</div>

        <div class="btn-group">
            <input type="button" value="ย้อนกลับ" onclick="history.back();"> 
            <input type="submit" value="บันทึก">
        </div>
    </form>
</div>
</body>
</html>
