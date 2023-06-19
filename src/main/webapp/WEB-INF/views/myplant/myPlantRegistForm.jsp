
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../main/header.jsp" %>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">

  <script>
    function insertValue(value) {
      var textBox = document.getElementById("code");
      textBox.value = value;
      newWindow.close();
    }
    window.insertValue = insertValue;
  </script>
  <script>
    var newWindow;

    function printDetail() {
      var inputValue = $("#searchInput").val();
      console.log("Input value:", inputValue);
      $.ajax({
        url: "/myplants/search/" + inputValue,
        type: "GET",
        success: function(data) {
          $("#searchResults").html("");
          console.log("Response data:", data);
          var resultHtml = "";
          if (data && data.length > 0) {
            resultHtml = `
  <style>
    .styled-table {
      border-collapse: collapse;
      margin: 25px 0;
      font-size: 0.9em;
      font-family: sans-serif;
      min-width: 1000px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
    }
    .styled-table thead tr {
      background-color: #009879;
      color: #ffffff;
      text-align: left;
    }
    .styled-table th,
    .styled-table td {
      padding: 12px 15px;
        text-align: center;
    }
    .styled-table tbody tr {
      border-bottom: 1px solid #dddddd;
    }
    .styled-table tbody tr:nth-of-type(even) {
      background-color: #f3f3f3;
    }
    .styled-table tbody tr:last-of-type {
      border-bottom: 2px solid #009879;
    }
    .styled-table tbody tr.active-row {
      font-weight: bold;
      color: #009879;
    }
  </style>
  <table class="styled-table">
`;
            resultHtml += "<thead><tr><th>식물 명</th><th>식물 과</th><th>기본 정보</th><th style='width: 200px;'>선택</th></tr></thead>";
            for (var i = 0; i < data.length; i++) {
              var plantId = data[i]["plant_id"];
              var plantName = data[i]["distbNm"];
              var fmlCodeNm = data[i]["fmlCodeNm"];
              var adviseInfo = data[i]["adviseInfo"];

              resultHtml += "<tr>";
              resultHtml += "<td>" + plantName + "</td>";
              resultHtml += "<td>" + fmlCodeNm + "</td>";
              resultHtml += "<td>" + adviseInfo + "</td>";
              resultHtml += "<td><button type='button' value='" + plantId + "' onclick='window.opener.insertValue(this.value)'>선택하기</button></td>";
              resultHtml += "</tr>";
            }
            resultHtml += "</table>";
          } else {
            resultHtml = "<p>No results found.</p>";
          }
          if (!newWindow || newWindow.closed) {
            newWindow = window.open("", "_blank",'width=1000,height=400,top=0,left=0');
          }
          newWindow.document.body.innerHTML = resultHtml;
        },
        error: function(xhr, status, error) {
          console.log(status, error);
        }
      });
    }
  </script>
  <title>Title</title>
</head>
<body>
<div style="margin-top: 200px; display: flex; justify-content: center; align-items: center; margin-bottom: 150px;">
<style>
  .custom-input {
    border: 2px solid #ccc;
    border-radius: 4px;
    padding:8px;
    font-size: 16px;
    outline: none;
    transition: border-color 0.3s ease;
  }

  .custom-input:focus {
    border-color: #4caf50;
  }

  .custom-input.invalid {
    border-color: #dc3545;
  }

  .custom-input.valid {
    border-color: #28a745;
  }

  .newh1{
    font-size: 3em;
    color: #000000;
    text-align: center;
  }

  .custom-textarea {
    width: 60%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    resize: vertical;
  }
  .newform {
    width: 1100px;
    margin: 0 auto;
    font-family: Arial, sans-serif;
  }

  .form_table {
    padding: 70px;
    border-radius: 5px;
  }

  .title {
    margin-top: 0;
    font-size: 18px;
  }

  .upload_writer,
  .upload_date,
  .upload_title,
  .upload_img,
  .upload_data {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
  }

  .custom-textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    resize: vertical;
    font-size: 16px;
  }

  .submit {
    text-align: center;
  }

  .submit input[type="submit"] {
    padding: 10px 20px;
    background-color: #4caf50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
  }

  .submit input[type="submit"]:hover {
    background-color: #45a049;
  }

  .radio-group {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }

  .radio-group label {
    margin-left: 10px;
    font-size: 16px;
    cursor: pointer;
  }

  .selected-plants {
    margin-top: 10px;
    font-size: 16px;
    font-weight: bold;
  }

  .selected-plants-list {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }

  .selected-plants-list li {
    margin-bottom: 5px;
  }
  .col-25 {
    float: left;
    width: 25%;
    margin-top: 6px;
  }
  .form_wrapper {
    border: 3px solid #eaeaea;
    border-radius: 30px;
    padding: 10px;
    margin-bottom: -20px; /* Adjust the value as needed */
  }

  .newpostlayer{
    font-weight: bold;
    font-size: 20px;
    font-family: "Jeju Gothic";
  }

