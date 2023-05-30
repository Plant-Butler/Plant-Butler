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



<div class="about-section">
<h1>New Post</h1>
</div>
<br>
<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String formattedNow = now.format(formatter);
%>


   <form action="./form" method="post" enctype="multipart/form-data" >
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
   <div class = "form_table">
       <div>
       <br>
                <h4 class = "title">작성자</h4>
                <input  class="upload_writer" type="hidden" name="userId" id = "userId"  value="${userVo.userId}" readonly = "readonly">
                <input  class="upload_writer" type="text" name="nickname" id = "nickname"  value="${userVo.username}" readonly = "readonly">
            </div>
            <br>
         <div>
           <h4 class="title">태그</h4>
           <input type="radio" name="postTag" value="information"  class="ajaxClick" id="information" style="display:inline-block; margin-left: 10px;" required><label for="information">정보 공유</label>
           <input type="radio" name="postTag" value="boast" class="ajaxClick"  id="boast" style="display:inline-block; margin-left: 10px;" required><label for="boast">식물 자랑</label>
           <input type="radio" name="postTag" value="chat"  class="ajaxClick" id="chat" style="display:inline-block; margin-left: 10px;" required><label for="chat">수다</label>
         </div>
         <p id="result" style="display: none;">
         <br>
         </p>
          <input type="hidden" name="selectedPlants" id="selectedPlantsInput" value="">
            <br>[선택된 내 식물]
            <p id="selectedMyplantNick" style="display: none;">
            <div>
                <h4 class = "title">제목</h4>
                <input  class="upload_title" type="text" name="postTitle" id = "postTitle">
            </div>
            <br>
            <div>
                <h4 class = "title">내용</h4>
                <textarea cols="80" rows="5" name="postContent"></textarea>
            </div>
            <br>
             <div>
                <h4 class = "title">작성일자</h4>
                <input class="upload_date" type="text" name="postDate" value="<%=formattedNow%>" readonly = "readonly">
            </div>
            <br>
         <div>
                <h4 class = "title">이미지첨부</h4>
                <input class="upload_img" type="file" name="postMultiImage" multiple>
            </div>
            <br>
         <div>
                <h4 class = "title">데이터첨부</h4>
                <input class="upload_data" type="file" name="postMultiFile">
            </div>
   <br>
   <div class="submit">
       <input type="submit" value="작성">
   </div>
   <br>
   <br>
   </div>
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
                html += "<li>" + data[i].myplantNick;
                html += ' <button type="button" onclick="postMyplant(' + data[i].myplantId + ', ' + "'" + data[i].myplantNick + "'" + ')">선택</button></li>';
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
</body>
</html>