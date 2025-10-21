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


	let DateCount = 1; // ใช้ติดตามจำนวนสัปดาห์

function addClassDate() {
    if (DateCount >= 5) {
        alert("เพิ่มได้ไม่เกิน 4 สัปดาห์");
        return;
    }

    const container = document.getElementById('addClassDate');

    // === กล่องหลักสำหรับวันสอน ===
    const classWrapper = document.createElement('div');
    classWrapper.style.display = 'flex';
    classWrapper.style.alignItems = 'center';
    classWrapper.style.gap = '8px';
    classWrapper.style.flexWrap = 'wrap';
    classWrapper.style.marginBottom = '10px';
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

    // เวลาสิ้นสุด
    const endLabel = document.createElement('label');
    endLabel.htmlFor = 'endTime' + DateCount;
    endLabel.innerText = 'ถึง';

    const endInput = document.createElement('input');
    endInput.type = 'time';
    endInput.name = 'endTime';
    endInput.id = 'endTime' + DateCount;
    endInput.style.width = '100px';

    // รวมทุกอย่างลงใน classWrapper
    classWrapper.appendChild(btnRemoveDay);
    classWrapper.appendChild(classDateLabel);
    classWrapper.appendChild(dateInput);
    classWrapper.appendChild(dayNameP);
    classWrapper.appendChild(startLabel);
    classWrapper.appendChild(startInput);
    classWrapper.appendChild(endLabel);
    classWrapper.appendChild(endInput);

   // === หัวข้อการสอน ===
const topicSection = document.createElement('div');
topicSection.className = 'topicSection';
topicSection.id = 'topicSection' + DateCount;

const topicLabel = document.createElement('p');
topicLabel.innerText = 'เรื่องที่จะสอน';

// input หลักของสัปดาห์
const topicInput = document.createElement('input');
topicInput.type = 'text';
topicInput.name = 'topicName';
topicInput.id = 'topicName' + DateCount;
topicInput.placeholder = 'เช่น บทที่ 1-2';

// container สำหรับหัวข้อย่อย
const topicContainer = document.createElement('div');
topicContainer.id = 'topicContainer' + DateCount;

// ปุ่มเพิ่ม-ลบหัวข้อ ย้ายมาวาง **ท้ายสุด**
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

// append ทุกอย่างลง topicSection
topicSection.appendChild(topicLabel);
topicSection.appendChild(topicInput);       // input หลัก
topicSection.appendChild(topicContainer);   // container ว่างสำหรับหัวข้อย่อย
topicSection.appendChild(btnAddTopic);      // ปุ่มเพิ่ม
topicSection.appendChild(btnRemoveTopic);   // ปุ่มลบ



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
        // ----- ตรวจสอบวันสอนซ้ำ -----
        let selectedDates = new Set();
        for (let i = 0; i < DateCount; i++) {
            const idx = i === 0 ? "" : i;
            const classDateInput = document.getElementById('classDate' + idx);
            if (!classDateInput) continue;

            const dateVal = classDateInput.value.trim();
            if (dateVal === "") continue;

            if (selectedDates.has(dateVal)) {
                alert("วันที่สอนซ้ำกัน! กรุณาเลือกวันอื่น (สัปดาห์ที่ " + (i + 1) + ")");
                classDateInput.focus();
                return false;
            }
            selectedDates.add(dateVal);
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
            alert("เวลาเริ่มเรียนต้องอยู่ระหว่าง 08:00 AM - 19:00 PM (สัปดาห์ที่ " + (i + 1) + ")");
            startTimeInput.focus();
            return false;
        }
        if (endHour < 8 || endHour > 19) {
            alert("เวลาเลิกเรียนต้องอยู่ระหว่าง 08:00 AM - 19:00 PM (สัปดาห์ที่ " + (i + 1) + ")");
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
    width: 80%;                /* ลดขนาดตารางลง */
    max-width: 900px;          /* กำหนดความกว้างสูงสุด */
    border-collapse: collapse;
    background: white;
    box-shadow: 0 0 8px rgba(0,0,0,0.1);
    font-size: 14px; 
    margin: 20px auto;         /* ทำให้ table อยู่กลางหน้า */
}

th, td {
    padding: 10px;
    vertical-align: top;
}

th {
    background-color: #21bf70;
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
    background-color: #21bf70;
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
    text-align: center;   /* ทำให้ทั้งหมดอยู่กลาง */
    margin-bottom: 20px;
}

.page-header h1 {
    color: #2c3e50;
    margin-bottom: 15px;
}

.header-links {
    display: flex;
    justify-content: center;  /* จัดลิงก์ให้อยู่กลาง */
    gap: 15px;                /* เว้นระยะห่างระหว่างลิงก์ */
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
    background-color: #1e70d5;  /* สีแทบด้านบน */
    color: white;               /* สีตัวอักษร */
    padding: 15px 20px;         /* ระยะห่างด้านบน-ล่าง, ซ้าย-ขวา */
    text-align: center;         /* จัดให้อยู่กลาง */
    border-radius: 6px 6px 0 0; /* มุมบนซ้าย-ขวาโค้ง ถ้าต้องการ */
    box-shadow: 0 2px 6px rgba(0,0,0,0.1); /* เพิ่มเงาเล็กน้อย */
}
.page-header-bar h1 {
    margin: 0; /* ลบ margin ของ h1 */
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



</style>


<body>
    <div class="page-header">
    <h1>Add Course</h1>
</div>

  <form name="frm1" action="addCourse" method="post"  accept-charset="UTF-8" onsubmit="return validateAddCourse(this);">
  <p style="color: #c0392b;" class="error_result">${error_result}</p>
    <table>
      
      
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
          <a href="listTutorCourses">คอร์สของฉัน&#8594;</a>
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
            
            
          <div style="display: flex; align-items: center; gap: 8px; flex-wrap: wrap;">
             <button type="button" onclick="addClassDate()">เพิ่มวัน</button>
            <label for="classDate">วันที่สอน</label>
            <input type="date" name="classDate" id="classDate" onchange="showDay(this.value, 'dayName')" style="width: 150px;">
            
            <p id="dayName"></p>
            <label for="startTime">เริ่ม</label>
            <input type="time" name="startTime" id="startTime" style="width: 100px;">
            
            <label for="endTime">ถึง</label>
            <input type="time" name="endTime" id="endTime" style="width: 100px;">
		      </div>
				
            <p>เรื่องที่จะสอน</p>
                <div id="addTopic"></div>
                <input type="text" name="topicName" id="topicName" placeholder="เช่น บทที่ 1-2" >
                <button type="button" onclick="addTopic(document.getElementById('addTopic'))">เพิ่มหัวข้อ</button>
                <button type="button" class="removeTopicBtn" onclick="removeLastTopic(document.getElementById('addTopic'))">ลบหัวข้อ</button>
			<hr>
            	<div id="addClassDate"></div>
              
              
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
