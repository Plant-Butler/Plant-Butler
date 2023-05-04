<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.plant.vo.UserVo"%>
<%@ page import="com.plant.vo.PostVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../main/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
    <style>
        .max-small {
            width: auto; height: auto;
            max-width: 100px;
            max-height: 100px;
        }
    </style>
    <meta charset="UTF-8">
    <title>Write Item</title>
    <script>
        function submitForm(event) {
            event.preventDefault(); // 기본 폼 제출 동작을 방지

            const form = document.getElementById("myForm");
            const formData = new FormData(form); // 폼 데이터 가져오기
            const postId = ${postId}/* postId 값을 가져옵니다. */;

            fetch(`../${postId}`, {
                method: "PUT",
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        // 요청이 성공적으로 처리되면 여기에 로직을 추가합니다.
                        window.location.href = "/community"; // 수정 완료 후 목록 페이지로 이동합니다.
                    } else {
                        // 에러 처리를 수행합니다.
                        alert("게시글 수정에 실패했습니다.");
                    }
                })
                .catch(error => {
                    // 네트워크 에러 처리를 수행합니다.
                    alert("네트워크 에러가 발생했습니다.");
                });
        }
    </script>
</head>
<body>
<div class="about-section">
<h1>New Post</h1>
</div>
<br>
<%
    UserVo userVo = (UserVo) session.getAttribute("user");
    String userId = userVo.getUserId();

%>


    <form id="myForm" onsubmit="submitForm(event)" enctype="multipart/form-data">
	<div class = "form_table">
		 <div>
		 <br>
                <h4 class = "title">작성자</h4>
             <input class="upload_writer" type="text" name="userId" id="userId" value="<%=userId %>" readonly>
            </div>
            <br>
            <div>
                <h4 class = "title">제목</h4>
                <input class="upload_title" type="text" name="postTitle" id = "postTitle" value="${post.postTitle}">
            </div>
            <br>
            <div>
                <h4 class = "title">내용</h4>
                <textarea cols="80" rows="5" name="postContent">${post.postContent}</textarea>
            </div>
            <br>
            <br>
			<div>
                <h4 class = "title">이미지첨부</h4>
                <p >
                <c:forEach var="image" items="${fn:split(post.postImage, ',')}">
                    <!-- 여기에서 image 변수를 사용하여 각 이미지를 처리합니다. -->
                    <img class="max-small" src="/uploads/${image}">
                </c:forEach>
                </p>
                <input class="upload_img" type="file" name="postMultiImage" id="postMultiImage" multiple>
            </div>
            <br>
        <div>
            <c:if test="${not empty post.postFile}">
                [첨부파일]
                <a>${post.postFile}</a>
            </c:if><br><br>
            <input class="upload_data" type="file" name="postMultiFile">
        </div>
	<br>
	<div class="submit">
        <input type="submit" value="수정">
    </div>
    </div>
    </form>
<br>
<br>
</body>
</html>