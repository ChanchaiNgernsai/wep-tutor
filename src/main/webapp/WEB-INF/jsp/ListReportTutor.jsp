<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายงานติวเตอร์</title>
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
        color: #111111;
    }

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

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: center;
    }

    th {
        background-color: #f0f0f0;
    }

    .btn {
        padding: 8px 15px;
        margin: 5px;
        border: none;
        border-radius: 8px;
        color: white;
        cursor: pointer;
        font-weight: bold;
        transition: 0.3s;
    }

    .btn-ban {
        background-color: #e74c3c;
    }

    .btn-ban:hover {
        background-color: #c0392b;
    }

    .btn-unban {
        background-color: #27ae60;
    }

    .btn-unban:hover {
        background-color: #1e8449;
    }

    .btn-back {
        display: inline-block;
        background-color: #009639;
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        margin-bottom: 15px;
    }

    .btn-back:hover {
        background-color: #007a2f;
    }

    .message {
        margin: 10px 0;
        font-weight: bold;
    }

    .message-success { color: green; }
    .message-error { color: red; }

    .btn-back {
        display: inline-block;
        background-color: #009639; 
        color: white;
        padding: 12px 25px;      
        border-radius: 25px;      
        text-decoration: none;
        font-weight: bold;
        font-size: 15px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
        transition: all 0.3s ease;
    }

    .btn-back:hover {
        background-color: #007a2f; 
        transform: translateY(-2px); 
        box-shadow: 0 6px 10px rgba(0,0,0,0.15); 
    }


</style>

<script>
function banTutorPrompt(tutorId) {
    var reason = prompt("กรุณาใส่เหตุผลการแบนติวเตอร์:");
    if(reason != null && reason.trim() != "") {
        document.getElementById("banDesc" + tutorId).value = reason;
        document.getElementById("banForm" + tutorId).submit();
    } else {
        alert("คุณต้องใส่เหตุผลก่อนการแบน");
    }
}
</script>
</head>
<body>

    <div class="header">
        <a href="goAdminHome"><img src="resources/images/home_off.png" alt="Home"></a>
        <h2>ช่วยติวในมหาวิทยาลัยแม่โจ้</h2>
    </div>

    <div class="main-content">
        <div class="card">
            <a class="btn-back" href="goAdminHome">กลับหน้า Admin Home</a>

            <p class="message message-success">${result_ban}</p>
            <p class="message message-error">${err_ban}</p>
            <p class="message message-error">${err_noban}</p>
            <p class="message message-error">${err_no_unban}</p>

            <table>
                <tr>
                    <th>ลำดับ</th>
                    <th>ชื่อผู้รายงาน</th>
                    <th>ชื่อผู้ถูกรายงาน</th>
                    <th>รายละเอียดรายงาน</th>
                    <th>วันที่รายงาน</th>
                    <th>จัดการ</th>
                </tr>
                <c:forEach var="report" items="${reports}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${report.reporter.firstName} ${report.reporter.lastName}</td>
                        <td>${report.reported.user.firstName} ${report.reported.user.lastName}</td>
                        <td>${report.reportDescription}</td>
                        <td><fmt:formatDate value="${report.reportDate}" pattern="dd/MM/yyyy"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${report.reported.banStatus == 1}">
                                    <form id="banForm${report.reported.roleId}" action="banTutor" method="post">
                                        <input type="hidden" name="tutorId" value="${report.reported.roleId}" />
                                        <input type="hidden" name="banStatus" value="0" /> 
                                        <input type="hidden" name="banDescription" id="banDesc${report.reported.roleId}" />
                                        <input class="btn btn-ban" type="button" value="Ban Tutor" onclick="banTutorPrompt('${report.reported.roleId}')" />
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    แบนแล้ว
                                    <form id="unbanForm${report.reported.roleId}" action="unBanTutor" method="post">
                                        <input type="hidden" name="tutorId" value="${report.reported.roleId}" />
                                        <input type="hidden" name="banStatus" value="1" /> 
                                        <input class="btn btn-unban" type="submit" value="UnBan Tutor" />
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

</body>
</html>
