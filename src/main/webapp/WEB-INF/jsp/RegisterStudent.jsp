<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Student</title>

<style>
body {
    font-family: "Prompt", Arial, sans-serif;
    background-color: #f0f2f5;
    margin: 0;
    padding: 0;
}

/* --- Header --- */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #007F3E;
    color: white;
    padding: 20px 35px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.15);
}
.header h1 {
    margin: 0;
    font-size: 24px;
    cursor: pointer;
}
.header a { color: white; text-decoration: none; font-weight: bold; }

/* --- Form Container --- */
.container {
    max-width: 450px;
    margin: 40px auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    padding: 40px;
}

/* --- Form --- */
h2 {
    text-align: center;
    color: #007F3E;
    margin-bottom: 25px;
}

input[type="text"],
input[type="password"],
input[type="file"],
select {
    width: 100%;
    padding: 12px 14px;
    margin-bottom: 20px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
}
input[type="text"]:focus,
input[type="password"]:focus,
input[type="file"]:focus,
select:focus {
    border-color: #007F3E;
    outline: none;
}

/* --- Buttons --- */
.btn-group {
    display: flex;
    justify-content: space-between;
}
input[type="submit"], input[type="reset"] {
    width: 48%;
    padding: 12px;
    border-radius: 8px;
    border: none;
    font-weight: bold;
    cursor: pointer;
}
input[type="submit"] {
    background-color: #007F3E;
    color: white;
}
input[type="reset"] {
    background-color: #d9363e;
    color: white;
}
input[type="submit"]:hover { background-color: #005f2e; }
input[type="reset"]:hover { background-color: #a01b22; }

/* --- Error Messages --- */
span.error {
    color: #d32f2f;
    font-weight: bold;
    text-align: left;
    display: block;
    margin-bottom: 5px;
}

/* --- Email Domain Styling --- */
.email-wrapper { position: relative; width: 100%; }
.email-domain {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    color: #555;
    pointer-events: none;
    user-select: none;
    font-weight: 600;
}

/* --- Radio Buttons --- */
.radio-group { margin-bottom: 20px; font-size: 14px; }
.radio-group label { margin-right: 20px; }

.register-link {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #007F3E;
    font-weight: bold;
    text-decoration: none;
}
.register-link:hover { text-decoration: underline; }

</style>


<script>

function validate(frm1) {
    // รหัสนักศึกษา
    var stuId = frm1.student_id.value.trim();
    var stuIdPattern = /^\d{10}$/;
    document.getElementById('err_stu_id').innerHTML = "";
    if (stuId === "") { document.getElementById('err_stu_id').innerHTML = "กรุณากรอกรหัสนักศึกษา"; frm1.student_id.focus(); return false; }
    if (!stuIdPattern.test(stuId)) { document.getElementById('err_stu_id').innerHTML = "กรุณากรอกเป็นตัวเลข 10 ตัวเท่านั้น"; frm1.student_id.focus(); return false; }

    // ชื่อ
    var fname = frm1.fname.value.trim();
    var fnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,40}$/;
    document.getElementById('err_fname').innerHTML = "";
    if (fname === "") { document.getElementById('err_fname').innerHTML = "กรุณากรอกชื่อ"; frm1.fname.focus(); return false; }
    if (!fnamePattern.test(fname)) { document.getElementById('err_fname').innerHTML = "ชื่อต้องเป็นภาษาไทยหรืออังกฤษ ความยาว 2-40 ตัวอักษร"; frm1.fname.focus(); return false; }

    // นามสกุล
    var lname = frm1.lname.value.trim();
    var lnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,85}$/;
    document.getElementById('err_lname').innerHTML = "";
    if (lname === "") { document.getElementById('err_lname').innerHTML = "กรุณากรอกนามสกุล"; frm1.lname.focus(); return false; }
    if (!lnamePattern.test(lname)) { document.getElementById('err_lname').innerHTML = "นามสกุลต้องเป็นภาษาไทยหรืออังกฤษ ความยาว 2-85 ตัวอักษร"; frm1.lname.focus(); return false; }

    // เบอร์โทร
    var phone = frm1.phon_num.value.trim();
    var phonePattern = /^(06|07|08|09)\d{8}$/;
    document.getElementById('err_phone').innerHTML = "";
    if (phone === "") { document.getElementById('err_phone').innerHTML = "กรุณากรอกเบอร์โทรศัพท์"; frm1.phon_num.focus(); return false; }
    if (/\s/.test(phone)) { document.getElementById('err_phone').innerHTML = "เบอร์โทรต้องไม่มีช่องว่าง"; frm1.phon_num.focus(); return false; }
    if (!phonePattern.test(phone)) { document.getElementById('err_phone').innerHTML = "เบอร์โทรต้องขึ้นต้นด้วย 06,07,08,09 และมี 10 หลักเท่านั้น"; frm1.phon_num.focus(); return false; }

    // ชั้นปี
    var yfs = frm1.yfs.value.trim();
    document.getElementById('err_yfs').innerHTML = "";
    if (yfs === "") { document.getElementById('err_yfs').innerHTML = "กรุณาเลือกชั้นปี"; frm1.yfs.focus(); return false; }

    // Email
    var emailPrefix = frm1.email_prefix.value.trim();
    var fullEmail = emailPrefix + "@mju.ac.th";
    document.getElementById('err_email').innerHTML = "";
    frm1.email.value = fullEmail;
    var emailPrefixPattern = /^MJU\d{10}$/i;
    if (emailPrefix === "") { document.getElementById('err_email').innerHTML = "กรุณากรอกอีเมล"; frm1.email_prefix.focus(); return false; }
    if (/\s/.test(emailPrefix)) { document.getElementById('err_email').innerHTML = "ห้ามมีช่องว่างในอีเมล"; frm1.email_prefix.focus(); return false; }
    if (emailPrefix.length !== 13) { document.getElementById('err_email').innerHTML = "อีเมลก่อน @ ต้องมีความยาว 13 ตัว"; frm1.email_prefix.focus(); return false; }
    if (!emailPrefixPattern.test(emailPrefix)) { document.getElementById('err_email').innerHTML = "รูปแบบอีเมลไม่ถูกต้อง เช่น MJU65******01"; frm1.email_prefix.focus(); return false; }

    // Password
    var password = frm1.password.value;
    document.getElementById('err_password').innerHTML = "";
    if (password.trim() === "") { document.getElementById('err_password').innerHTML = "กรุณากรอกรหัสผ่าน"; frm1.password.focus(); return false; }
    if (password.length < 8 || password.length > 16) { document.getElementById('err_password').innerHTML = "รหัสผ่านต้องมีความยาว 8-16 ตัวอักษร"; frm1.password.focus(); return false; }
    var allowedChars = /^[A-Za-z0-9!#_.]+$/;
    if (!allowedChars.test(password)) { document.getElementById('err_password').innerHTML = "รหัสผ่านอนุญาตเฉพาะ A-Z,a-z,0-9 และ ! # _ ."; frm1.password.focus(); return false; }
    if (/\s/.test(password)) { document.getElementById('err_password').innerHTML = "รหัสผ่านห้ามมีช่องว่าง"; frm1.password.focus(); return false; }
    if (!(/[A-Z]/.test(password) && /[a-z]/.test(password) && /[0-9]/.test(password))) { document.getElementById('err_password').innerHTML = "รหัสผ่านต้องมีพิมพ์ใหญ่,พิมพ์เล็ก และตัวเลข"; frm1.password.focus(); return false; }

    // Image
    var imgInput = frm1.image;
    document.getElementById('err_image').innerHTML = "";
    if (imgInput.files.length === 0) { document.getElementById('err_image').innerHTML = "* กรุณาเลือกไฟล์รูปภาพ"; imgInput.focus(); return false; }
    var file = imgInput.files[0];
    var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
    if (!allowedExtensions.exec(file.name)) { document.getElementById('err_image').innerHTML = "* ไฟล์ต้องเป็น .jpg, .jpeg, .png หรือ .gif เท่านั้น"; imgInput.focus(); return false; }
    if (file.size > 5*1024*1024) { document.getElementById('err_image').innerHTML = "* ขนาดไฟล์ต้องไม่เกิน 5MB"; imgInput.focus(); return false; }

    return true;
}
</script>

</head>
<body>

<!-- Header -->
<div class="header">
    <a href="goHome"><h1>ลงทะเบียนสมาชิกใหม่</h1></a>
</div>

<!-- Register Form -->
<div class="container">
    <h2>ลงทะเบียนสมาชิกใหม่</h2>
    <p class="error">${err_result}</p>

    <form name="frm1" action="addRegisterStu" method="post" enctype="multipart/form-data" onsubmit="return validate(this);">

        <span class="error" id="err_stu_id"></span>
        <input type="text" name="student_id" id="student_id" placeholder="Student ID">

        <span class="error" id="err_fname"></span>
        <input type="text" name="fname" id="fname" placeholder="First Name">

        <span class="error" id="err_lname"></span>
        <input type="text" name="lname" id="lname" placeholder="Last Name">

        <span class="error" id="err_phone"></span>
        <input type="text" name="phon_num" id="phon_num" placeholder="Phone Number">

        <span class="error" id="err_yfs"></span>
        <select name="yfs" id="yfs">
            <option value="">-- เลือกชั้นปี --</option>
            <option value="ชั้นปีที่ 1">ชั้นปีที่ 1</option>
            <option value="ชั้นปีที่ 2">ชั้นปีที่ 2</option>
            <option value="ชั้นปีที่ 3">ชั้นปีที่ 3</option>
            <option value="ชั้นปีที่ 4">ชั้นปีที่ 4</option>
        </select>

        <span class="error" id="err_email"></span>
        <div class="email-wrapper">
            <input type="text" name="email_prefix" id="email_prefix" placeholder="Email (เช่น MJU6512345678)">
            <span class="email-domain" style="position:absolute; right:12px; top:50%; transform: translateY(-90%); color:#555;">@mju.ac.th</span>
            <input type="hidden" name="email" id="email">
        </div>

        <span class="error" id="err_password"></span>
        <input type="password" name="password" id="password" placeholder="Password">

        <div class="radio-group">
            <label><input type="radio" name="gender" value="man" checked> Man</label>
            <label><input type="radio" name="gender" value="women"> Women</label>
        </div>

        <span class="error" id="err_image"></span>
        <input type="file" name="image" id="image">

        <div class="btn-group">
            <input type="reset" value="ยกเลิก" onclick="window.location.href='goHome';">
            <input type="submit" value="ลงทะเบียน">
        </div>

        <a class="register-link" href="goLogin">กลับหน้า Login</a>
    </form>
</div>

</body>
</html>
