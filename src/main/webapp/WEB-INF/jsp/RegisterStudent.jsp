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
</head>
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
		  padding: 15px; /* ลดจาก 20px */
		  font-size: 0.8rem; /* ลดฟอนต์ลง */
		}
		
		.main-container {
		  display: flex;
		  gap: 20px; /* ลดจาก 30px */
		  max-width: 720px; /* ลดจาก 900px */
		  width: 100%;
		  background-color: #ffffffcc;
		  border-radius: 12px; /* ลดจาก 16px */
		  box-shadow: 0 6px 15px rgba(0,0,0,0.15); /* ลดความเบลอ */
		  padding: 20px 30px; /* ลดจาก 30px 40px */
		}
		
		.left-container {
		  flex: 0 0 18%; /* ลดจาก 22% */
		  background-color: #CECECE;
		  border-radius: 10px; /* ลดจาก 12px */
		  box-shadow: 0 1.5px 8px rgba(0,0,0,0.12);
		  padding: 20px 15px; /* ลดจาก 25px 20px */
		  display: flex;
		  flex-direction: column;
		  font-weight: 600;
		  color: #e1f5fe;
		  font-size: 0.9rem;
		}
		
		.left-container a {
		  color: #333333;
		  text-decoration: none;
		  font-size: 0.85rem; /* ลดจาก 1.05rem */
		  border-left: 3px solid transparent; /* ลดจาก 4px */
		  padding-left: 8px; /* ลดจาก 10px */
		  transition: border-color 0.3s ease, color 0.3s ease;
		}
		
		.left-container a:hover {
		  border-left: 3px solid #ffffff;
		  color: #fff;
		}
		
		.right-container {
		  flex: 1;
		  background-color: #ffffff;
		  border-radius: 10px; /* ลดจาก 12px */
		  box-shadow: 0 1.5px 8px rgba(0,0,0,0.1);
		  padding: 30px 40px; /* ลดจาก 40px 50px */
		  display: flex;
		  flex-direction: column;
		}
		
		h1 {
		  margin-bottom: 20px; /* ลดจาก 30px */
		  color: #EB5353;
		  font-weight: 700;
		  font-size: 1.8rem; /* ลดจาก 2.4rem */
		  letter-spacing: 1px; /* ลดจาก 1.1px */
		  text-align: center;
		}
		
		form {
		  display: flex;
		  flex-direction: column;
		}
		
		input[type="text"],
		input[type="password"],
		input[type="file"],
		select {
		  width: 100%;
		  padding: 10px 12px; /* ลดจาก 14px 16px */
		  margin: 8px 0 15px 0; /* ลดจาก 12px 0 20px 0 */
		  border: 2px solid #A1A1A1;
		  border-radius: 6px; /* ลดจาก 8px */
		  font-size: 0.9rem; /* ลดจาก 1.05rem */
		  color: #222;
		  box-sizing: border-box;
		  transition: border-color 0.3s ease;
		}
		
		input[type="text"]:focus,
		input[type="password"]:focus,
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
		
		.radio-group {
		  margin-bottom: 15px; /* ลดจาก 20px */
		  font-size: 0.85rem; /* ลดจาก 1rem */
		}
		
		.btn-group {
		  display: flex;
		  justify-content: space-between;
		  gap: 10px; /* ลดจาก 15px */
		}
		
		input[type="submit"],
		input[type="reset"] {
		  flex: 1;
		  padding: 10px 0; /* ลดจาก 14px 0 */
		  font-weight: 700;
		  border: none;
		  border-radius: 6px; /* ลดจาก 8px */
		  cursor: pointer;
		  font-size: 0.9rem; /* ลดจาก 1.1rem */
		  transition: background-color 0.25s ease, box-shadow 0.25s ease;
		  box-shadow: 0 3px 9px rgba(0,0,0,0.12); /* ลดจาก 0 4px 12px */
		}
		
		input[type="submit"] {
		  background-color: #04BE43;
		  color: #fff;
		}
		
		input[type="submit"]:hover {
		  background-color: #01579b;
		  box-shadow: 0 4px 12px rgba(1, 87, 155, 0.7); /* ลดจาก 0 6px 18px */
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
		  font-size: 0.8rem; /* ลดจาก 0.9rem */
		  margin-bottom: 4px; /* ลดจาก 5px */
		  display: block;
		}
		
		.email-wrapper {
		  position: relative;
		  width: 100%;
		  max-width: none;
		}
		
		.email-wrapper input[type="text"] {
		  width: 100%;
		  padding-right: 90px; /* ลดจาก 110px */
		  box-sizing: border-box;
		  font-size: 0.9rem;
		}
		
		.email-domain {
		  position: absolute;
		  right: 10px; /* ลดจาก 12px */
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
			/*รหัสนักศึกษา*/
		    var stuId = frm1.student_id.value.trim();
		    var stuIdPattern = /^\d{10}$/; 
		    document.getElementById('err_stu_id').innerHTML = "";
		
		    if (stuId === "") {
		        document.getElementById('err_stu_id').innerHTML = "กรุณากรอกรหัสนักศึกษา";
		        frm1.student_id.focus();
		        return false;
		    }
		   
		    if (!stuIdPattern.test(stuId)) {
		        document.getElementById('err_stu_id').innerHTML = "กรุณากรอกเป็นตัวเลข 10 ตัวเท่านั้น";
		        frm1.student_id.focus();
		        return false;
		    }

					    /*ชื่อ*/
		    var fname = frm1.fname.value.trim();
		    var fnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,40}$/;
		    document.getElementById('err_fname').innerHTML = "";
		
		    if (fname === "") {
		        document.getElementById('err_fname').innerHTML = "กรุณากรอกชื่อ";
		        frm1.fname.focus();
		        return false;
		    }
		
		    if (!fnamePattern.test(fname)) {
		        document.getElementById('err_fname').innerHTML = "ชื่อต้องเป็นภาษาไทยหรืออังกฤษ ความยาว 2-40 ตัวอักษร";
		        frm1.fname.focus();
		        return false;
		    }
		    /*สกุล*/
		    var lname = frm1.lname.value.trim();
		    var lnamePattern = /^[A-Za-zก-๙ะ-์\s]{2,85}$/;
		    document.getElementById('err_lname').innerHTML = "";
		
		    if (lname === "") {
		        document.getElementById('err_lname').innerHTML = "กรุณากรอกนามสกุล";
		        frm1.lname.focus();
		        return false;
		    }
		
		    if (!lnamePattern.test(lname)) {
		        document.getElementById('err_lname').innerHTML = "นามสกุลต้องเป็นภาษาไทยหรืออังกฤษ ความยาว 2-85 ตัวอักษร";
		        frm1.lname.focus();
		        return false;
		    }

			 /* เบอร์โทรศัพท์ */
		    var phone = frm1.phon_num.value.trim();
		    var phonePattern = /^(06|07|08|09)\d{8}$/;
		    document.getElementById('err_phone').innerHTML = "";
		
		    if (phone === "") {
		        document.getElementById('err_phone').innerHTML = "กรุณากรอกเบอร์โทรศัพท์";
		        frm1.phon_num.focus();
		        return false;
		    }
		
		    if (/\s/.test(phone)) {
		        document.getElementById('err_phone').innerHTML = "เบอร์โทรต้องไม่มีช่องว่าง";
		        frm1.phon_num.focus();
		        return false;
		    }
		
		    if (!phonePattern.test(phone)) {
		        document.getElementById('err_phone').innerHTML = "เบอร์โทรต้องขึ้นต้นด้วย 06, 07, 08 หรือ 09 และมี 10 หลักเท่านั้น";
		        frm1.phon_num.focus();
		        return false;
		    }

			/* ตรวจสอบชั้นปี */
			var yfs = frm1.yfs.value.trim();
			document.getElementById('err_yfs').innerHTML = "";

			if (yfs === "") {
				document.getElementById('err_yfs').innerHTML = "กรุณาเลือกชั้นปี";
				frm1.yfs.focus();
				return false;
			}

		    /*เมล*/
		    // ======= email แบบ prefix + domain ======= //
			var emailPrefix = frm1.email_prefix.value.trim();
			var fullEmail = emailPrefix + "@mju.ac.th";
			document.getElementById('err_email').innerHTML = "";
		
			// กำหนดค่า email เต็มลง input hidden
			frm1.email.value = fullEmail;
		
			// เช็คค่าว่าง
			if (emailPrefix === "") {
		    	document.getElementById('err_email').innerHTML = "กรุณากรอกอีเมล";
		    	frm1.email_prefix.focus();
		    	return false;
			}
		
			// ห้ามมีช่องว่าง
			if (/\s/.test(emailPrefix)) {
		    	document.getElementById('err_email').innerHTML = "ห้ามมีช่องว่างในอีเมล";
		    	frm1.email_prefix.focus();
		    	return false;
			}
		
			// เช็คความยาว prefix ต้อง 13 ตัว
			if (emailPrefix.length !== 13) {
		    	document.getElementById('err_email').innerHTML = "อีเมลก่อน @ ต้องมีความยาว 13 ตัว";
		    	frm1.email_prefix.focus();
		    	return false;
			}
		
			// ตรวจรูปแบบ prefix ว่าขึ้นต้นด้วย MJU + ตัวเลข 10 ตัว
			var emailPrefixPattern = /^MJU\d{10}$/i;
			if (!emailPrefixPattern.test(emailPrefix)) {
		    	document.getElementById('err_email').innerHTML = "รูปแบบอีเมลไม่ถูกต้อง เช่น MJU65******01";
		    	frm1.email_prefix.focus();
		    	return false;
			}

			 /* ตรวจรหัสผ่าน */
		    var password = frm1.password.value;
			document.getElementById('err_password').innerHTML = "";
			
			// เช็คไม่ว่าง
			if (password.trim() === "") {
			    document.getElementById('err_password').innerHTML = "กรุณากรอกรหัสผ่าน";
			    frm1.password.focus();
			    return false;
			}
			
			// เช็คความยาว 8-16 ตัวอักษร
			if (password.length < 8 || password.length > 16) {
			    document.getElementById('err_password').innerHTML = "รหัสผ่านต้องมีความยาว 8-16 ตัวอักษร";
			    frm1.password.focus();
			    return false;
			}
			
			// เช็คอักขระที่อนุญาต (อังกฤษ ตัวเลข และ ! # _ . เท่านั้น)
			var allowedChars = /^[A-Za-z0-9!#_.]+$/;
			if (!allowedChars.test(password)) {
			    document.getElementById('err_password').innerHTML = "รหัสผ่านอนุญาตเฉพาะ A-Z, a-z, 0-9 และ ! # _ .";
			    frm1.password.focus();
			    return false;
			}
			
			// ห้ามมีช่องว่าง
			if (/\s/.test(password)) {
			    document.getElementById('err_password').innerHTML = "รหัสผ่านห้ามมีช่องว่าง";
			    frm1.password.focus();
			    return false;
			}
			
			// ต้องมีพิมพ์ใหญ่ พิมพ์เล็ก และตัวเลข อย่างน้อย 1 ตัว
			var hasUpper = /[A-Z]/.test(password);
			var hasLower = /[a-z]/.test(password);
			var hasDigit = /[0-9]/.test(password);
			
			if (!hasUpper || !hasLower || !hasDigit) {
			    document.getElementById('err_password').innerHTML = "รหัสผ่านต้องมีตัวพิมพ์ใหญ่ พิมพ์เล็ก และตัวเลข อย่างน้อย 1 ตัว";
			    frm1.password.focus();
			    return false;
			}

		   
		    
		    var imgInput = frm1.image;  // input type="file" ชื่อ "image"
    document.getElementById('err_image').innerHTML = "";

    if (imgInput.files.length === 0) {
        document.getElementById('err_image').innerHTML = "* กรุณาเลือกไฟล์รูปภาพ";
        imgInput.focus();
        return false;
    }

    var file = imgInput.files[0];
    var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;

    // ตรวจสอบนามสกุลไฟล์
    if (!allowedExtensions.exec(file.name)) {
        document.getElementById('err_image').innerHTML = "* ไฟล์ต้องเป็น .jpg, .jpeg, .png หรือ .gif เท่านั้น";
        imgInput.focus();
        return false;
    }

    // ตรวจสอบขนาดไฟล์ <= 5MB
    var maxSize = 5 * 1024 * 1024; // 5MB
    if (file.size > maxSize) {
        document.getElementById('err_image').innerHTML = "* ขนาดไฟล์ต้องไม่เกิน 5MB";
        imgInput.focus();
        return false;
    }
		    
		   
		    return true;
		}
	</script>
<body>
<div class="main-container">
  <div class="left-container">
    <a href="goHome">&#8592; กลับหน้า Home </a>
    <a href="goLogin">&#8592; ไปหน้า Login</a>
  </div>

  <div class="right-container">
    <h1>Register Student</h1>
    <p class="error" style="color:red;">${err_result}</p>

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
		<option value="Y1">ชั้นปีที่ 1</option>
		<option value="Y2">ชั้นปีที่ 2</option>
		<option value="Y3">ชั้นปีที่ 3</option>
		<option value="Y4">ชั้นปีที่ 4</option>
	</select>
	

      <span class="error" id="err_email"></span>
      <div class="email-wrapper">
		  <input type="text" name="email_prefix" id="email_prefix" placeholder="Email (เช่น MJU6512345678)" autocomplete="off">
		  <span class="email-domain">@mju.ac.th</span>
		  <input type="hidden" name="email" id="email">
		  <span id="err_email" class="error"></span>
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