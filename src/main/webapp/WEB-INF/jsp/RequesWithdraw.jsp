<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Withdraw</title>
<style>
    body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
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
            font-size: 35px; 
            text-align: center;
        }
        a {
            text-decoration: none;
            color: #007F3E;
        }

  .main-container {
    display: flex;
    gap: 25px;
    max-width: 900px;
    width: 100%;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    padding: 30px 40px;
    border-top: 6px solid #007F3E;
    margin: 40px auto;
  }

  .left-container {
    flex: 0 0 25%;
    background-color: #f2f5ff;
    border-radius: 12px;
    padding: 25px 20px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    font-weight: 600;
  }

  .left-container a {
    color: #007F3E;
    text-decoration: none;
    margin-bottom: 18px;
    font-size: 1rem;
    border-left: 4px solid transparent;
    padding-left: 10px;
    transition: 0.3s;
  }

  .left-container a:hover {
    border-left: 4px solid #007F3E;
    color: #007F3E;
  }

  .right-container {
    flex: 1;
    background-color: #ffffff;
    border-radius: 12px;
    padding: 40px 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .right-container h1 {
    margin-bottom: 10px;
    color: #007F3E;
    font-weight: 700;
    font-size: 2.4rem;
    text-align: center;
  }

  .right-container p {
    margin-top: 0;
    margin-bottom: 15px;
    text-align: center;
    color: #333;
  }

  .balance-box {
    background-color: #edf2ff;
    border: 1px solid #d0d8ff;
    border-radius: 8px;
    padding: 10px 15px;
    text-align: center;
    font-weight: 600;
    color: #007F3E;
    margin-bottom: 20px;
  }

  input[type="number"], select {
    width: 100%;
    max-width: 400px;
    padding: 12px 14px;
    margin: 10px 0 20px 0;
    border: 1px solid #cdd5ec;
    border-radius: 8px;
    font-size: 1rem;
    transition: border-color 0.3s, box-shadow 0.3s;
  }

  input[type="number"]:focus, select:focus {
    border-color: #007F3E;
    outline: none;
    box-shadow: 0 0 4px rgba(30, 84, 209, 0.3);
  }

  input[type="submit"] {
    width: 100%;
    max-width: 400px;
    padding: 12px 0;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1rem;
    background-color: #007F3E;
    color: #fff;
    transition: 0.3s;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  }

  input[type="submit"]:hover {
    background-color: #1a5a39;
    transform: translateY(-1px);
  }

  button.cancel-button {
    width: 100%;
    max-width: 400px;
    padding: 12px 0;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1rem;
    background-color: #6b6b6b;
    color: #fff;
    transition: 0.3s;
  }

  button.cancel-button:hover {
    background-color: #333;
  }

  p.error {
    color: #e74c3c;
    font-weight: 600;
    text-align: center;
  }

  p.success {
    color: #27ae60;
    font-weight: 600;
    text-align: center;
  }

input[type=number]::-webkit-inner-spin-button,
input[type=number]::-webkit-outer-spin-button {
    -webkit-appearance: none; 
    margin: 0;
}


input[type=number] {
    -moz-appearance: textfield; 
    appearance: textfield;      
}
input[type="number"], select {
    width: 100%;
    max-width: 400px;
    padding: 12px 14px;
    margin: 10px 0 20px 0;
    border: 1px solid #cdd5ec;
    border-radius: 8px;
    font-size: 1rem;
    transition: border-color 0.3s, box-shadow 0.3s;
    box-sizing: border-box; 
}


</style>

<script>
function validateWithdraw() {
    const bank = document.getElementById("bankType").value.trim();
    const account = document.getElementById("bankAccount").value.trim();
    const amountInput = document.getElementById("amount").value.trim();
    const balance = parseInt("${balance}");

    if (bank === "") {
        alert("กรุณาเลือกธนาคาร");
        return false;
    }
    if (account === "") {
        alert("กรุณากรอกเลขบัญชีธนาคาร");
        document.getElementById("bankAccount").focus();
        return false;
    }
    if (!/^\d{10}$/.test(account)) {
        alert("เลขบัญชีต้องเป็นตัวเลข 10 หลักเท่านั้น");
        document.getElementById("bankAccount").focus();
        return false;
    }
    if (amountInput === "") {
        alert("กรุณากรอกจำนวนเงินที่ต้องการถอน");
        document.getElementById("amount").focus();
        return false;
    }
    if (!/^\d+$/.test(amountInput)) {
        alert("จำนวนเงินต้องเป็นตัวเลขจำนวนเต็มบวก");
        document.getElementById("amount").focus();
        return false;
    }

    const amount = parseInt(amountInput);
    if (amount < 100) {
        alert("จำนวนเงินขั้นต่ำคือ 100 บาท");
        document.getElementById("amount").focus();
        return false;
    }
    if (amount > balance) {
        alert("จำนวนเงินถอนต้องไม่เกินเงินคงเหลือปัจจุบัน (" + balance + " บาท)");
        document.getElementById("amount").focus();
        return false;
    }

    return confirm("ยืนยันการถอนเงินจำนวน " + amount + " บาท\nไปยังบัญชี " + account + " (" + bank + ")");
}


</script>
</head>

<body>
    <div class="header">
          <a href="goHome"><h1>ทำเรื่องขอถอนเงิน</h1></a>
    </div>
  <div class="main-container">

    <div class="right-container">
      <h2>ถอนเงิน</h2>
      <p class="error">${err_result}</p>
      <p class="success">${msg_result}</p>

      <div class="balance-box">
        เงินคงเหลือปัจจุบัน: <strong>${balance}</strong> บาท
      </div>
 
      <form action="requesWithdraw" method="post" onsubmit="return validateWithdraw();">
        <label for="bank">เลือกธนาคาร:</label><br />
        <select id="bankType" name="bankType" value="${bankType}">
            <option value="">-- กรุณาเลือกธนาคาร --</option>
            <option value="ธนาคารกรุงเทพ">ธนาคารกรุงเทพ (BBL)</option>
            <option value="ธนาคารกสิกรไทย">ธนาคารกสิกรไทย (KBANK)</option>
            <option value="ธนาคารไทยพาณิชย์">ธนาคารไทยพาณิชย์ (SCB)</option>
            <option value="ธนาคารกรุงไทย">ธนาคารกรุงไทย (KTB)</option>
        </select><br />

        <label for="bankAccount">เลขบัญชีธนาคาร:</label><br />
        <input type="number" id="bankAccount" name="bankAccount" placeholder="กรุณากรอกเลขบัญชีธนาคาร" value="${bankAccount}" /><br />

        <label for="amount">จำนวนเงินที่ต้องการถอน:</label><br />
        <input type="number" id="amount" name="amount" min="100" step="1"  placeholder="ระบุจำนวนเงิน"value="${amount}" />
        <input type="submit" value="ยืนยันการถอนเงิน" /><br /><br />
        <button type="button" class="cancel-button" onclick="history.back();">ยกเลิก</button>
      </form>
    </div>
  </div>
</body>
</html>