</style>
<div class="custom-input" style="height: 800px; width: 700px; margin-top: 100px; display: flex; flex-direction: column; justify-content: flex-start; align-items: center;">
  <h1 style="font-family: 'Hahmlet', serif; margin-bottom: 30px;">식물 등록하기</h1>
  <form action="/myplants/form" method="post" enctype="multipart/form-data">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <table style="margin-bottom: 20px; width: 100%;">
      <tr>
        <td style="padding: 10px;">내식물 검색하기 : </td>
        <td style="padding: 10px; padding-left: 90px;"><input type="text" class ="custom-input" name="name" id="searchInput" required></td>
        <td style="padding: 10px; margin-left: 50px;"><button type="button" class="detailBtn custom-input" onclick="printDetail()">검색</button></td>
      </tr>
    </table>
    <div id="searchResults"></div>
    <table style="width: 100%;">
      <tr>
        <td style="padding: 10px;">식물아이디 :</td>
        <td style="padding: 10px;"><input class ="custom-input" type="text" name="plantId" readonly="readonly" id="code" required></td>
      </tr>
      <tr>
        <td style="padding: 10px;">유저닉네임 :</td>
        <td style="padding: 10px;"><input class ="custom-input" type="text" name="userId" value="${userId}" readonly="readonly" required></td>
      </tr>
    <tr>
      <td style="padding: 10px;">식물닉네임 :</td>
      <td style="padding: 10px;"><input class ="custom-input" type="text" name="myplantNick" required></td>
      <td></td>
    </tr>
    <tr>
      <td style="padding: 10px;">내 식물 이미지:</td>
      <td><input style="width: 300px;" class ="custom-input" type="file" name="uploadedImages" multiple></td>
      <td></td>
    </tr>
    <tr>
      <td style="padding: 10px;">내 화분 종류:</td>
      <td>
        <input type="radio" class="flowerpot" name="myplantPot" value="1" required>원통형
        <input type="radio" class="flowerpot" name="myplantPot" value="2" required>사각형
      </td>
      <td></td>
    </tr>
    <tr>
      <td style="padding: 10px;">내 화분 높이 :</td>
      <td style="padding: 10px;"><input class ="custom-input" type="text" name="myplantLength" required></td>
      <td></td>
    </tr>
    <tr>
      <td style="padding: 10px;" id="diameter1-unit">내 화분 밑 지름:</td>
      <td style="padding: 10px;">
        <input style="padding: 10px;" class ="custom-input" type="text" name="myplantRadius1" required>
      </td>
      <td></td>
    </tr>
    <tr>
      <td style="padding: 10px;" id="diameter2-unit">내 화분 윗 지름:</td>
      <td>
        <input style="padding: 10px;" class ="custom-input" type="text" name="myplantRadius2" required>

      </td>
      <td></td>
    </tr>
    <tr>
      <td style="padding: 10px;" >분양일:</td>
      <td style="padding: 10px;"><input class ="custom-input" type="date" name="firstDate" required></td>
      <td></td>
    </tr>
  </table>

    <button type="submit" class="custom-input" style="margin-top: 20px; margin-left: 300px;">제출하기</button>
  </form>
</div>
</div>
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px;">
  <div class="container1"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>
</body>
<script>
  const radioButtons = document.querySelectorAll('.flowerpot');
  const diameter1Unit = document.getElementById('diameter1-unit');
  const diameter2Unit = document.getElementById('diameter2-unit');

  radioButtons.forEach(function(radioButton) {
    radioButton.addEventListener('change', function() {
      if (this.value === '1') {
        diameter1Unit.textContent = '내 화분 밑 지름:';
        diameter2Unit.textContent = '내 화분 윗 지름:';
      } else if (this.value === '2') {
        diameter1Unit.textContent = '가로:';
        diameter2Unit.textContent = '세로:';
      }
    });
  });
</script>

</html>