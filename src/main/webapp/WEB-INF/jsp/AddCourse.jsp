<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<%@ taglib prefix="c" uri ="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Course</title>
</head>
<script>
function showDay(dateStr, dayNameId) {
	  if (!dateStr) {
	    document.getElementById(dayNameId).innerText = '';
	    return;
	  }
	  const date = new Date(dateStr);
	  const daysThai = ['วันอาทิตย์', 'วันจันทร์', 'วันอังคาร', 'วันพุธ', 'วันพฤหัสบดี', 'วันศุกร์', 'วันเสาร์'];
	  const dayName = daysThai[date.getDay()];
	  document.getElementById(dayNameId).innerText = dayName;
	}
  function updateEndTime(durationInput) {
    // หา container ของวันปัจจุบัน
    const parent = durationInput.closest('div');
    const startInput = parent.querySelector('input[name="startTime"]');
    const endInput = parent.querySelector('input[name="endTime"]');

    if (!startInput || !endInput) return;

    const startTimeStr = startInput.value;
    const duration = parseFloat(durationInput.value);

    if (!startTimeStr || !duration) {
        endInput.value = '';
        return;
    }

    const parts = startTimeStr.split(":");
    let h = parseInt(parts[0], 10);
    let m = parseInt(parts[1], 10);

    let totalMinutes = h * 60 + m + duration * 60;
    let endH = Math.floor(totalMinutes / 60) % 24;
    let endM = totalMinutes % 60;

    endInput.value = 
        (endH < 10 ? '0' + endH : endH) + ':' +
        (endM < 10 ? '0' + endM : endM);
}

// ถ้าเปลี่ยน startTime ก็อัปเดต endTime ด้วย
document.querySelectorAll('input[name="startTime"]').forEach(input => {
    input.addEventListener('change', function() {
        const parent = input.closest('div');
        const durationInput = parent.querySelector('input[name="duration"]');
        if(durationInput) updateEndTime(durationInput);
    });
});


	let DateCount = 1; 

