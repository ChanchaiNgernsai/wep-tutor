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


	let DateCount = 1;
	function addClassDate() {
	  if (DateCount >= 5) {
	    alert("เพิ่มได้ไม่เกิน 4 สัปดาห์");
	    return;
	  }

	  const container = document.getElementById('addClassDate');

	  // === กล่องหลักสำหรับวันสอนแถวเดียว ===
	  const flexDiv = document.createElement('div');
	  flexDiv.style.display = 'flex';
	  flexDiv.style.alignItems = 'center';
	  flexDiv.style.gap = '8px';
	  flexDiv.style.flexWrap = 'wrap';
	  flexDiv.style.marginBottom = '10px';
	  flexDiv.id = 'classSection' + DateCount;

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

	  // เวลาสิ้นสุด
	  const endLabel = document.createElement('label');
	  endLabel.htmlFor = 'endTime' + DateCount;
	  endLabel.innerText = 'ถึง';

	  const endInput = document.createElement('input');
	  endInput.type = 'time';
	  endInput.name = 'endTime';
	  endInput.id = 'endTime' + DateCount;
	  endInput.style.width = '100px';

	  // ปุ่มลบวัน
	  const btnRemoveDay = document.createElement('button');
	  btnRemoveDay.type = 'button';
	  btnRemoveDay.innerText = 'ลบวัน';
    btnRemoveDay.className = 'removeBtn';
	  btnRemoveDay.onclick = function () {
	    container.removeChild(flexDiv);
	    container.removeChild(topicSection);
	    container.removeChild(hr);
	    DateCount--;
	  };

	  // === หัวข้อการสอน ===
	  const topicSection = document.createElement('div');

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
	  btnRemoveTopic.innerText = 'ลบหัวข้อ';
    btnRemoveTopic.className = 'removeBtn'; 
	  btnRemoveTopic.onclick = function () {
	    removeLastTopic(topicContainer);
	  };

	  // สร้างเส้นคั่น
	  const hr = document.createElement('hr');

	  // === เพิ่มทั้งหมดเข้าไป ===
	  flexDiv.appendChild(classDateLabel);
	  flexDiv.appendChild(dateInput);
	  flexDiv.appendChild(dayNameP);
	  flexDiv.appendChild(startLabel);
	  flexDiv.appendChild(startInput);
	  flexDiv.appendChild(endLabel);
	  flexDiv.appendChild(endInput);
	  flexDiv.appendChild(btnRemoveDay);

	  topicSection.appendChild(topicLabel);
	  topicSection.appendChild(topicInput);
	  topicSection.appendChild(btnAddTopic);
	  topicSection.appendChild(btnRemoveTopic);
	  topicSection.appendChild(topicContainer);

	  container.appendChild(flexDiv);
	  container.appendChild(topicSection);
	  container.appendChild(hr);

	  DateCount++;
	}




  
  function removeLastClassDate() {
	  if (DateCount <= 1) {
	    alert("ไม่มีวันสอนให้ลบแล้ว");
	    return;
	  }
	  DateCount--;
	  const container = document.getElementById('addClassDate');
	  const lastSection = document.getElementById('classSection' + DateCount);
	  if (lastSection) {
	    container.removeChild(lastSection);
	  }
	}

  function addTopic(container) {
    const topicCount = container.querySelectorAll('input[type="text"]').length + 1;
    if (topicCount >= 5) {
      alert("เพิ่มได้ไม่เกิน 5 หัวข้อ");
      return;
    }

    const br = document.createElement('br');
    const topicInput = document.createElement('input');
    topicInput.type = 'text';
    topicInput.name = 'topicName';

    container.appendChild(br);
    container.appendChild(topicInput);
  }

  function removeLastTopic(container) {
    const topics = container.querySelectorAll('input[type="text"]');
    if (topics.length > 0) {
      const lastInput = topics[topics.length - 1];
      if (lastInput.previousSibling && lastInput.previousSibling.tagName === 'BR') {
        container.removeChild(lastInput.previousSibling);
      }
      container.removeChild(lastInput);
    } else {
      alert("ไม่มีหัวข้อให้ลบ");
    }
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

function validateAddCourse(form) {
    // ----- ตรวจสอบชื่อรายวิชา -----
    const courseName = form.courseName.value.trim();
    if (courseName === "") {
        alert("กรุณากรอกชื่อรายวิชา");
        form.courseName.focus();
        return false;
    }
    const courseNamePattern = /^[A-Za-zก-ฮะ-๙\s]{2,100}$/;
    if (!courseNamePattern.test(courseName)) {
        alert("กรุณากรอกเป็นอักขระภาษาไทย หรือ ภาษาอังกฤษเท่านั้น");
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

    // ตรวจสอบคำอธิบายรายวิชา
    const courseDescrip = form.courseDescrip.value.trim();
    const descripPattern = /^[\u0E00-\u0E7Fa-zA-Z0-9\s.,\/#\-ฯ():"'!?—…\n\r]+$/;

    if (courseDescrip === "") {
        alert("กรุณากรอกคำอธิบายรายวิชา");
        form.courseDescrip.focus();
        return false;
    }
    if (!descripPattern.test(courseDescrip)) {
        alert("กรุณากรอกคำอธิบายรายวิชาเป็นอักขระภาษาไทย, ภาษาอังกฤษ, ตัวเลข และเครื่องหมายพิเศษบางตัว เช่น – …");
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
        alert("กรุณากรอกเป็นตัวเลขจำนวนเต็มบวกเท่านั้น (รูปแบบเงินบาท)");
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
    for (let i = 0; i < DateCount; i++) {
        const idx = i === 0 ? "" : i; // สัปดาห์แรก id ไม่มีเลข
        const classDateInput = document.getElementById('classDate' + idx);
        const startTimeInput = document.getElementById('startTime' + idx);
        const endTimeInput = document.getElementById('endTime' + idx);
        const topicInput = document.getElementById('topicName' + idx);

        if (!classDateInput || !startTimeInput || !endTimeInput || !topicInput) continue;

        // ตรวจสอบวันที่สอน
        if (classDateInput.value.trim() === "") {
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

        // ตรวจสอบเวลาเริ่มและเลิก
        if (startTimeInput.value.trim() === "") {
            alert("กรุณาเลือกเวลาเริ่มเรียนของสัปดาห์ที่ " + (i + 1));
            startTimeInput.focus();
            return false;
        }
        if (endTimeInput.value.trim() === "") {
            alert("กรุณาเลือกเวลาเลิกเรียนของสัปดาห์ที่ " + (i + 1));
            endTimeInput.focus();
            return false;
        }

        if (startTimeInput.value.trim() >= endTimeInput.value.trim()) {
            alert("เวลาเริ่มเรียนต้องน้อยกว่าเวลาเลิกเรียน (สัปดาห์ที่ " + (i + 1) + ")");
            startTimeInput.focus();
            return false;
        }

        const startHour = parseInt(startTimeInput.value.split(":")[0], 10);
        const endHour = parseInt(endTimeInput.value.split(":")[0], 10);
        if (startHour < 8 || startHour > 19) {
            alert("เวลาเริ่มเรียนต้องอยู่ระหว่าง 08:00 - 19:00 (สัปดาห์ที่ " + (i + 1) + ")");
            startTimeInput.focus();
            return false;
        }
        if (endHour < 8 || endHour > 19) {
            alert("เวลาเลิกเรียนต้องอยู่ระหว่าง 08:00 - 19:00 (สัปดาห์ที่ " + (i + 1) + ")");
            endTimeInput.focus();
            return false;
        }

        // ตรวจสอบหัวข้อสอน
        const topicPattern = /^[ก-๙เ-๛A-Za-z0-9\s]/;
        if (topicInput.value.trim() === "") {
            alert("กรุณากรอกเรื่องที่จะสอนของสัปดาห์ที่ " + (i + 1));
            topicInput.focus();
            return false;
        }
        if (!topicPattern.test(topicInput.value.trim())) {
            alert("กรุณากรอกเรื่องที่จะสอนเป็นภาษาไทยหรือภาษาอังกฤษและตัวเลขเท่านั้น (สัปดาห์ที่ " + (i + 1) + ")");  
            topicInput.focus();
            return false;
        }
        if (topicInput.value.trim().length < 4 || topicInput.value.trim().length > 100) {
            alert("กรุณากรอกเรื่องที่จะสอนความยาว 4-100 ตัวอักษร (สัปดาห์ที่ " + (i + 1) + ")");
            topicInput.focus();
            return false;
        }

        // ตรวจสอบหัวข้อย่อย
        const topicContainer = document.getElementById('topicContainer' + idx);
        if (topicContainer) {
            const topicInputs = topicContainer.querySelectorAll('input[type="text"]');
            for (let t = 0; t < topicInputs.length; t++) {
                const val = topicInputs[t].value.trim();
                if (val === "") {
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
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 20px;
    background: #f9f9f9;
    color: #333;
  }
  h1 {
    color: #2c3e50;
    margin-bottom: 15px;
  }
  a {
    margin-right: 15px;
    color: #2980b9;
    text-decoration: none;
  }
  a:hover {
    text-decoration: underline;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    box-shadow: 0 0 8px rgba(0,0,0,0.1);
  }
  th, td {
    padding: 15px;
    vertical-align: top;
  }
  th {
    background-color: #3498db;
    color: white;
    text-align: left;
  }
  input[type=text], input[type=date], input[type=time], select, textarea {
    width: 100%;
    padding: 8px 10px;
    margin: 6px 0 15px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
    transition: 0.3s;
  }
  input[type=text]:focus, input[type=date]:focus, input[type=time]:focus, select:focus, textarea:focus {
    border-color: #2980b9;
    outline: none;
  }
  textarea {
    resize: vertical;
  }
  button {
    background-color: #2980b9;
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
  /* วันที่สอน + หัวข้อ */
  #addClassDate > div, #addClassDate > hr, #addClassDate > div + div {
    margin-bottom: 15px;
  }
  /* Flex container for each class date */
  .classDateRow {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 10px;
  }
  .classDateRow label {
    min-width: 60px;
    font-weight: 600;
  }
  .classDateRow input[type=date], 
  .classDateRow input[type=time] {
    width: 140px;
  }
  .dayNameDisplay {
    min-width: 90px;
    font-weight: bold;
    font-size: 16px;
    color: #2c3e50;
  }
  /* หัวข้อสอน */
  .topicSection {
    background: #f0f8ff;
    padding: 10px 12px;
    border-radius: 6px;
  }
  .topicSection p {
    margin: 5px 0 10px 0;
    font-weight: 600;
  }
  .topicSection input[type=text] {
    width: auto;
    min-width: 200px;
    margin-right: 10px;
    margin-bottom: 8px;
  }
  .topicSection button {
    padding: 5px 10px;
    font-size: 12px;
  }
  /* ปุ่ม submit/reset */
  input[type=submit], input[type=reset] {
    background-color: #27ae60;
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
    background-color: white;
  }

  
  button.removeBtn {
      background-color: #e74c3c; 
      color: white;
  }

  button.removeBtn:hover {
      background-color: #c0392b; 
  }

  button.removeTopicBtn {
    background-color: #e74c3c; /* สีแดง */
    color: white;
}

button.removeTopicBtn:hover {
    background-color: #c0392b; /* สีแดงเข้มเมื่อ hover */
}


  

</style>


<body>
  <h1>New Course</h1>
  <a href="goHome">กลับหน้า Home</a><br>
  <a href="listTutorCourses">คอร์สของฉัน</a> 

  <p style="color: #c0392b;" class="error_result">${error_result}</p>

  <form name="frm1" action="addCourse" method="post"  accept-charset="UTF-8" onsubmit="return validateAddCourse(this);">
    <table>
      <thead>
        <tr>
          <th>ข้อมูลหลักคอร์ส</th>
          <th>วันสอน และหัวข้อ</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td valign="top">
            <p>ชื่อรายวิชา</p>
            <input type="text" name="courseName" id="courseName" placeholder="ชื่อวิชารายวิชาไทย-อังกฤษ เท่านั้น" >

            <p>ประเภท</p>
            <select name="cateName" id="cateName">
              <option value="">-- เลือกประเภทของวิชา --</option>
              <option value="general">หมวดวิชาศึกษาทั่วไป</option>
              <option value="specific">หมวดวิชาเฉพาะ</option>
              <option value="elective">หมวดวิชาเลือกเสรี</option>
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
            
            
          <div style="display: flex; align-items: center; gap: 8px; flex-wrap: wrap;">
				  <label for="classDate">วันที่สอน</label>
				  <input type="date" name="classDate" id="classDate" onchange="showDay(this.value, 'dayName')" style="width: 150px;">
				  
				  <p id="dayName"></p>
				  
				  <label for="startTime">เริ่ม</label>
				  <input type="time" name="startTime" id="startTime" style="width: 100px;">
				  
				  <label for="endTime">ถึง</label>
				  <input type="time" name="endTime" id="endTime" style="width: 100px;">
				  
				  <button type="button" onclick="addClassDate()">เพิ่มวัน</button>
		 </div>
				
            <p>เรื่องที่จะสอน</p>
            <input type="text" name="topicName" id="topicName" placeholder="เช่น บทที่ 1-2" >
            	<div id="addTopic"></div>
            <button type="button" onclick="addTopic(document.getElementById('addTopic'))">เพิ่มหัวข้อ</button>
            <button type="button" class="removeTopicBtn" onclick="removeLastTopic(document.getElementById('addTopic'))">ลบหัวข้อ</button>
            
			<hr>
            	<div id="addClassDate"></div>
              
          </td>
        </tr>
        <tr>
          <td><input type="reset" value="cancel"></td>
          <td><input type="submit" value="Submit"></td>
        </tr>
      </tbody>
    </table>
  </form>

</body>
</html>
