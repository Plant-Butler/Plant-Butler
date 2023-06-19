<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>식물병 진단</title>
    <%@ include file="../main/header.jsp" %>
    <script type="text/javascript">
        function showUploadInstructions(show) {
          var uploadInstructions = document.getElementById('uploadInstructions');
          if (show) {
            uploadInstructions.style.display = 'block';
          } else {
            uploadInstructions.style.display = 'none';
          }
        }
        function showUploadInstructions2(show) {
          var uploadInstructions = document.getElementById('uploadInstructions2');
          if (show) {
            uploadInstructions.style.display = 'block';
          } else {
            uploadInstructions.style.display = 'none';
          }
        }
        function showLoadingMessage() {
            var loadingOverlay = document.getElementById('loadingOverlay');
            loadingOverlay.classList.add('visible');
        }
        function showLoadingMessage2() {
            var loadingOverlay = document.getElementById('loadingOverlay2');
            loadingOverlay.classList.add('visible');
        }
        const previewImage = () => {
            let file = document.querySelector("#fileInput");
            let picture = document.querySelector(".picture");
            let message = document.querySelector(".message");
            let btnUpload = document.querySelector(".btnUpload");
            picture.src = window.URL.createObjectURL(file.files[0]);

            let regex = new RegExp("[^.]+$");
            fileExtension = file.value.match(regex);
            if (fileExtension == "jpeg" || fileExtension == "jpg" || fileExtension == "png") {
                btnUpload.style.display = "block";
                message.innerHTML = "질병 진단";
            } else {
                picture.src = "/images/error.png";
                btnUpload.style.display = "none";
                message.innerHTML = "<b>" + fileExtension + "</b> 파일은 적용 불가합니다.<br/>.jpg나 .png파일만 가능합니다.";

                let btnRetry = document.createElement("button");
                btnRetry.classList.add("btnRetry");
                btnRetry.innerHTML = "다시 시도하기";
                btnRetry.addEventListener("click", () => {
                    window.location.href = "/diagnosis";
                });
                document.querySelector(".uploadsection1").appendChild(btnRetry);
            }

                picture.addEventListener("mouseenter", () => {
                    showUploadInstructions(true);
                });

                picture.addEventListener("mouseleave", () => {
                    showUploadInstructions(false);
                });
        };


        const previewImagep = () => {
                let file = document.querySelector("#fileInput2");
                let picture = document.querySelector(".picture2");
                let message = document.querySelector(".message");
                let btnUpload = document.querySelector(".btnUpload2");
                picture.src = window.URL.createObjectURL(file.files[0]);

                let regex = new RegExp("[^.]+$");
                fileExtension = file.value.match(regex);
                if (fileExtension == "jpeg" || fileExtension == "jpg" || fileExtension == "png") {
                    btnUpload.style.display = "block";
                    message.innerHTML = "해충 진단";
                } else {
                    picture.src = "/images/error.png";
                    btnUpload.style.display = "none";
                    message.innerHTML = "<b>" + fileExtension + "</b> 파일은 적용 불가합니다.<br/>.jpg나 .png파일만 가능합니다.";

                    let btnRetry = document.createElement("button");
                    btnRetry.classList.add("btnRetry");
                    btnRetry.innerHTML = "다시 시도하기";
                    btnRetry.addEventListener("click", () => {
                        window.location.href = "/diagnosis";
                    });
                    document.querySelector(".uploadsection2").appendChild(btnRetry);
                }
            };
    </script>

