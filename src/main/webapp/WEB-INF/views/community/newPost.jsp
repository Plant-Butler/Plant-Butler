<%@page import="com.plant.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../main/header.jsp" %> --%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write Item</title>
<%@ include file="../main/header.jsp" %>

</head>

<body>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
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
        font-weight: 700;
        font-style: normal;
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
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .newpostlayer{
        font-weight: bold;
        font-size: 20px;
        font-family: "Jeju Gothic";
    }

    input[type="radio"] {
      display: none;
    }

    .custom-radio {
      display: inline-block;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      border: 2px solid #ccc;
      background-color: #fff;
      margin-right: 10px;
      cursor: pointer;
    }

    .radio-label {
      font-weight: bold;
    }

    /* Add spacing between radio buttons */
    input[type="radio"] + label {
      margin-right: 20px;
    }

    input[type="radio"]:checked + label .custom-radio {
      background-color: #4caf50; /* Replace with your desired color for checked radio button */
      border-color: #4caf50;
    }

    input[type="radio"]:checked + label .radio-label {
      color: #4caf50; /* Replace with your desired color for checked label text */
    }
    .newsubmit{
      padding: 10px 20px;
      background-color: #4caf50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
    .selectbutton{
      padding: 5px 10px;
      background-color: #4caf50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 13px;
    }
    .nickname {
      margin-right: 10px;
    }

</style>

<div class="about-section" style="margin-top: 300px">
    <h1 class = "newh1">새 게시물</h1>
</div>
<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String formattedNow = now.format(formatter);
%>
   <form action="./form" method="post" enctype="multipart/form-data" class = "newform">
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
       <input type="hidden" name="userId" id="userId" value="${userVo.userId}">
       <br>
       <div class="form_wrapper">
   <div class = "form_table" style="margin-top: 10px margin-bottom: 10px">
       <div class="col-25">
         <label class= "newpostlayer" for="fname">태그</label>
       </div>
       <div>
       <input type="radio" name="postTag" value="information" class="ajaxClick" id="information" required>
       <label for="information">
         <span class="custom-radio"></span>
         <span class="radio-label">정보 공유</span>
       </label>

       <input type="radio" name="postTag" value="boast" class="ajaxClick" id="boast" required>
       <label for="boast">
         <span class="custom-radio"></span>
         <span class="radio-label">식물 자랑</span>
       </label>

       <input type="radio" name="postTag" value="chat" class="ajaxClick" id="chat" required>
       <label for="chat">
         <span class="custom-radio"></span>
         <span class="radio-label">수다</span>
       </label>
</div>
         <p id="result" style="display: none;">
         <br>
         </p>
          <br>
          <input class = "myplants" type="hidden" name="selectedPlants" id="selectedPlantsInput" value="">
            [선택된 내 식물]
             <br>
            <p id="selectedMyplantNick" style="display: none;"></p>
            <br><br>
            <div class="col-25">
             <label class= "newpostlayer" for="fname">제목</label>
           </div>
             <div>
                <input class="custom-input" type="text" name="postTitle" id = "postTitle">
             </div>
            <br> <br>
            <div class="col-25">
             <label class= "newpostlayer" for="fname">내용</label>
            </div>
             <br>
            <div>
                <textarea class="custom-input" cols="80" rows="10" name="postContent" ></textarea>
            </div>
             <br>
            <br> <br>
            <div class="col-25">
             <label class= "newpostlayer" for="fname">이미지첨부</label>
            </div>
            <div>
                <input class="custom-input" class="upload_img" type="file" name="postMultiImage" multiple>
            </div>

            <br> <br> <br>
            <div class="col-25">
             <label class= "newpostlayer" for="fname">데이터첨부</label>
            </div>
             <div>
                <input class="custom-input" class="upload_data" type="file" name="postMultiFile">
            </div>
    <br>
    <br>
    </div>
    </div>
    <br>
    <br>
    <div class="submit">
      <input class = "newsubmit" type="submit" value="작성">
    </div>
    <br>
    <br>
    <br>
   </form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {

     window.selectedPlants = [];
     window.selectedPlantsNick = [];
     $("input[type='radio']").change(function(e){
       var useYn = $(this).val();
       var userId = "${userVo.userId}";
       if (useYn == "boast" || useYn == "information") {
         $.ajax({
           url: "/community/plantall",
           type: "GET",
           dataType: "json",
           data: { userId : userId, selectedPlants: selectedPlants },
           success: function(data) {
             $("#result").show();
             var html = "";
             for (var i = 0; i < data.length; i++) {
                console.log(data[i])
                html += "<br><li><span class='nickname'>" + data[i].myplantNick + "</span>";
                html += '<button class="selectbutton" type="button" onclick="postMyplant(' + data[i].myplantId + ', ' + "'" + data[i].myplantNick + "'" + ')">선택</button></li>';
             }
             html += "</ul>";
             $("#result").html(html);
           },
           error: function(request, status, error) {
             alert('내 식물 닉네임 목록을 가져오는 도중 오류가 발생했습니다.');
             console.log("code: " + request.status)
             console.log("message: " + request.responseText)
             console.log("error: " + error);
           }
         });

        } else if (useYn == "chat") {
             html = "";
             $("#result").html(html);
             selectedPlants = [];
             selectedPlantsNick = [];
             $("#selectedMyplantNick").html(html);
        }
    });
          // postMyplant() 함수를 전역 함수로 정의
          window.postMyplant = function(myplantId, myplantNick) {
            console.log("postMyplant called with plantId:", myplantId);
            if (!selectedPlants.includes(myplantId)) {
              selectedPlants.push(myplantId);
              selectedPlantsNick.push(myplantNick);
            }
            console.log(selectedPlants);
           let selectedPlantsInput = document.getElementById("selectedPlantsInput");
             if (selectedPlantsInput) {
               selectedPlantsInput.value = selectedPlants.join(",");
             }
              console.log("selectedPlantsInput.value = " + selectedPlantsInput.value);

            $("#selectedMyplantNick").show();
            let nick = "";
            for(let i=0; i < selectedPlantsNick.length; i++) {
                 nick += selectedPlantsNick[i] + " "
            }
            $("#selectedMyplantNick").html(nick);
          };
        });
</script>
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 200px; flex-shrink: 0;">
    <div class="container">
        <p class="m-0 small">© Plantery 2023</p>
    </div>
</footer>
</body>
</html>