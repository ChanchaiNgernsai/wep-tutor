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
    .header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            background-color: #007F3E;
            color: white;
            padding: 15px 25px;
            text-decoration: none; 
        }
        h1 {
            color: #ffffff;
            font-size: 24px; 
        }
          h2 {
            color: #007F3E;
            font-size: 24px; 
            text-align: center;
        }
        a {
            text-decoration: none;
            color: #007F3E;
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

    const skillInputs = document.querySelectorAll('input[name="skill"]');
    const skillError = document.getElementById("skillError") || createSkillErrorElement();
    const skillPattern = /^[A-Za-z\u0E00-\u0E7F\s]{4,100}$/;

    skillError.textContent = "";
    let hasSkill = false;
    for (let skillInput of skillInputs) {
        const skillValue = skillInput.value.trim();
        if(skillValue !== "") hasSkill = true; // มีค่า
        if(skillValue !== "" && !skillPattern.test(skillValue)) {
            skillError.textContent = "กรุณากรอกทักษะอย่างน้อย 4 ตัวอักษร (ภาษาไทยหรืออังกฤษ)";
            isValid = false;
            break;
        }
    }
    if(!hasSkill) {
        skillError.textContent = "กรุณากรอกอย่างน้อย 1 วิชา";
        isValid = false;
    }

    const expertise = document.getElementById("expertise").value.trim();
    const expertiseError = document.getElementById("expertiseError") || createExpertiseErrorElement();
    const specialCharPattern = /[<>$%^*+=\\|]/;

    expertiseError.textContent = "";
    if (expertise === "") {
        expertiseError.textContent = "กรุณากรอกประสบการณ์";
        isValid = false;
    } else if (expertise.length < 10) {
        expertiseError.textContent = "กรุณากรอกประสบการณ์อย่างน้อย 10 ตัวอักษร";
        isValid = false;
    } else if (specialCharPattern.test(expertise)) {
        expertiseError.textContent = "ห้ามใช้อักขระพิเศษ เช่น < > $ % ^ * + = |";
        isValid = false;
    }

    return isValid;
}

function createSkillErrorElement() {
    const el = document.createElement("p");
    el.id = "skillError";
    el.className = "error";
    const container = document.getElementById("skillCon");
    container.insertBefore(el, container.firstChild);
    return el;
}

function createExpertiseErrorElement() {
    const el = document.createElement("p");
    el.id = "expertiseError";
    el.className = "error";
    const container = document.getElementById("expertise").parentNode;
    container.insertBefore(el, document.getElementById("expertise"));
    return el;
}

</script>
</head>
<body>
          <div class="header">
          <a href="goHome"><h1>สมัครเป็นติวเตอร์</h1></a>
    </div>
  <div class="container">
    <h2>สมัครเป็นติวเตอร์</h2>
    <a href="goHome">⬅ กลับหน้า Home</a>
    <p class="error">${err_result}</p>

    <form name="frm1" action="addRegisterTutor" method="post" onsubmit="return validateTutor();">
      <p>วิชาที่ถนัด</p>
      <div id="skillCon">
        <div id="skillDiv1" >
          <input type="text" name="skill" id="skill1">
          <button type="button" class="btn btn-add" onclick="addSkill()">+ เพิ่มวิชา</button>
        </div>
      </div>
      
      <p>ประสบการณ์</p>
      <textarea name="expertise" id="expertise" rows="4"></textarea><br>
      
     <button type="button" class="btn btn-reset" onclick="window.location.href='goHome';">ยกเลิก
    </button>
      <input type="submit" class="btn btn-submit" value="ลงทะเบียน">
    </form>
  </div>
</body>
</html>
