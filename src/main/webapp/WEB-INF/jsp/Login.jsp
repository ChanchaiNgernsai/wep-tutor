<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
body {
    font-family: "Prompt", Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f2f5;
    color: #333;
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
h2 { text-align: center; color: #007F3E; margin-bottom: 25px; }

input[type="text"], input[type="password"] {
    width: 100%;
    padding: 12px 14px;
    margin-bottom: 20px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
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

p.error { color: #d32f2f; font-weight: bold; text-align: center; }
p.success { color: green; font-weight: bold; text-align: center; }

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
function validateLogin() {
    const prefix = document.getElementById("email_prefix").value.trim();
    const password = document.getElementById("password").value;

    const fullEmail = prefix + "@mju.ac.th";
    document.getElementById("email").value = fullEmail;

    const emailRegex = /^mju\d{10}$/i; // mju65012345601

    if (prefix.toLowerCase() === "admin") {
        if (password === "") { 
            alert("กรุณากรอกรหัสผ่าน"); 
            return false; 
        }
        return true;
    }

    if (prefix === "") { 
        alert("กรุณากรอกอีเมล"); 
        return false; 
    }
    if (password === "") { 
        alert("กรุณากรอกรหัสผ่าน"); 
        return false; 
    }
    if (prefix.length !== 13) { 
        alert("ความยาวอีเมล นักศึกษาต้องมี 13 ตัวพอดี"); 
        return false; 
    }
    if (/\s/.test(prefix) || /\s/.test(password)) { 
        alert("ห้ามมีช่องว่าง"); 
        return false; 
    }
    if (!emailRegex.test(prefix)) { 
        alert("รูปแบบอีเมล์ไม่ถูกต้อง เช่น mju65******01"); 
        return false; 
    }
    if (password.length < 8 || password.length > 16) { 
        alert("รหัสผ่านต้อง 8-16 ตัวอักษร"); 
        return false; 
    }

    return true;
}
</script>

</head>
<body>

<!-- Header -->
<div class="header">
    <a href="goHome"><h1>เข้าสู่ระบบ</h1></a>
</div>

<!-- Login Form -->
<div class="container">
    <h2>เข้าสู่ระบบ</h2>
    <p class="error">${err_login}</p>
    <p class="error">${result_loginAdmin}</p>
    <p class="success">${result_regis}</p>

    <form name="frm2" action="loginUser" method="post" onsubmit="return validateLogin();">
        <div style="position: relative; margin-bottom:20px;">
            <input type="text" id="email_prefix" name="email_prefix" placeholder="Email เช่น mju65******01">
            <span style="position:absolute; right:12px; top:50%; transform: translateY(-80%); color:#555;">@mju.ac.th</span>
            <input type="hidden" id="email" name="email">
        </div>

        <input type="password" name="password" id="password" placeholder="Password">

        <div style="display:flex; justify-content:space-between;">
            <input type="reset" value="ยกเลิก" onclick="window.location.href='goHome';">
            <input type="submit" value="เข้าสู่ระบบ">
        </div>

        <a class="register-link" href="goRegisterStu">ลงทะเบียนสมาชิกใหม่</a>
    </form>
</div>

</body>
</html>
