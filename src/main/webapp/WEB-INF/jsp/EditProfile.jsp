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
        background-color: #EBEBEB;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        color: #222;
        margin: 0;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 15px;
        font-size: 0.8rem;
    }
    .main-container {
        display: flex;
        gap: 20px;
        max-width: 720px;
        width: 100%;
        background-color: #ffffffcc;
        border-radius: 12px;
        box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        padding: 20px 30px;
    }
    .left-container {
        flex: 0 0 18%;
        background-color: #CECECE;
        border-radius: 10px;
        box-shadow: 0 1.5px 8px rgba(0,0,0,0.12);
        padding: 20px 15px;
        display: flex;
        flex-direction: column;
        font-weight: 600;
        color: #e1f5fe;
        font-size: 0.9rem;
    }
    .left-container a {
        color: #333333;
        text-decoration: none;
        font-size: 0.85rem;
        border-left: 3px solid transparent;
        padding-left: 8px;
        transition: border-color 0.3s ease, color 0.3s ease;
    }
    .left-container a:hover {
        border-left: 3px solid #ffffff;
        color: #fff;
    }
    .right-container {
        flex: 1;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 1.5px 8px rgba(0,0,0,0.1);
        padding: 30px 40px;
        display: flex;
        flex-direction: column;
    }
    h1 {
        margin-bottom: 20px;
        color: #EB5353;
        font-weight: 700;
        font-size: 1.8rem;
        letter-spacing: 1px;
        text-align: center;
    }
    form {
        display: flex;
        flex-direction: column;
    }
    input[type="text"],
    input[type="file"],
    select {
        width: 100%;
        padding: 10px 12px;
        margin: 8px 0 15px 0;
        border: 2px solid #A1A1A1;
        border-radius: 6px;
        font-size: 0.9rem;
        color: #222;
        box-sizing: border-box;
        transition: border-color 0.3s ease;
    }
    input[type="text"]:focus,
    input[type="file"]:focus,
    select:focus {
        border-color: #0288d1;
        outline: none;
    }
    input::placeholder {
        color: #90a4ae;
        font-style: italic;
        font-size: 0.85rem;
    }
    .btn-group {
        display: flex;
        justify-content: space-between;
        gap: 10px;
    }
    input[type="submit"],
    input[type="reset"] {
        flex: 1;
        padding: 10px 0;
        font-weight: 700;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.9rem;
        transition: background-color 0.25s ease, box-shadow 0.25s ease;
        box-shadow: 0 3px 9px rgba(0,0,0,0.12);
    }
    input[type="submit"] {
        background-color: #04BE43;
        color: #fff;
    }
    input[type="submit"]:hover {
        background-color: #01579b;
        box-shadow: 0 4px 12px rgba(1, 87, 155, 0.7);
    }
    input[type="reset"] {
        background-color: #b0bec5;
        color: #37474f;
    }
    input[type="reset"]:hover {
        background-color: #78909c;
        color: #eceff1;
    }
    span.error {
        color: #d32f2f;
        font-size: 0.8rem;
        margin-bottom: 4px;
        display: block;
    }
    .email-wrapper {
        position: relative;
        width: 100%;
        max-width: none;
    }
    .email-wrapper input[type="text"] {
        width: 100%;
        padding-right: 90px;
        box-sizing: border-box;
        font-size: 0.9rem;
    }
    .email-domain {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: #555;
        pointer-events: none;
        user-select: none;
        font-weight: 600;
        font-style: normal;
        font-size: 0.9rem;
    }
</style>

