<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>
    /* --- Reset & Base --- */
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

    /* --- Main Container --- */
    .main-container {
        display: flex;
        max-width: 900px;
        width: 100%;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        background: white;
    }

    /* --- Left Panel --- */
    .left-container {
    flex: 0 0 28%;
    background: linear-gradient(135deg, #6a11cb, #2575fc);
    color: #fff;
    padding: 20px 20px;          /* ลด padding ด้านบนให้น้อยลง */
    display: flex;
    flex-direction: column;
    align-items: center;         /* จัดให้อยู่กลางแนวนอน */
    justify-content: flex-start; /* จัดรูปชิดบน */
}

.home-img {
    width: 100px;               
    height: 100px;
    border-radius: 50%;         
    object-fit: cover;          
    transition: transform 0.3s, box-shadow 0.3s, filter 0.3s;
    cursor: pointer;
    margin-top: 10px;           /* กำหนดระยะจากบน container */
}

.home-img:hover {
    transform: scale(1.05);                     
    box-shadow: 0 6px 15px rgba(0,0,0,0.2);    
    filter: brightness(1.1);                   
}


    /* --- Right Panel --- */
    .right-container {
        flex: 1;
        background: #ffffff;
        padding: 50px 40px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    h1 {
        font-size: 2.8rem;
        margin-bottom: 30px;
        color: #ff6a88;
        font-weight: 700;
    }

    /* --- Inputs --- */
    .email-wrapper {
        position: relative;
        width: 100%;
        max-width: 400px;
        margin-bottom: 25px;
    }
    .email-wrapper input[type="text"] {
        width: 100%;
        padding: 14px 16px;
        padding-right: 90px;
        border: 2px solid #ddd;
        border-radius: 8px;
        font-size: 1.1rem;
        transition: border-color 0.3s;
    }
    .email-wrapper input[type="text"]:focus {
        border-color: #42e695;
        outline: none;
    }
    .email-domain {
        position: absolute;
        right: 16px;
        top: 50%;
        transform: translateY(-50%);
        font-weight: 600;
        color: #555;
        user-select: none;
        pointer-events: none;
    }

    input[type="password"] {
        width: 100%;
        padding: 14px 16px;
        margin-bottom: 25px;
        border: 2px solid #ddd;
        border-radius: 8px;
        font-size: 1.1rem;
        transition: border-color 0.3s;
    }
    input[type="password"]:focus {
        border-color: #42e695;
        outline: none;
    }

    ::placeholder {
        color: #aaa;
        font-style: italic;
    }

    /* --- Buttons --- */
    .btn-group {
        width: 100%;
        display: flex;
        gap: 15px;
    }
    input[type="submit"], input[type="reset"] {
        flex: 1;
        padding: 14px 0;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1.1rem;
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

    /* --- Messages --- */
    p.error { color: #d32f2f; font-weight: 700; text-align: center; margin-bottom: 15px; min-height: 24px; }
    p.success { color: #28a745; text-align: center; margin-bottom: 15px; }

    /* --- Register link --- */
    .register-link {
        margin-top: 20px;
        font-weight: 600;
        font-size: 1rem;
        color: #ff6a88;
        text-decoration: none;
        transition: 0.3s;
        display: block;
        text-align: center;
    }
    .register-link:hover {
        color: #ff99ac;
        text-decoration: underline;
    }
    .home-img {
    width: 100px;               
    height: 100px;
    border-radius: 50%;         
    object-fit: cover;          
    transition: transform 0.3s, box-shadow 0.3s, filter 0.3s;
    cursor: pointer;
  }

  
  .home-img:hover {
      transform: scale(1.05);                     
      box-shadow: 0 6px 15px rgba(0,0,0,0.2);    
      filter: brightness(1.1);                   
  }


</style>

<script>
function validateLogin() {
    const prefix = document.getElementById("email_prefix").value.trim();
    const password = document.getElementById("password").value;

    const fullEmail = prefix + "@mju.ac.th";
    document.getElementById("email").value = fullEmail;

    const emailRegex = /^mju\d{10}$/i; // mju65012345601

    if (prefix.toLowerCase() === "admin") {
        if (password === "") { alert("กรุณากรอกรหัสผ่าน"); return false; }
        return true;
    }

    if (prefix === "") { alert("กรุณากรอกอีเมล"); return false; }
    if (password === "") { alert("กรุณากรอกรหัสผ่าน"); return false; }
    if (prefix.length !== 13) { alert("ความยาวรหัสนักศึกษาต้องมี 13 ตัวพอดี"); return false; }
    if (/\s/.test(prefix) || /\s/.test(password)) { alert("ห้ามมีช่องว่าง"); return false; }
    if (!emailRegex.test(prefix)) { alert("รูปแบบอีเมล์ไม่ถูกต้อง เช่น mju65******01"); return false; }
    if (password.length < 8 || password.length > 16) { alert("รหัสผ่านต้อง 8-16 ตัวอักษร"); return false; }

    return true;
}
</script>

</head>
<body>
<div class="main-container">
      <div class="left-container">
          <a href="goHome" >
            <img class="home-img" src="resources/images/home_off.png" alt="Register"/>
          </a>
    </div>

    <div class="right-container">
        <h1>Sign in</h1>

        <p class="error">${err_login}</p>
        <p class="error">${result_loginAdmin}</p>
        <p class="success">${result_regis}</p>

        <form name="frm2" action="loginUser" method="post" onsubmit="return validateLogin();">
            <div class="email-wrapper">
                <input type="text" id="email_prefix" name="email_prefix" placeholder="email เช่น mju65******01">
                <span class="email-domain">@mju.ac.th</span>
                <input type="hidden" id="email" name="email">
            </div>

            <input type="password" name="password" id="password" placeholder="Password">

            <div class="btn-group">
                <input type="reset" value="ยกเลิก" onclick="window.location.href='goHome';">
                <input type="submit" value="เข้าสู่ระบบ">
            </div>

            <a class="register-link" href="goRegisterStu">ลงทะเบียนสมาชิกใหม่</a>
        </form>
    </div>
</div>
</body>
</html>
