
function IdCheck() {
      window.open("./idCheckForm", "idWin", "width=400, height=350");
   }
   function NickCheck() {
      window.open("./nickCheckForm", "nickWin", "width=400, height=350");
   }

   function NickUpdate() {
      window.open("/nickCheckForm", "nickWin", "width=400, height=350");
   }


        function checkerPwd() {
            var pw1 = document.joinform.password.value;
            var pw2 = document.joinform.checkPwd.value;
            document.getElementById('checkerPwd').style.fontSize = "medium";

            if ((pw1 != pw2) || (pw1 == "") || (pw2 == "")) {
                document.getElementById('checkerPwd').style.color = "red";
                document.getElementById('checkerPwd').innerHTML = "동일한 암호를 입력하세요.";
            } else {
                document.getElementById('checkerPwd').style.color = "white";
                document.getElementById('checkerPwd').innerHTML = "암호가 확인 되었습니다.";
            }
        }

        function pwdCheck() {
          var password = document.getElementById("password").value;
          var pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/; // 정규 표현식 패턴 설정
          var isValidPassword = pattern.test(password); // 패턴에 맞는지 확인하여 true 또는 false로 반환

          var passwordMessage = document.getElementById("password-message"); // 안내 메시지를 출력할 영역
          passwordMessage.style.fontSize = "medium";

          if (!isValidPassword) {
            passwordMessage.innerHTML = "영문 대/소문자, 숫자, 특수문자를 모두 포함<br>8자 이상이어야 합니다";
            passwordMessage.style.color = "red";
          } else {
            passwordMessage.innerHTML = "비밀번호가 유효합니다.";
            passwordMessage.style.color = "white";
          }

          // 비밀번호 유효성 체크 결과를 반환

          return isValidPassword;
        }


        function finalCheck(event) {
          var id = document.joinform.userId.value;
          var pw1 = document.joinform.password.value;
          var nickname = document.joinform.nickname.value;
          var pw2 = document.joinform.checkPwd.value;
          var email = document.joinform.email.value;
          var cookie = document.joinform.cookie.checked;
          var tokenCheckbox = document.joinform.tokenCheckbox.checked;
          var email_regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          var pwd_regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
          // pwdCheck() 함수 호출하여 비밀번호 유효성 체크 결과 받아옴
          var isValidPassword = pwdCheck();
            if ((id != null) && (pw1 == pw2) && (pw1 != "") && (pw2 != "") && (email_regex.test(email)) &&(pwd_regex.test(pw1)) && cookie && tokenCheckbox) {
                alert('가입 완료! 로그인해주세요');
            } else {
                alert("조건이 맞지 않습니다. 다시 시도해주세요.");
                    event.preventDefault();
                    return false;
             }
        }


        function updateMypage(userId) {
                let nickname = $("#nickname").val();
                let email = $("#email").val();
                let password = $('#password').val();
                let checkPwd = $('#checkPwd').val();

                var csrfHeader = $("meta[name='_csrf_header']").attr("content");
                var csrfToken = $("meta[name='_csrf']").attr("content");

                var email_regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                var pwd_regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

                if((password === "") || (password !== checkPwd) || (nickname === "") || (email === "") || (!email_regex.test(email)) || (!pwd_regex.test(password))) {
                    alert("조건이 맞지 않습니다. 다시 시도해주세요.");
                    event.preventDefault();
                    return false;
                }

                $.ajaxSetup({
                  beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                  }
                });

                $.ajax({
                    url: '/mypage/' + userId,
                    type: 'PUT',
                    data: {
                        nickname: nickname,
                        password: password,
                        email: email
                    },
                    success: function(response) {
                        alert('수정되었습니다');
                        location.reload();
                    },
                    error: function(request, status, error) {
                        alert('오류가 발생하였습니다.');
                        console.log("code: " + request.status)
                        console.log("message: " + request.responseText)
                        console.log("error: " + error);
                    }

                });
            }
