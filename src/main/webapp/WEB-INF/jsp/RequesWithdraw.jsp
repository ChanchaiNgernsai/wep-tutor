<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Withdraw</title>
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

/* ปรับ h1 ให้ชิดกับ p ด้านล่าง */
.right-container h1 {
    margin-bottom: 6px;  /* ลดระยะด้านล่าง */
    line-height: 1.1;    /* ลดความสูงบรรทัด */
    text-align: center;
}

/* ปรับ p ให้ชิด h1 */
.right-container p {
    margin-top: 0;        /* ลบระยะด้านบน */
    margin-bottom: 15px;  /* ระยะด้านล่างยังคงพอเหมาะ */
    text-align: center;
}

  h1 {
    margin-bottom: 10px;
    color: #1E54D1;
    font-weight: 700;
    font-size: 3.4rem;
    letter-spacing: 1.1px;
  }

  input[type="number"], select {
    width: 100%;
    max-width: 400px;
    padding: 14px 16px;
    margin: 12px 0 25px 0;
    border: 2px solid #A1A1A1;
    border-radius: 8px;
    font-size: 1.1rem;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
  }

  input[type="number"]:focus, select:focus {
    border-color: #0288d1;
    outline: none;
  }

  input[type="submit"] {
    width: 100%;
    max-width: 400px;
    padding: 14px 0;
    font-weight: 700;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.1rem;
    background-color: #1E54D1;
    color: #fff;
    transition: background-color 0.25s ease, box-shadow 0.25s ease;
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
  }

  input[type="submit"]:hover {
    background-color: #01579b;
    box-shadow: 0 6px 18px rgba(1, 87, 155, 0.7);
  }

    button.cancel-button {
        width: 100%;
        max-width: 400px;
        padding: 14px 0;
        font-weight: 700;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1.1rem;
        background-color: #484848;
        color: #fff;
        transition: background-color 0.25s ease, box-shadow 0.25s ease;
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
    }
    button.cancel-button:hover {
        background-color: #000000;
        box-shadow: 0 6px 18px rgba(0,0,0,0.3);
    }


  p.error {
    color: #d32f2f;
    font-weight: 700;
    margin: 0 0 15px 0;
    text-align: center;
    font-size: 1.1rem;
    min-height: 26px;
  }

  p.success {
    color: green;
    font-weight: 600;
    margin: 0 0 15px 0;
    text-align: center;
    font-size: 1.1rem;
    min-height: 26px;
  }

  .link-bottom {
    margin-top: 20px;
    font-weight: 600;
    font-size: 1rem;
    color: #0288d1;
    text-decoration: none;
    text-align: center;
    display: block;
    width: fit-content;
  }
  .link-bottom:hover {
    color: #01579b;
    text-decoration: underline;
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

    return confirm("ข้อมูลถูกต้อง!\nคุณต้องการถอนเงินจำนวน " + amount + " บาท ไปยังบัญชี " + account + " ธนาคาร " + bank + " หรือไม่?");  
}
</script>

</head>
<body>
  <div class="main-container">
    <div class="left-container">
        <a href="goHome">&#8592; กลับหน้า Home</a>
        <a class="link-bottom" href="goDeposit">&#8592;ไปหน้าฝากเงิน</a>
    </div>

    <div class="right-container">
      <h1>Withdraw</h1>
      <p class="error">${err_result}</p>
      <p class="success">${msg_result}</p>

      <p>เงินคงเหลือปัจจุบัน: <strong>${balance}</strong> บาท</p>

      <form action="requesWithdraw" method="post" onsubmit="return validateWithdraw();">
        <label for="bank">ประเภทธนาคาร:</label><br />
        <select id="bankType" name="bankType" value="${bankType}">
            <option value="">-- กรุณาเลือกธนาคาร --</option>
            <option value="ธนาคารกรุงเทพ">ธนาคารกรุงเทพ (BBL)</option>
            <option value="ธนาคารกสิกรไทย">ธนาคารกสิกรไทย (KBANK)</option>
            <option value="ธนาคารไทยพาณิชย์">ธนาคารไทยพาณิชย์ (SCB)</option>
            <option value="ธนาคารกรุงไทย">ธนาคารกรุงไทย (KTB)</option>
        </select><br />

        <label for="bankAccount">เลขบัญชีธนาคาร:</label><br />
        <input type="number" id="bankAccount" name="bankAccount" placeholder="กรุณากรอกเลขบัญชีธนาคาร" value="${bankAccount}" /><br />
        <label for="amount">กรุณากรอกจำนวนเงินที่ต้องการถอน:</label><br />
        <input type="number" id="amount" name="amount" min="0" step="50" value="${amount}" />
        <input type="submit" value="Confirm Withdraw" /><br />
        <br />
        <button type="button" class="cancel-button" onclick="history.back();">ยกเลิก</button>
      </form>
    </div>
  </div>
</body>
</html>
