<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Deposit Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .top-links {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .top-links a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }
        p {
            margin: 10px 0;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="number"] {
            width: 100%;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background-color: #1E54D1;
            border: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #219150;
        }
        img.qrcode {
            display: block;
            margin: 15px auto;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .section {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
    </style>

    <script>
function validateDeposit() {
    const amountInput = document.getElementById("amount");
    const amount = amountInput.value.trim();

    // 1. ต้องไม่เป็นค่าว่าง
    if (amount === "") {
        alert("กรุณากรอกจำนวนเงิน");
        amountInput.focus();
        return false;
    }

    // 2. ต้องเป็นตัวเลขจำนวนเต็ม
    if (!/^\d+$/.test(amount)) {
        alert("จำนวนเงินต้องเป็นตัวเลขจำนวนเต็ม");
        amountInput.focus();
        return false;
    }

    // 3. ยอดเงินขั้นต่ำ 100 บาท
    if (parseInt(amount) < 100) {
        alert("จำนวนเงินขั้นต่ำคือ 100 บาท");
        amountInput.focus();
        return false;
    }

    return true; // ผ่านทุกเงื่อนไข
}
</script>

</head>
<body>
    <div class="container">
        <h1>Deposit Page</h1>

        <div class="top-links">
            <a href="goHome">&#8592; กลับสู่หน้าหลัก</a>
        </div>

        <p class="error">${error}</p>
        <p class="success">${msg_result}</p>

        <p>เงินคงเหลือปัจจุบัน: <strong>${balance}</strong> บาท</p>

        <div class="section">
            <form action="addDeposit" method="post" onsubmit="return validateDeposit();">
                <label for="amount">กรุณากรอกจำนวนเงิน:</label>      
                <input type="number" id="amount" name="amount" required value="${amount}" /> 
                <input type="submit" value="ฝากเงิน / สร้าง QR Code" />
            </form>

            <c:if test="${not empty qrUrl}">
                <p class="success">กรุณาสแกน QR เพื่อชำระเงิน:</p>
                <img class="qrcode" src="${qrUrl}" alt="QR Code" height="180" width="180"/>
            </c:if>

        </div>
    </div>
</body>
</html>
