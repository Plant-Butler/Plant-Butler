<%@ page import="com.plant.vo.UserVo" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-04-26
  Time: 오전 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            resultHtml = "<table border='1'>";
            resultHtml += "<tr><th>Plant Name</th><th>FML Code Name</th><th>Advise Info</th></tr>";
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
            newWindow = window.open("", "_blank");
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
<h1>regist form</h1>
<%
  UserVo userVo = (UserVo) session.getAttribute("user");
  String userId = userVo.getUserId();
%>
<form action="/myplants/form" method="post" enctype="multipart/form-data">
  <table>
    <tr>
      <td>내식물 검색하기</td>
      <td><input type="text" name="name" id="searchInput"></td>
      <td><button type="button" class="detailBtn" onclick="printDetail()">검색</button></td>
    </tr>
  </table>

  <div id="searchResults"></div>
  <table>
    <tr>
      <td>식물아이디 :</td>
      <td><input type="text" name="plantId" readonly="readonly" id="code"></td>
      <td></td>
    </tr>
    <tr>
      <td>유저닉네임 :</td>
      <td><input type="text" name="userId" value="<%=userId%>" readonly="readonly"></td>
      <td></td>
    </tr>
    <tr>
      <td>식물닉네임 :</td>
      <td><input type="text" name="myplantNick"></td>
      <td></td>
    </tr>
    <tr>
      <td>내 식물 이미지:</td>
      <td><input type="file" name="uploadedImages" multiple></td>
      <td></td>
    </tr>
    <tr>
      <td>내 화분 종류:</td>
      <td>
        <input type="radio" class="flowerpot" name="myplantWeight" value="1">원통형
        <input type="radio" class="flowerpot" name="myplantWeight" value="2">사각형
      </td>
      <td></td>
    </tr>
    <tr>
      <td>내 화분 높이 :</td>
      <td><input type="text" name="myplantLength"></td>
      <td></td>
    </tr>
    <tr>
      <td id="diameter1-unit">내 화분 밑 지름:</td>
      <td>
        <input type="text" name="myplantRadius1">
      </td>
      <td></td>
    </tr>
    <tr>
      <td id="diameter2-unit">내 화분 윗 지름:</td>
      <td>
        <input type="text" name="myplantRadius2">

      </td>
      <td></td>
    </tr>
    <tr>
      <td>분양일:</td>
      <td><input type="date" name="firstDate"></td>
      <td></td>
    </tr>
  </table>

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
  <button type="submit">제출하기</button>
</form>

</body>
</html>