</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<style type="text/css">
    @font-face {
        font-family: 'KimjungchulGothic-Bold';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/KimjungchulGothic-Bold.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }
    .uploadbody {
        justify-content: center;
        align-items: center;
        min-height: 50vh;
        width: 100%;

    }
    .diagnosis-container{
        display: flex;
    }

    .uploadsection1 {
        margin: 0 auto;
        width: 700px;
        border: 3px solid #88a8a0;
        padding: 40px;
        border-radius: 10px;
        background-color: #fcfcfc;
        box-sizing: border-box;
        text-align: center;
        margin-top: 110px;
    }

    .uploadsection2 {
        margin: 0 auto;
        width: 700px;
        border: 3px solid #88a8a0;
        padding: 40px;
        border-radius: 10px;
        background-color: #fcfcfc;
        box-sizing: border-box;
        text-align: center;
        margin-top: 110px;
    }
    .left-column {
      flex: 1;
      margin-right: -100px;
    }

    .right-column {
      flex: 1;
      margin-left: -100px;
    }

    .message1 {
        font-size: 3em;
        color: #000000;
        text-align: center;
        margin-top: 250px;
        margin-left: 70px;
        font-family: 'KimjungchulGothic-Bold';
    }
    .message2 {
        font-size: 3em;
        color: #000000;
        text-align: center;
        margin-top: 250px;
        margin-right: 70px;
        font-family: 'KimjungchulGothic-Bold';
    }
    .picture {
        display: block;
        width: 300px;
        height: 275px;
        margin: 0 auto;
        margin-bottom: 12px;
        border-radius: 12px;
    }
    .picture2{
        display: block;
        width: 300px;
        height: 275px;
        margin: 0 auto;
        margin-bottom: 12px;
        border-radius: 12px;
    }
    .btnUpload {
        margin: 0 auto;
        background-color: #198754;
        font-size: 20px;
        color: #fcfcfc;
        width: 220px;
        height: 40px;
        border: none;
        border-radius: 10px;
        font-family: 'KimjungchulGothic-Bold';
    }
    .btnUpload2 {
        margin: 0 auto;
        background-color: #198754;
        font-size: 20px;
        color: #fcfcfc;
        width: 220px;
        height: 40px;
        border: none;
        border-radius: 10px;
        font-family: 'KimjungchulGothic-Bold';
    }
    .image-container {
        position: relative;
        width: 300px;
        height: 300px;
        margin: 0 auto;
        border-radius: 8px;
        overflow: hidden;
    }

    .image-container img {
        width: 90%;
        height: 90%;
        object-fit: cover;
    }

    .loading-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(255, 255, 255, 0.7);
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: opacity 0.3s ease-in-out;
    }

    .loading-overlay.visible {
        opacity: 1;
    }

    .loading-message {
        font-size: 24px;
        font-family: Arial, sans-serif;
        margin-bottom: 40px;
        margin-left: 20px;
    }
     .backbutton {
        background-color: #45a049;
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 3px 2px;
        cursor: pointer;
        border-radius: 10px;
        transition: background-color 0.3s;
         font-family: 'KimjungchulGothic-Bold';
    }

    .backbutton:hover {
        background-color: #45a049;
    }
    .back{
        display: flex;
        margin-left: 750px;
    }
    .upload-instructions {
      display: none;
      text-align: center;
      font-size: 14px;
      margin-top: 10px;
        font-family: 'KimjungchulGothic-Bold';
    }

</style>

<body class="uploadbody">
<div class="diagnosis-container">
        <div class="left-column">
            <h2 class="message1">질병 진단</h2>
            <section class="uploadsection1">
            <br>
            <form action="/diagnosis/result" method="post" enctype="multipart/form-data">
             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <label for="fileInput">
                <div class="image-container" onmouseenter="showUploadInstructions(true)" onmouseleave="showUploadInstructions(false)">
                <div class="image-container">
                    <img src="/images/leafcover.png" alt="Image" class="picture">
                    <div class="upload-instructions" id="uploadInstructions">이미지를 클릭해 파일을 업로드하세요</div>
                    <div id="loadingOverlay" class="loading-overlay">
                        <div class="loading-message">
                            Loading...
                        </div>
                    </div>
                </div>
                </div>
                </label>
                <br>
                <input type="file" id="fileInput" name="image" onchange="previewImage();" style="display: none;">
                <br>
                <br>
                <button onclick="showLoadingMessage()" class="btnUpload">진단하기</button>
            </form>
            </section>
        </div>

        <div class="right-column">
        <h2 class="message2">해충 진단</h2>
            <section class="uploadsection2">
            <br>
            <form action="/diagnosis/pest/result" method="post" enctype="multipart/form-data">
             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <label for="fileInput2">
                <div class="image-container" onmouseenter="showUploadInstructions2(true)" onmouseleave="showUploadInstructions2(false)">
                <div class="image-container">
                    <img src="/images/bug3.png" alt="Image" class="picture2">
                    <div class="upload-instructions" id="uploadInstructions2">이미지를 클릭해 파일을 업로드하세요</div>
                    <div id="loadingOverlay2" class="loading-overlay">
                        <div class="loading-message">
                            Loading...
                        </div>
                    </div>
                </div>
                </div>
                </label>
                <br>
                <input type="file" id="fileInput2" name="image2" onchange="previewImagep();" style="display: none;">
                <br>
                <br>
                <button onclick="showLoadingMessage2()" class="btnUpload2">진단하기</button>
                    <div id="loadingMessage" class="loading-message" style="display: none;">
                        Loading...
                    </div>
            </form>
            </section>
        <br>
        <div class="back">
            <button type="button" class="backbutton" onclick="window.location.href='/myplants'">이전 화면</button>
        </div>
        <br>
        <br>
        <br>
        <br>
      </div>
    </div>
    <footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px; flex-shrink: 0;">
        <div class="container">
            <p class="m-0 small">Copyright &copy; Plantery 2023</p>
        </div>
    </footer>
</body>
</html>
