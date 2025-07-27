<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Tutor Page</title>
</head>
<script>
  let skillCount = 1;  

  function addSkill() {
    if(skillCount >= 5) {
      alert("เพิ่มได้ไม่เกิน 5 วิชา");
      return;
    }
    skillCount++;
    const container = document.getElementById('skillCon');
    
    const input = document.createElement('input');
    input.type = 'text';
    input.name = 'skill';
    input.id = 'skill' + skillCount;

    
    container.appendChild(document.createElement('br'));
    container.appendChild(input);
    
    
  }
  
  function validateTutor() {
	  let isValid = true;

	  
	  const skills = document.getElementsByName("skill");
	  const skillPattern = /^[A-Za-zก-๙]{4,100}$/;

	  for (let i = 0; i < skills.length; i++) {
	    const val = skills[i].value.trim();
	    if (val === "") {
	      alert("กรุณากรอกวิชาที่เชี่ยวชาญ (ห้ามเว้นว่าง)");
	      skills[i].focus();
	      isValid = false;
	      break;
	    }
	    if (!skillPattern.test(val)) {
	      alert("วิชาที่เชี่ยวชาญต้องเป็นภาษาไทยหรืออังกฤษ ความยาว 4-100 ตัวอักษร");
	      skills[i].focus();
	      isValid = false;
	      break;
	    }
	  }

	  if (!isValid) return false;

	  const exp = document.getElementById("expertise").value.trim();
	  if (exp.length > 0) {
	    if (exp.length < 20 || exp.length > 255) {
	      alert("ประสบการณ์ต้องมีความยาว 20-255 ตัวอักษร");
	      document.getElementById("expertise").focus();
	      return false;
	    }

	    const specialCharPattern = /[!@#$%^&*()_+=\[\]{};:"\\|<>\/?~]/;
	    if (specialCharPattern.test(exp)) {
	      alert("ประสบการณ์ห้ามมีอักขระพิเศษ เช่น @#$%");
	      document.getElementById("expertise").focus();
	      return false;
	    }
	  }

	  return true;
	}
</script>

<body>
	<h1>Register Tutor</h1>
	<a href="goHome">กลับหน้า Home</a><br>
	<p style="color:red;">${add_result}</p>
	<span id="err_password" style="color:red;"></span>
	<form name="frm1" action="addRegisterTutor" method="post" onsubmit="return validateTutor();">
	<p>วิชาที่ถนัด(*สามารถมีได้มากกว่า 1 ไม่เกิน 5)</p>
	<div id="skillCon">
  		<input type="text" name="skill" id="skill1"> <button type="button" onclick="addSkill()">เพิ่มวิชา</button>
	</div>
	
	<p>ประสบการณ์(*จำเป็นต้องระบุ)</p>
		<textarea name="expertise" id="expertise" rows="4" ></textarea>
		
		<input type="reset" value="ยกเลิก">
		<input type="submit" value="ลงทะเบียน">
		
	</form>
 
</body>
</html>