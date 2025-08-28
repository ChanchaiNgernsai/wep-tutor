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
<style>
    body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 600px;
        margin: 40px auto;
        background: #fff;
        padding: 25px 30px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    h1 {
        text-align: center;
        color: #333;
    }
    a {
        display: inline-block;
        margin-bottom: 15px;
        color: #007bff;
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }
    p {
        margin: 10px 0;
        font-weight: bold;
        color: #444;
    }
    input[type="text"], textarea {
        width: 100%;
        padding: 10px;
        margin-top: 6px;
        margin-bottom: 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
    }
    textarea {
        resize: none;
    }
    .btn {
        padding: 10px 18px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
    }
    .btn-add {
        background-color: #28a745;
        color: white;
        margin-left: 10px;
    }
    .btn-remove {
        background-color: #dc3545;
        color: white;
        margin-left: 10px;
    }
    .btn-reset {
        background-color: #6c757d;
        color: white;
        margin-right: 10px;
    }
    .btn-submit {
        background-color: #007bff;
        color: white;
    }
    .error {
        color: red;
        margin: 5px 0;
    }
</style>
<script>
  let skillCount = 1;  

  function addSkill() {
    if(skillCount >= 5) {
      alert("เพิ่มได้ไม่เกิน 5 วิชา");
      return;
    }
    skillCount++;
    const container = document.getElementById('skillCon');
    
    const div = document.createElement('div');
    div.id = 'skillDiv' + skillCount;

    const input = document.createElement('input');
    input.type = 'text';
    input.name = 'skill';
    input.id = 'skill' + skillCount;

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.innerText = 'ลบ';
    btn.className = 'btn btn-remove';
    btn.onclick = function() { removeSkill(div.id); };

    div.appendChild(input);
    div.appendChild(btn);
    container.appendChild(div);
  }

  function removeSkill(id) {
    const div = document.getElementById(id);
    if(div) {
      div.remove();
      skillCount--;
    }
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
        alert("กรุณากรอกข้อมูลเป็นจำนวนไม่น้อยกว่า 20 ตัวอักษร และไม่เกิน 255 ตัวอักษร"); 
        document.getElementById("expertise").focus();
        return false;
      }

      const specialCharPattern = /[!@#$%^&*()_+=\[\]{};:"\\|<>\/?~]/;
      if (specialCharPattern.test(exp)) {
        alert("กรุณากรอกข้อมูลโดยห้ามมีอักขระพิเศษ");
        document.getElementById("expertise").focus();
        return false;
      }
    }

    return true;
  }
</script>
</head>
<body>
  <div class="container">
    <h1>Register Tutor</h1>
    <a href="goHome">⬅ กลับหน้า Home</a>
    <p class="error">${err_result}</p>

    <form name="frm1" action="addRegisterTutor" method="post" onsubmit="return validateTutor();">
      <p>วิชาที่ถนัด (*สามารถมีได้มากกว่า 1 ไม่เกิน 5)</p>
      <div id="skillCon">
        <div id="skillDiv1" >
          <input type="text" name="skill" id="skill1">
          <button type="button" class="btn btn-add" onclick="addSkill()">+ เพิ่มวิชา</button>
        </div>
      </div>
      
      <p>ประสบการณ์ (*จำเป็นต้องระบุ)</p>
      <textarea name="expertise" id="expertise" rows="4"></textarea><br>
      
      <input type="reset" class="btn btn-reset" value="ยกเลิก">
      <input type="submit" class="btn btn-submit" value="ลงทะเบียน">
    </form>
  </div>
</body>
</html>