<script>
function validate(frm1) {
    var stuId = frm1.student_id.value.trim();
    var stuIdPattern = /^\d{10}$/;
    document.getElementById('err_stu_id').innerHTML = "";
    if(stuId === ""){
        document.getElementById('err_stu_id').innerHTML = "* กรุณากรอกรหัสนักศึกษา";
        frm1.student_id.focus();
        return false;
    }
    if(!stuIdPattern.test(stuId)){
        document.getElementById('err_stu_id').innerHTML = "*กรุณากรอกเป็นตัวเลข 10 ตัวเท่านั้น";
        frm1.student_id.focus();
        return false;
    }

    var fname = frm1.fname.value.trim();
    var fnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,40}$/;
    document.getElementById('err_fname').innerHTML = "";
    if(fname === ""){
        document.getElementById('err_fname').innerHTML = "*กรุณากรอกชื่อ";
        frm1.fname.focus();
        return false;
    }
    if(!fnamePattern.test(fname)){
        document.getElementById('err_fname').innerHTML = "*ชื่อต้องเป็นภาษาไทยหรืออังกฤษ 2-40 ตัวอักษร";
        frm1.fname.focus();
        return false;
    }

    var lname = frm1.lname.value.trim();
    var lnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,85}$/;
    document.getElementById('err_lname').innerHTML = "";
    if(lname === ""){
        document.getElementById('err_lname').innerHTML = "*กรุณากรอกนามสกุล";
        frm1.lname.focus();
        return false;
    }
    if(!lnamePattern.test(lname)){
        document.getElementById('err_lname').innerHTML = "*นามสกุลต้องเป็นภาษาไทยหรืออังกฤษ 2-85 ตัวอักษร";
        frm1.lname.focus();
        return false;
    }

    var phone = frm1.phon_num.value.trim();
    var phonePattern = /^(06|07|08|09)\d{8}$/;
    document.getElementById('err_phone').innerHTML = "";
    if(phone === ""){
        document.getElementById('err_phone').innerHTML = "*กรุณากรอกเบอร์โทรศัพท์";
        frm1.phon_num.focus();
        return false;
    }
    if(/\s/.test(phone)){
        document.getElementById('err_phone').innerHTML = "*เบอร์โทรต้องไม่มีช่องว่าง";
        frm1.phon_num.focus();
        return false;
    }
    if(!phonePattern.test(phone)){
        document.getElementById('err_phone').innerHTML = "*เบอร์โทรต้องขึ้นต้น 06-09 และมี 10 หลัก";
        frm1.phon_num.focus();
        return false;
    }

    var yfs = frm1.yfs.value.trim();
    document.getElementById('err_yfs').innerHTML = "";
    if(yfs === ""){
        document.getElementById('err_yfs').innerHTML = "*กรุณาเลือกชั้นปี";
        frm1.yfs.focus();
        return false;
    }

    // var imgInput = frm1.image;
    // document.getElementById('err_image').innerHTML = "";
    // if(imgInput.files.length > 0){
    //     var file = imgInput.files[0];
    //     var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
    //     if(!allowedExtensions.exec(file.name)){
    //         document.getElementById('err_image').innerHTML = "*ไฟล์ต้องเป็น .jpg, .jpeg, .png หรือ .gif เท่านั้น";
    //         imgInput.focus();
    //         return false;
    //     }
    //     var maxSize = 5 * 1024 * 1024;
    //     if(file.size > maxSize){
    //         document.getElementById('err_image').innerHTML = "*ขนาดไฟล์ต้องไม่เกิน 5MB";
    //         imgInput.focus();
    //         return false;
    //     }
    // }

    return true;
}
</script>
</head>
<body>
<div class="main-container">
    <div class="left-container">
        <a href="goHome">&#8592; กลับหน้า Home</a>
    </div>

    <div class="right-container">
        <h1>Edit Profile</h1>
        <form name="frm1" action="editProfile" method="post" onsubmit="return validate(this);">
            <input type="hidden" name="email" value="${User.email}">
            
            <span class="error" id="err_stu_id"></span>
            <input type="text" name="student_id" id="student_id" placeholder="Student ID" value="${Stu.studentId}">

            <span class="error" id="err_fname"></span>
            <input type="text" name="fname" id="fname" placeholder="First Name" value="${User.firstName}">

            <span class="error" id="err_lname"></span>
            <input type="text" name="lname" id="lname" placeholder="Last Name" value="${User.lastName}">

            <span class="error" id="err_phone"></span>
            <input type="text" name="phon_num" id="phon_num" placeholder="Phone Number" value="${User.phoneNumber}">

            <span class="error" id="err_yfs"></span>
            <select name="yfs" id="yfs">
                <option value="">-- เลือกชั้นปี --</option>
                <option value="Y1" ${Stu.yearOfStudy == 'Y1' ? 'selected' : ''}>ชั้นปีที่ 1</option>
                <option value="Y2" ${Stu.yearOfStudy == 'Y2' ? 'selected' : ''}>ชั้นปีที่ 2</option>
                <option value="Y3" ${Stu.yearOfStudy == 'Y3' ? 'selected' : ''}>ชั้นปีที่ 3</option>
                <option value="Y4" ${Stu.yearOfStudy == 'Y4' ? 'selected' : ''}>ชั้นปีที่ 4</option>
            </select>

            <span class="error" id="err_image"></span>
            <input type="file" name="image" id="image">

             
            <div style="color:red;">${error_edit}</div>
        
            <div class="btn-group">
                <input type="reset" value="ยกเลิก">
                <input type="submit" value="บันทึก">
            </div>
        </form>
    </div>
</div>
</body>
</html>
