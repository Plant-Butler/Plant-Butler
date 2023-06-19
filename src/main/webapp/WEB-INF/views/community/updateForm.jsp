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
        .max-small {
            width: auto; height: auto;
            max-width: 100px;
            max-height: 100px;
        }

          h1 {
               text-align: center;
         }
         .form_table {
           text-align: center;
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
<div class="about-section">
<h1>Update Post</h1>
</div>
<br>

    <form id="myForm" onsubmit="submitForm(event)" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class = "form_table">
		 <div>
		 <br>
                <h4 class = "title">작성자</h4>
             <input class="upload_writer" type="text" name="userId" id="userId" value="${userId}" readonly>
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
                <c:if test="${not empty post.postImage}">
                    <td>
                        <c:forEach var="image" items="${imageUrls}">
                            <p><img class="max-small" src="${image}"></p>
                            <br>
                        </c:forEach>
                    </td>
                </c:if>
                </p>
                <input class="upload_img" type="file" name="postMultiImage" id="postMultiImage" multiple>
            </div>
            <br>
        <div>
            <c:if test="${not empty post.postFile}">
                <h4 class = "title">첨부파일</h4>
                <a class = "title">기존 : ${post.postFile}</a>
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