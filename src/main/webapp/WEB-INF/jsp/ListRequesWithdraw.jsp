<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายการติวเตอร์ขอถอนเงิน</title>
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
        background-color: #007F3E;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .header h2 {
        margin: 0;
        font-size: 24px;
        color: #ffffff;
    }

    /* ✅ เพิ่มสไตล์ main-content และ card เหมือนหน้า ListReport */
    .main-content {
        max-width: 900px;
        margin: 30px auto;
        padding: 20px;
    }

    .card {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 30px;
    }

    h2 {
        margin: 0;
        color: #333;
    }
    h1 {
        color: #555;
        margin-bottom: 20px;
    }

    table {
        border-collapse: collapse;
        width: 100%;
        background-color: #fff;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }

    th {
        background-color: #007F3E;
        color: white;
        font-weight: bold;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .btn {
        padding: 5px 10px;
        margin: 2px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 0.9em;
    }

    .approve {
        background-color: #4CAF50;
        color: white;
    }

    .reject {
        background-color: #f44336;
        color: white;
    }

    .btn-back {
        display: inline-block;
        background-color: #007F3E; 
        color: white;
        padding: 10px 20px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: bold;
        font-size: 14px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        margin-bottom: 15px;
    }

    .btn-back:hover {
        background-color: #007F3E; 
        transform: translateY(-2px);
        box-shadow: 0 6px 10px rgba(0,0,0,0.15);
    }
</style>
</head>
<body>
    <div class="header">
        <h2>รายการติวเตอร์ขอถอนเงิน</h2>
    </div>

    <div class="main-content">
        <div class="card">
            <a class="btn-back" href="goAdminHome">กลับหน้า Admin Home</a>

            <table>
                <thead>
                    <tr>
                        <th>ลำดับ</th>
                        <th>ชื่อ-สกุล</th>
                        <th>อีเมล</th>
                        <th>จำนวนเงิน</th>
                        <th>บัญชี</th>
                        <th>ประเภทธนาคาร</th>
                        <th>วันที่ขอถอน</th>
                        <th>จัดการ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tran" items="${withdrawRequests}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${tran.user.firstName} ${tran.user.lastName}</td>
                            <td>${tran.user.email}</td>
                            <td>${tran.withdraw} บาท</td>
                            <td>${tran.accountNumber}</td>
                            <td>${tran.tranType}</td>
                            <td><fmt:formatDate value="${tran.withdrawDate}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${tran.withdrawStatus == 1}">
                                        <form action="approveWithdraw" method="post" style="display:inline;">
                                            <input type="hidden" name="tranId" value="${tran.tranId}" />
                                            <input type="hidden" name="action" value="approve" />
                                            <input type="submit" class="btn approve" value="อนุมัติ" />
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        ยังไม่มีรายการ
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
