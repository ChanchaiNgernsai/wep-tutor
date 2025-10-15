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

        .header {
            display: flex;
            align-items: center;
            padding: 20px 30px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .header img {
            width: 80px;
            height: 80px;
            margin-right: 20px;
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
            color: #181818;
        }

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
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .btn:hover {
            background-color: #007a2f;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
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

    <div class="header">
        <a href="goAdminHome"><img src="resources/images/home_on.png" alt="Home"></a>
        <h2>ช่วยติวในมหาวิทยาลัยแม่โจ้</h2>
    </div>
 
    <div class="main-content">
        <div class="card">
            <p id="resultReview" style="color: green;">${result_loginAdmin}</p>
            <a class="btn" href="goListReport">-- หน้ารายงาน --</a>
            
            <form action="logout" method="post" style="margin-top: 20px;">
                <input class="btn logout-btn" type="submit" value="ออกจากระบบ" />
            </form>
        </div>
    </div>

</body>
</html>
