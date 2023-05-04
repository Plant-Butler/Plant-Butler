<%@page import="com.plant.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../main/header.jsp" %> --%>
<%@ page import="utils.DateUtils" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Write Item</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	  window.selectedPlants = [];

	  // postMyplant() 함수를 전역 함수로 정의
	  window.postMyplant = function(plant) {
	    console.log("postMyplant called with plantId:", plant);
	    selectedPlants.push(plant);
	    console.log(selectedPlants);
	    document.getElementById("selectedPlantsInput").value = selectedPlants.join(",");
	  };

	  $("input[type='radio']").change(function(e){
	    var useYn = $(this).val();
	    var userId = "<%= ((UserVo)session.getAttribute("user")).getUserId() %>";
	    if (useYn == "boast") {
	      $.ajax({
	        url: "/community/plantall",
	        type: "GET",
	        dataType: "json",
	        data: { userId : userId, selectedPlants: selectedPlants },
	        success: function(data) {
	          $("#result").show();
	          var html = "<ul>";
	          for (var i = 0; i < data.length; i++) {
	            html += "<li>" + data[i].myplantNick + "</li>";
	            html += '<button type="button" onclick="postMyplant(' + data[i].myplantId + ')">선택</button>';
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
	    }
	  });
	});

</script>

</head>
<body>
<div class="about-section">
<h1>New Post</h1>
</div>
<br>
<%
    UserVo userVo = (UserVo) session.getAttribute("user");
    String userId = "";
    String userNickname = "";
    if (userVo != null) {
        userNickname = userVo.getNickname();
        userId = userVo.getUserId();
    }
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String formattedNow = now.format(formatter);


%>


	<form action="./form" method="post" enctype="multipart/form-data" >
	<div class = "form_table">
		 <div>
		 <br>
                <h4 class = "title">작성자</h4>
                <input  class="upload_writer" type="text" name="userId" id = "userId"  value=<%=userId %> readonly = "readonly">
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
</form>
</body>
</html>