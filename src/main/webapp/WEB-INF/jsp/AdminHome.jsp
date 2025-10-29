<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <style>
        body {
            background-color: #EBEBEB;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* --- Header --- */
        .header {
            display: flex;
            align-items: center;
            padding: 20px 15px; /* ลด padding ด้านซ้ายให้ชิดมากขึ้น */
            background-color: #007F3E;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
            color: #ffffff;
            text-align: left; /* ชิดซ้าย */
        }

        /* --- Main Content --- */
        .main-content {
            max-width: 700px;
            margin: 30px auto;
            padding: 20px;
        }

        .card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            text-align: center;
        }
        .card h2 {
            text-align: left;
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 22px;
            color: #333;
        }

        /* --- Buttons --- */
        .btn {
            display: inline-block;
            margin: 15px 10px;
            padding: 12px 25px;
            background-color: #009639;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #007a2f;
        }

        .logout-btn {
            background-color: #e74c3c;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
        <h2>ช่วยติวในมหาวิทยาลัยแม่โจ้</h2>
    </div>
 
    <!-- Main Content -->
    <div class="main-content">
        <div class="card">
            <h2>หน้าจัดการแอดมิน</h2>
            <p id="resultReview" style="color: green;">${result_loginAdmin}</p>
            
            <a class="btn" href="goListRequesWithdraw">รายการติวเตอร์ขอถอนเงิน</a><br>
            <a class="btn" href="goListReport">หน้ารายงาน</a><br>
            
            <form action="logout" method="post">
                <input class="btn logout-btn" type="submit" value="ออกจากระบบ" />
            </form>
        </div>
    </div>

</body>
</html>
