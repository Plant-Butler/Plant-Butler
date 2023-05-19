<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
    <script type="module" src="../mainscript.js"></script>
    <script type="module">
        import { getMessaging, onMessage } from 'https://www.gstatic.com/firebasejs/9.22.0/firebase-messaging.js';
        try {
            Notification.requestPermission().then((permission) => {
                if (permission === "granted") {
                    const messaging = getMessaging();

                    onMessage(messaging, (payload) => {
                        console.log("Message received. ", payload);
                        const notificationTitle = payload.data.score;
                        const notificationOptions = {
                            body: payload.data.time,
                        };
                        new Notification(notificationTitle, notificationOptions);
                    });
                }
            }).catch(error => {
                console.error("An error occurred while requesting permission:", error);
            });
        } catch (error) {
            console.error("An unexpected error occurred:", error);
        }

    </script>
<%@ include file="../main/header.jsp" %>
</head>
<body>
<br>
<button type="button" onclick="location.href='/mypage/${userId}'">내 정보 수정</button>
<br><br>
<button type="button" onclick = "location.href = '/mypage/suggestions/${userId}'">나에게 맞는 식물 결과 </button>
<br><br>
<button type="button" onclick = "location.href = '/myplants'">내 식물 </button>
<br><br>
<button type="button" onclick = "location.href = '/mypage/community/${userId}'">내 게시물 댓글</button>
<br><br>
<button type="button" onclick = "location.href = '/secession'">탈퇴하기 </button>

</body>
</html>