function addClassDate() {
    if (DateCount >= 5) {
        alert("เพิ่มได้ไม่เกิน 5 วัน");
        return;
    }

    const container = document.getElementById('addClassDate');

    // === กล่องหลักสำหรับวันสอน ===
    const classWrapper = document.createElement('div');
    classWrapper.className = 'classDateRow';
    classWrapper.id = 'classSection' + DateCount;

    // ปุ่มลบวัน
    const btnRemoveDay = document.createElement('button');
    btnRemoveDay.type = 'button';
    btnRemoveDay.innerText = 'ลบวัน';
    btnRemoveDay.className = 'removeBtn';
    btnRemoveDay.onclick = function () {
        container.removeChild(classWrapper);
        container.removeChild(topicSection);
        container.removeChild(hr);
        DateCount--;
    };

    // วันที่สอน
    const classDateLabel = document.createElement('label');
    classDateLabel.htmlFor = 'classDate' + DateCount;
    classDateLabel.innerText = 'วันที่สอน';

    const dateInput = document.createElement('input');
    dateInput.type = 'date';
    dateInput.name = 'classDate';
    dateInput.id = 'classDate' + DateCount;
    dateInput.style.width = '150px';

    const dayNameP = document.createElement('p');
    dayNameP.id = 'dayName' + DateCount;
    dayNameP.style.minWidth = '80px';
    dayNameP.style.margin = '0';

    dateInput.addEventListener('change', function () {
        showDay(this.value, dayNameP.id);
    });

    // เวลาเริ่ม
    const startLabel = document.createElement('label');
    startLabel.htmlFor = 'startTime' + DateCount;
    startLabel.innerText = 'เริ่ม';

    const startInput = document.createElement('input');
    startInput.type = 'time';
    startInput.name = 'startTime';
    startInput.id = 'startTime' + DateCount;
    startInput.style.width = '100px';

    // Duration (จำนวนชั่วโมง)
    const durationLabel = document.createElement('label');
    durationLabel.htmlFor = 'duration' + DateCount;
    durationLabel.innerText = 'จำนวนชั่วโมง';

    const durationInput = document.createElement('input');
    durationInput.type = 'number';
    durationInput.name = 'duration';
    durationInput.id = 'duration' + DateCount;
    durationInput.min = '0.5';
    durationInput.step = '0.5';
    durationInput.style.width = '60px';

    durationInput.addEventListener('input', function() {
        updateEndTime(this);
    });

    // เวลาสิ้นสุด
    const endLabel = document.createElement('label');
    endLabel.htmlFor = 'endTime' + DateCount;
    endLabel.innerText = 'เวลาสิ้นสุด';

    const endInput = document.createElement('input');
    endInput.type = 'time';
    endInput.name = 'endTime';
    endInput.id = 'endTime' + DateCount;
    endInput.style.width = '100px';
    endInput.readOnly = true;

    // ถ้าเปลี่ยน startTime ให้คำนวณ endTime ใหม่
    startInput.addEventListener('change', function() {
        updateEndTime(durationInput);
    });

    // รวมทุกอย่างลงใน classWrapper
    classWrapper.appendChild(btnRemoveDay);
    classWrapper.appendChild(classDateLabel);
    classWrapper.appendChild(dateInput);
    classWrapper.appendChild(dayNameP);
    classWrapper.appendChild(startLabel);
    classWrapper.appendChild(startInput);
    classWrapper.appendChild(durationLabel);
    classWrapper.appendChild(durationInput);
    classWrapper.appendChild(endLabel);
    classWrapper.appendChild(endInput);

    // === หัวข้อการสอน ===
    const topicSection = document.createElement('div');
    topicSection.className = 'topicSection';
    topicSection.id = 'topicSection' + DateCount;

    const topicLabel = document.createElement('p');
    topicLabel.innerText = 'เรื่องที่จะสอน';

    const topicInput = document.createElement('input');
    topicInput.type = 'text';
    topicInput.name = 'topicName';
    topicInput.id = 'topicName' + DateCount;
    topicInput.placeholder = 'เช่น บทที่ 1-2';

    const topicContainer = document.createElement('div');
    topicContainer.id = 'topicContainer' + DateCount;

    const btnAddTopic = document.createElement('button');
    btnAddTopic.type = 'button';
    btnAddTopic.innerText = 'เพิ่มหัวข้อ';
    btnAddTopic.onclick = function () {
        addTopic(topicContainer);
    };

    const btnRemoveTopic = document.createElement('button');
    btnRemoveTopic.type = 'button';
    btnRemoveTopic.className = 'removeTopicBtn';
    btnRemoveTopic.innerText = 'ลบหัวข้อ';
    btnRemoveTopic.onclick = function () {
        removeLastTopic(topicContainer);
    };

    topicSection.appendChild(topicLabel);
    topicSection.appendChild(topicInput);
    topicSection.appendChild(topicContainer);
    topicSection.appendChild(btnAddTopic);
    topicSection.appendChild(btnRemoveTopic);

    const hr = document.createElement('hr');

    // เพิ่มลง container
    container.appendChild(classWrapper);
    container.appendChild(topicSection);
    container.appendChild(hr);

    DateCount++;
}






  function addTopic(container) {
    const topicCount = container.querySelectorAll('input[type="text"]').length + 1;
    if (topicCount > 5) {
        alert("เพิ่มได้ไม่เกิน 5 หัวข้อ");
        return;
    }

    const topicDiv = document.createElement('div'); // div สำหรับ input ใหม่
    topicDiv.style.marginBottom = '5px';

    const topicInput = document.createElement('input');
    topicInput.type = 'text';
    topicInput.name = 'topicName';
    topicInput.placeholder = 'เช่น บทที่ 1-2';

    topicDiv.appendChild(topicInput);
    container.appendChild(topicDiv);  // append ต่อ ๆ กัน
}



  function removeLastTopic(container) {
    const topicDivs = container.querySelectorAll('div'); // เลือก div แต่ละหัวข้อ
    if (topicDivs.length > 0) {
        const lastDiv = topicDivs[topicDivs.length - 1];
        container.removeChild(lastDiv);
    } else {
        alert("ไม่มีหัวข้อให้ลบ");
    }
}
function calculateEndTime(startTimeStr, durationHours) {
    if (!startTimeStr || !durationHours) return '';
    const parts = startTimeStr.split(":");
    const h = parseInt(parts[0], 10);
    const m = parseInt(parts[1], 10);
    const totalMinutes = h * 60 + m + durationHours * 60;
    const endH = Math.floor(totalMinutes / 60) % 24;
    const endM = totalMinutes % 60;

    // เปลี่ยนตรงนี้
    return (endH < 10 ? '0' + endH : endH) + ':' + (endM < 10 ? '0' + endM : endM);
}



  function isTimeBetween(timeStr, startStr, endStr) {
    const [h, m] = timeStr.split(":").map(Number);
    const [sh, sm] = startStr.split(":").map(Number);
    const [eh, em] = endStr.split(":").map(Number);

    const time = h * 60 + m;
    const start = sh * 60 + sm;
    const end = eh * 60 + em;

    return time >= start && time <= end;
}
function isWithinAllowedTime(startTimeStr, endTimeStr) {
    const [sh, sm] = startTimeStr.split(":").map(Number);
    const [eh, em] = endTimeStr.split(":").map(Number);

    const startMinutes = sh * 60 + sm;
    const endMinutes = eh * 60 + em;

    const minAllowed = 8 * 60;    // 08:00
    const maxAllowed = 19 * 60;   // 19:00

    return startMinutes >= minAllowed && endMinutes <= maxAllowed;
}


