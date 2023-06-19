<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../main/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        @font-face {
            font-family: 'KimjungchulGothic-Bold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/KimjungchulGothic-Bold.woff2') format('woff2');
            font-weight: 400;
            font-style: normal;
        }
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
        font-family: 'KimjungchulGothic-Bold';
        font-size: 3em;
        color: #000000;
        text-align: center;
        font-style: normal;
        font-weight: 700;
    }

    .custom-textarea {
      width: 60%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 4px;
      resize: vertical;
    }
    .updateform {
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
    .update_img{
    width: 80%;
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
    /* Hide the default radio button */
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
    .existedfile{
      color: #e5a756;
      font-size: 18px;
      text-decoration: none;
    }
    </style>
    <meta charset="UTF-8">
    <title>Write Item</title>
    <script>
        function submitForm(event) {
            event.preventDefault();

            const form = document.getElementById("myForm");
            const formData = new FormData(form); // 폼 데이터 가져오기
            const postId = ${postId};

            fetch(`../${postId}`, {
                method: "PUT",
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        window.location.href = "/community"; // 수정 완료 후 목록 페이지로 이동.
                    } else {
                        alert("게시글 수정에 실패했습니다.");
                    }
                })
                .catch(error => {
                    alert("네트워크 에러가 발생했습니다.");
                });
        }
    </script>
</head>
<body>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<div class="about-section" style="margin-top: 300px">
    <h1 class = "newh1">게시물 수정</h1>
</div>
<br>

    <form id="myForm" onsubmit="submitForm(event)" enctype="multipart/form-data" class = "updateform">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="userId" id="userId" value="${userVo.userId}">
        <br>
        <div class="form_wrapper">
	<div class = "form_table" style="margin-top: 10px margin-bottom: 10px">
            <div class="col-25">
                <label class= "newpostlayer" for="fname">제목</label>
            </div>
            <div>
               <input class="custom-input" type="text" name="postTitle" id = "postTitle" value="${post.postTitle}">
            </div>
            <br><br>

            <div class="col-25">
                <label class= "newpostlayer" for="fname">내용</label>
            </div>
            <div>
              <textarea class="custom-input" cols="80" rows="10" name="postContent">${post.postContent}</textarea>
            </div>
            <br><br>

            <div>
            <c:if test="${not empty post.postImage}">
               <h4 class = "newpostlayer">기존 이미지</h4>
                    <c:forEach var="image" items="${imageUrls}">
                        <p><img class="max-small" src="${image}"></p>
                    </c:forEach>
            </c:if><br>

                <br><br>
                <h4 class = "newpostlayer">이미지첨부</h4>
                </p>
                <input class="upload_img" type="file" name="postMultiImage" id="postMultiImage" multiple>
            </div>
            <br><br>
            <c:if test="${not empty post.postImage}">
               <h4 class = "newpostlayer">기존 첨부파일</h4>
              <c:if test="${not empty post.postFile}">
                   <a class = "existedfile">${post.postFile}</a>
               </c:if><br>
            </c:if><br>
            <div>
                <h4 class = "newpostlayer">첨부파일</h4>
                <input class="upload_data" type="file" name="postMultiFile">
            </div>
	        <br><br>

    </div>
    </div>
    <br><br>
    	<div class="submit">
            <input type="submit" value="수정">
        </div>
    </form>
    <br>
    <br>
<br>
<br>

<br>
<br>
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px; flex-shrink: 0;">
    <div class="container">
        <p class="m-0 small">© Plantery 2023</p>
    </div>
</footer>
</body>
</html>