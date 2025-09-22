<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Report Tutor</title>


</head>
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
<body>
    <a href="goHome">กลับหน้า Home</a>
    <h2>รายงานผู้สอนที่ถูกส่งมาทั้งหมด</h2>

    
    <p style="color:green;">${result_ban}</p>
    <P style="color:red;">${err_ban}</P>
    
    <table border="1">
    <tr>
        <th>ลำดับ</th>
        <th>ชื่อผู้รายงาน</th>
        <th>ชื่อผู้ถูกรายงาน</th>
        <th>รายละเอียดรายงาน</th>
        <th>วันที่รายงาน</th>
        <th> </th>
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
                        <input type="button" value="BanTutor" onclick="banTutorPrompt('${report.reported.roleId}')" />
                    </form>
                </c:when>
                <c:otherwise>
                    แบนแล้ว
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:forEach>
    </table>


</body>
</html>