function validateAddCourse(form) {
    // ----- ตรวจสอบชื่อรายวิชา -----
    const courseName = form.courseName.value.trim();
    if (courseName === "") {
        alert("กรุณากรอกชื่อรายวิชา");
        form.courseName.focus();
        return false;
    }
    const courseNamePattern = /^[A-Za-zก-๙0-9\s.-]{4,100}$/;
    if (!courseNamePattern.test(courseName)) {
        alert("กรุณากรอกชื่อรายวิชาเป็นอักขระภาษาไทย หรือ ภาษาอังกฤษเท่านั้น");
        form.courseName.focus();
        return false;
    }
    if (courseName.length < 4 || courseName.length > 100) {
        alert("กรุณากรอกชื่อรายวิชาให้มีความยาวตั้งแต่ 4 ตัวอักษรขึ้นไป และไม่เกิน 100 ตัวอักษร");
        form.courseName.focus();
        return false;
    }

    // ----- ตรวจสอบประเภทวิชา -----
    const cateName = form.cateName.value.trim();
    if (cateName === "") {
        alert("กรุณาเลือกประเภทของวิชา");
        form.cateName.focus();
        return false;
    }

    // ----- ตรวจสอบคำอธิบายรายวิชา -----
    const courseDescrip = form.courseDescrip.value.trim();
    const descripPattern = /^[\u0E00-\u0E7Fa-zA-Z0-9\s.,\/#\-ฯ():"'!?—…\n\r]+$/;
    if (courseDescrip === "") {
        alert("กรุณากรอกคำอธิบายรายวิชา");
        form.courseDescrip.focus();
        return false;
    }
    if (!descripPattern.test(courseDescrip)) {
        alert("กรุณากรอกคำอธิบายรายวิชาเป็นอักขระภาษาไทย, ภาษาอังกฤษ, ตัวเลข และเครื่องหมายพิเศษบางตัว");
        form.courseDescrip.focus();
        return false;
    }
    if (courseDescrip.length < 10 || courseDescrip.length > 255) {
        alert("กรุณากรอกคำอธิบายรายวิชาได้ตั้งแต่ 10 ตัวอักษรขึ้นไป และไม่เกิน 255 ตัวอักษร");
        form.courseDescrip.focus();
        return false;
    }

    // ----- ตรวจสอบจำนวนรับ -----
    const maxStu = form.maxStu.value.trim();
    if (maxStu === "") {
        alert("กรุณาเลือกจำนวนนักศึกษาที่รับ");
        form.maxStu.focus();
        return false;
    }

    // ----- ตรวจสอบราคา -----
    const price = form.price.value.trim();
    if (price === "") {
        alert("กรุณากรอกราคาคอร์ส");
        form.price.focus();
        return false;
    }
    const pricePattern = /^\d+$/;
    if (!pricePattern.test(price)) {
        alert("กรุณากรอกเป็นตัวเลขจำนวนเต็มบวกเท่านั้น (บาท)");
        form.price.focus();
        return false;
    }
    const priceNum = parseInt(price, 10);
    if (priceNum < 0) {
        alert("ราคาต้องไม่เป็นลบ (0 หมายถึงเรียนฟรี)");
        form.price.focus();
        return false;
    }

    // ----- ตรวจสอบวันสอนและหัวข้อสอน -----
    let selectedDates = new Set();
    for (let i = 0; i < DateCount; i++) {
        const classDateInput = document.getElementById('classDate' + i);
        const startTimeInput = document.getElementById('startTime' + i);
        const endTimeInput = document.getElementById('endTime' + i);
        const topicInput = document.getElementById('topicName' + i);
        const topicContainer = document.getElementById('topicContainer' + i);

        if (!classDateInput || !startTimeInput || !endTimeInput || !topicInput) continue;

        // ตรวจสอบวันที่สอน
        if (!classDateInput.value.trim()) {
            alert("กรุณาเลือกวันที่สอนของสัปดาห์ที่ " + (i + 1));
            classDateInput.focus();
            return false;
        }
        const inputDate = new Date(classDateInput.value.trim());
        const now = new Date();
        now.setHours(0,0,0,0);
        if (inputDate < now) {
            alert("วันที่สอนต้องเป็นวันในอนาคตหรือวันนี้เท่านั้น (สัปดาห์ที่ " + (i + 1) + ")");
            classDateInput.focus();
            return false;
        }

        // ตรวจสอบวันซ้ำ
        if (selectedDates.has(classDateInput.value.trim())) {
            alert("วันที่สอนซ้ำกัน! กรุณาเลือกวันอื่น (สัปดาห์ที่ " + (i + 1) + ")");
            classDateInput.focus();
            return false;
        }
        selectedDates.add(classDateInput.value.trim());

        // ตรวจสอบเวลาเริ่มและเลิก
        if (!startTimeInput.value.trim()) {
            alert("กรุณาเลือกเวลาเริ่มเรียนของสัปดาห์ที่ " + (i + 1));
            startTimeInput.focus();
            return false;
        }
        if (!endTimeInput.value.trim()) {
            alert("กรุณากรอกจำนวนชั่วโมงของสัปดาห์ที่ " + (i + 1));
            endTimeInput.focus();
            return false;
        }

        if (startTimeInput.value.trim() >= endTimeInput.value.trim()) {
            alert("เวลาเริ่มเรียนต้องน้อยกว่าเวลาเลิกเรียน (สัปดาห์ที่ " + (i + 1) + ")");
            startTimeInput.focus();
            return false;
        }
        if(!isWithinAllowedTime(startTimeInput.value, endTimeInput.value)){
            alert("จำนวนชั่วโมงที่กรอกจะต้องรวมกับเวลาเริ่มต้นไม่เกิน 07:00 PM (สัปดาห์ที่ " + (i+1) + ")");
            startTimeInput.focus();
            return false;
        }

        const startHour = parseInt(startTimeInput.value.split(":")[0], 10);
        const endHour = parseInt(endTimeInput.value.split(":")[0], 10);
        if (startHour < 8 || startHour > 19) {
            alert("เวลาเริ่มเรียนต้องอยู่ระหว่าง 08:00 AM - 07:00 PM (สัปดาห์ที่ " + (i + 1) + ")");
            startTimeInput.focus();   
            return false;
        }
        if (endHour < 8 || endHour > 19) {
            alert("จำนวนชั่วโมงที่กรอกจะต้องรวมกับเวลาเริ่มต้นไม่เกิน 07:00 PM  (สัปดาห์ที่ " + (i + 1) + ")");
            endTimeInput.focus();
            return false;
        }
        

        // ตรวจสอบหัวข้อสอน
        const topicPattern = /^[ก-๙A-Za-z0-9\s]{4,100}$/;
        if (!topicInput.value.trim()) {
            alert("กรุณากรอกเรื่องที่จะสอนของสัปดาห์ที่ " + (i + 1));
            topicInput.focus();
            return false;
        }
        if (!topicPattern.test(topicInput.value.trim())) {
            alert("กรุณากรอกเรื่องที่จะสอนเป็นภาษาไทย, อังกฤษ หรือ ตัวเลข ความยาว 4-100 ตัวอักษร (สัปดาห์ที่ " + (i + 1) + ")");
            topicInput.focus();
            return false;
        }

        // ตรวจสอบหัวข้อย่อย
        if (topicContainer) {
            const topicInputs = topicContainer.querySelectorAll('input[type="text"]');
            for (let t = 0; t < topicInputs.length; t++) {
                const val = topicInputs[t].value.trim();
                if (!val) {
                    alert("กรุณากรอกหัวข้อย่อยทั้งหมดของสัปดาห์ที่ " + (i + 1));
                    topicInputs[t].focus();
                    return false;
                }
                if (!topicPattern.test(val)) {
                    alert("หัวข้อย่อยต้องประกอบด้วยภาษาไทย อังกฤษ หรือ ตัวเลข ความยาว 4-100 ตัวอักษร (สัปดาห์ที่ " + (i + 1) + ")");
                    topicInputs[t].focus();
                    return false;
                }
            }
        }
    }

    return true;
}


</script>

<style>
  body {
    font-family: "Prompt", Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f2f5; 
    color: #333;
    }


    .header {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
        background-color: #007F3E;
        color: white;
        padding: 15px 25px;
        box-shadow: 0 3px 6px rgba(0,0,0,0.15);
    }
    h1 {
        color: #ffffff;
        font-size: 24px; 
    }
    a {
                text-decoration: none;
                color: #007F3E;
            }
    table {
        width: 90%;                
        max-width: 1200px ;          
        border-collapse: collapse;
        background: white;
        box-shadow: 0 0 8px rgba(0,0,0,0.1);
        font-size: 14px; 
        margin: 20px auto;         
    }

    th, td {
        padding: 10px;
        vertical-align: top;
    }

    th {
        background-color: #007F3E;
        color: white;
        text-align: left;
        font-size: 15px;
    }

    input[type=text],select, textarea {
        width: 100%;
        padding: 8px 10px;
        margin: 6px 0 15px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
        transition: 0.3s;
    }
    input[type=text]:focus, select:focus, textarea:focus {
        border-color: #2980b9;
        outline: none;
    }


    input[type=date], input[type=time]{
        width: 180%;


    }
    input[type=date]:focus, input[type=time]:focus{
        border-color: #2980b9;
        outline: none;

    }

    

    textarea {
        resize: vertical;
    }
    button {
        background-color: green;
        border: none;
        color: white;
        padding: 7px 14px;
        margin: 5px 5px 15px 0;
        border-radius: 4px;
        cursor: pointer;
        font-size: 13px;
        transition: background-color 0.3s;
    }
    button:hover {
        background-color: #1c5980;
    }

    input[type=submit], input[type=reset] {
        background-color: green;
        border: none;
        color: white;
        padding: 10px 20px;
        margin: 10px 0;
        border-radius: 6px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
    }
    input[type=submit]:hover {
        background-color: #1e8449;
    }
    input[type=reset] {
        background-color: #e74c3c;
    }
    input[type=reset]:hover {
        background-color: rgb(115, 0, 0);
    }

    
    button.removeBtn {
        background-color: #e74c3c; 
        color: white;
    }

    button.removeBtn:hover {
        background-color: #c0392b; 
    }

    button.removeTopicBtn {
        background-color: #e74c3c; 
        color: white;
    }

    button.removeTopicBtn:hover {
        background-color: #c0392b; 
    }
    .page-header {
        text-align: center;   
        margin-bottom: 20px;
    }

    .page-header h1 {
        color: #2c3e50;
        margin-bottom: 15px;
    }

    .header-links {
        display: flex;
        justify-content: center;  
        gap: 15px;                
    }

    .btn-link {
        display: inline-block;
        padding: 8px 16px;
        color: white;
        font-weight: bold;
        text-decoration: none;
        border-radius: 20px;
        transition: background-color 0.3s, transform 0.2s;
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


    .btn-home {
        background-color: #27ae60;
    }
    .btn-home:hover {
        background-color: #1e8449;
        transform: translateY(-2px);
    }

    .btn-mycourse {
        background-color: #27ae60;
    }
    .btn-mycourse:hover {
        background-color: #1e8449;
        transform: translateY(-2px);
    }
    .page-header-bar {
        background-color: #1e70d5;  
        color: white;               
        padding: 15px 20px;         
        text-align: center;         
        border-radius: 6px 6px 0 0; 
        box-shadow: 0 2px 6px rgba(0,0,0,0.1); 
    }
    .page-header-bar h1 {
        margin: 0; 
        font-size: 24px;
    }
    td a {
        margin-right: 15px;
        text-decoration: none;
        color: #2980b9;
    }
    td a:hover {
        text-decoration: underline;
    }
    .classDateRow {
        display: flex;
        align-items: center;
        gap: 5px;
        flex-wrap: wrap;
        margin-bottom: 10px;
    }

    .classDateRow label, 
    .classDateRow input, 
    .classDateRow p {
        margin: 0;
    }

</style>


<body>
    <div class="header">
          <a href="goHome"><h1>เพิ่มคอร์ส</h1></a>
    </div>

  <form name="frm1" action="addCourse" method="post"  accept-charset="UTF-8" onsubmit="return validateAddCourse(this);">

    <table>
        <p style="color: #c0392b;" class="error_result">${error_result}</p>
      
      <thead>
        <tr>
          <th>ข้อมูลหลักคอร์ส</th>
          <th>วันสอน และหัวข้อ</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td >
          <a href="goHome">&#8592;กลับหน้า Home</a>
        </td>
        <tr>
          <td valign="top">
            <p>ชื่อรายวิชา</p>
            <input type="text" name="courseName" id="courseName" placeholder="ชื่อวิชารายวิชาไทย-อังกฤษ เท่านั้น" >

            <p>ประเภท</p>
            <select name="cateName" id="cateName">
              <option value="">-- เลือกประเภทของวิชา --</option>
              <option value="หมวดวิชาศึกษาทั่วไป">หมวดวิชาศึกษาทั่วไป</option>
              <option value="หมวดวิชาเฉพาะ">หมวดวิชาเฉพาะ</option>
              <option value="หมวดวิชาเลือกเสรี">หมวดวิชาเลือกเสรี</option>
            </select>

            <p>คำอธิบายรายวิชา</p>
            <textarea name="courseDescrip" id="courseDescrip" rows="4"></textarea>

            <p>จำนวนที่รับ</p>
            <select name="maxStu">
              <option value="">เลือกจำนวนนักศึกษา</option>
              <c:forEach var="i" begin="1" end="50">
                <option value="${i}">${i}</option>
              </c:forEach>
            </select>

            <p>ราคา</p>
            <input type="text" name="price" id="price" placeholder="ระบุ" >
          </td>
          <td valign="top">
          
          <div>
             <button type="button" onclick="addClassDate()">เพิ่มวัน</button>
          <div id="addClassDate">
          <div class="classDateRow" id="classSection0" style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
              <label for="classDate0">วันที่สอน</label>
              <input type="date" name="classDate" id="classDate0" style="width:150px; gap: 20;" onchange="showDay(this.value, 'dayName0')">
              <p id="dayName0" style="width:100px; margin:0;" ></p>

              <label for="startTime0">เริ่ม</label>
              <input type="time" name="startTime" id="startTime0" style="width:100px;" onchange="updateEndTime(document.getElementById('duration0'))">

             <label for="duration0">จำนวนชั่วโมง</label>
             <input type="number" name="duration" id="duration0" style="width:60px;"  onchange="updateEndTime(this)">

              <label for="endTime0">เวลาสิ้นสุด</label>
              <input type="time" name="endTime" id="endTime0" style="width:100px;" readonly>
          </div>

            <div class="topicSection" id="topicSection0">
                <p>เรื่องที่จะสอน</p>
                <input type="text" name="topicName" id="topicName0" placeholder="เช่น บทที่ 1-2">
                <div id="topicContainer0"></div>
                <button type="button" onclick="addTopic(document.getElementById('topicContainer0'))">เพิ่มหัวข้อ</button>
                <button type="button" class="removeTopicBtn" onclick="removeLastTopic(document.getElementById('topicContainer0'))">ลบหัวข้อ</button>
            </div>
            <hr>
        </div>
          </td>
        </tr>
        <tr>
          <td><input type="reset" value="Reset"></td>
          <td><input type="submit" value="Submit"></td>
        </tr>
      </tbody>
    </table>
  </form>

</body>
</html>
