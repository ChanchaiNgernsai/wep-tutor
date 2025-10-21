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
* { box-sizing: border-box; margin: 0; padding: 0; }
	body {
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		background: #f0f2f5;
		display: flex;
		justify-content: center;
		align-items: center;
		min-height: 100vh;
		padding: 20px;
	}

	.main-container {
		display: flex;
		max-width: 900px;
		width: 100%;
		border-radius: 16px;
		overflow: hidden;
		box-shadow: 0 8px 20px rgba(0,0,0,0.15);
		background: white;
	}


	.left-container {
    flex: 0 0 28%;
    background: linear-gradient(135deg, #6a11cb, #2575fc);
    color: #fff;
    padding: 20px 20px;          /* ลด padding ด้านบน */
    display: flex;
    flex-direction: column;
    align-items: center;         /* อยู่กลางแนวนอน */
    justify-content: flex-start; /* ชิดด้านบน */
}

.home-img, .login-img {
    width: 100px;               
    height: 100px;
    border-radius: 50%;         
    object-fit: cover;          
    transition: transform 0.3s, box-shadow 0.3s, filter 0.3s;
    cursor: pointer;
    margin-top: 10px;           /* เว้นระยะจากบน container */
}



	.right-container {
		flex: 1;
		background: #ffffff;
		padding: 40px 50px;
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	h1 {
		font-size: 2.4rem;
		margin-bottom: 30px;
		color: #ff6a88;
		font-weight: 700;
		text-align: center;
	}


	input[type="text"],
	input[type="password"],
	input[type="file"],
	select {
		width: 100%;
		padding: 12px 14px;
		margin-bottom: 20px;
		border: 2px solid #ddd;
		border-radius: 8px;
		font-size: 1rem;
		transition: border-color 0.3s;
	}
	input[type="text"]:focus,
	input[type="password"]:focus,
	input[type="file"]:focus,
	select:focus {
		border-color: #ff6a88;
		outline: none;
	}

	::placeholder {
		color: #aaa;
		font-style: italic;
	}


	.btn-group {
		display: flex;
		justify-content: space-between;
		gap: 15px;
	}
	input[type="submit"], input[type="reset"] {
		flex: 1;
		padding: 14px 0;
		border-radius: 10px;
		font-weight: 600;
		font-size: 1rem;
		border: none;
		cursor: pointer;
		transition: 0.3s;
		box-shadow: 0 4px 12px rgba(0,0,0,0.12);
	}
	input[type="submit"] {
		background: linear-gradient(135deg, #42e695, #3bb2b8);
		color: #fff;
	}
	input[type="submit"]:hover {
		opacity: 0.9;
		box-shadow: 0 6px 18px rgba(255,106,136,0.5);
	}
	input[type="reset"] {
		background: linear-gradient(135deg, #ff6a88, #ff99ac);
		color: #fff;
	}
	input[type="reset"]:hover {
		opacity: 0.9;
	}


	span.error { color: #d32f2f; font-weight: 600; font-size: 0.9rem; display: block; margin-bottom: 5px; }


	.email-wrapper {
		position: relative;
		width: 100%;
	}
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

	
	.radio-group {
		margin-bottom: 20px;
		font-size: 1rem;
	}
	.radio-group label { margin-right: 20px; }
	.home-img, .login-img {
		width: 100px;               
		height: 100px;
		border-radius: 50%;         
		object-fit: cover;          
		transition: transform 0.3s, box-shadow 0.3s, filter 0.3s;
		cursor: pointer;
	}

	
	.home-img:hover, .login-img:hover {
		transform: scale(1.05);                     
		box-shadow: 0 6px 15px rgba(0,0,0,0.2);    
		filter: brightness(1.1);                    
	}

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
<div class="main-container">
    <div class="left-container">
        <a href="goHome"><img class="home-img" src="resources/images/home_off.png" alt="Home" height="120" width="120"/></a>
        <a href="goLogin" ><img class="login-img" src="resources/images/login_off.png" alt="Login"height="120" width="120"/></a>
    </div>

    <div class="right-container">
        <h1>Register Student</h1>
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
                <span class="email-domain">@mju.ac.th</span>
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
        </form>
    </div>
</div>
</body>
</html>
