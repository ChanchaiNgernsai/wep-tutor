<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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
    padding: 20px;
  }

  .main-container {
    display: flex;
    gap: 30px;
    max-width: 900px;
    width: 100%;
    background-color: #ffffffcc;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    padding: 30px 40px;
  }

  .left-container {
    flex: 0 0 22%;
    background-color: #CECECE;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.12);
    padding: 25px 20px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    font-weight: 600;
    color: #e1f5fe;
  }
  .left-container a {
    color: #333333;
    text-decoration: none;
    margin-bottom: 20px;
    font-size: 1.05rem;
    border-left: 4px solid transparent;
    padding-left: 10px;
    transition: border-color 0.3s ease, color 0.3s ease;
  }
  .left-container a:hover {
    text-decoration: none;
    border-left: 4px solid #ffffff;
    color: #fff;
  }

  .right-container {
    flex: 1;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.1);
    padding: 40px 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  h1 {
    margin-bottom: 30px;
    color: #EB5353;
    font-weight: 700;
    font-size: 3.4rem;
    letter-spacing: 1.1px;
  }

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
    box-sizing: border-box;
    font-size: 1.1rem;
    border: 2px solid #A1A1A1;
    border-radius: 8px;
    color: #222;
    transition: border-color 0.3s ease;
  }

  .email-wrapper input[type="text"]:focus {
    border-color: #0288d1;
    outline: none;
  }

  .email-domain {
    position: absolute;
    right: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: #555;
    font-weight: 600;
    font-size: 1.1rem;
    pointer-events: none;
    user-select: none;
  }

  input[type="password"] {
    width: 100%;
    padding: 14px 16px;
    margin: 12px 0 25px 0;
    border: 2px solid #A1A1A1;
    border-radius: 8px;
    font-size: 1.1rem;
    color: #222;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
  }

  input[type="password"]:focus {
    border-color: #0288d1;
    outline: none;
  }

  input::placeholder {
    color: #90a4ae;
    font-style: italic;
  }

  .btn-group {
    width: 100%;
    display: flex;
    justify-content: space-between;
    gap: 15px;
  }

  input[type="submit"], input[type="reset"] {
    flex: 1;
    padding: 14px 0;
    font-weight: 700;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.1rem;
    transition: background-color 0.25s ease, box-shadow 0.25s ease;
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
  }

  input[type="submit"] {
    background-color: #04BE43;
    color: #fff;
  }

  input[type="submit"]:hover {
    background-color: #01579b;
    box-shadow: 0 6px 18px rgba(1, 87, 155, 0.7);
  }

  input[type="reset"] {
    background-color: #b0bec5;
    color: #37474f;
  }

  input[type="reset"]:hover {
    background-color: #78909c;
    color: #eceff1;
  }

  p.error {
    color: #d32f2f;
    font-weight: 700;
    margin: 0 0 25px 0;
    text-align: center;
    font-size: 1.1rem;
    min-height: 26px;
  }

  .register-link {
    margin-top: 25px;
    font-weight: 600;
    font-size: 1rem;
    color: #0288d1;
    text-decoration: none;
    text-align: center;
    display: block;
    width: fit-content;
    margin-left: auto;
    margin-right: auto;
    transition: color 0.3s ease;
  }
  .register-link:hover {
    color: #01579b;
    text-decoration: underline;
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
    alert("ความยาวรหัสนักศึกษาต้องมี 13 ตัวพอดี");
    return false;
  }

  if (/\s/.test(prefix) || /\s/.test(password)) {
    alert("กรุณากรอกข้อมูลอีเมล์และรหัสผ่านโดยห้ามมีช่องว่าง");
    return false;
  }

  if (!emailRegex.test(prefix)) {
    alert("กรุณากรอกอีเมล์นักศึกษาให้อยู่ในรูปแบบของ MJU เช่น mju65******01");
    return false;
  }
  
  if (password.length < 8 || password.length > 16) {
    alert("รหัสผ่านต้องมีความยาวระหว่าง 8 - 16 ตัวอักษร");
    return false;
  }

  if (/\s/.test(password)) {
    alert("กรุณากรอกข้อมูลรหัสผ่านโดยห้ามมีช่องว่างระหว่างตัวอักษร");
    return false;
  }

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
      <h1>Sign in</h1>
       <p class="error">${err_login}</p>
       <p class="error">${result_loginAdmin}</p>
      <p style="color:green;">${result_regis}</p>
      
      <form name="frm2" action="loginUser" method="post" onsubmit="return validateLogin();">
        <div class="email-wrapper">
          <input type="text" id="email_prefix" name="email_prefix" placeholder="email เช่น mju65******01">
          <span class="email-domain">@mju.ac.th</span>
          <input type="hidden" id="email" name="email">
        </div>

        <input type="password" name="password" id="password" placeholder="Password"><br>

        <div class="btn-group">
          <input type="reset" value="ยกเลิก"  onclick="window.location.href='goHome';">
          <input type="submit" value="เข้าสู่ระบบ">
        </div>

        <hr>

        <a class="register-link" href="goRegisterStu">ลงทะเบียนสมาชิกใหม่</a>
      </form>
    </div>
  </div>
</body>
</html>
