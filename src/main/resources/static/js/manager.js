
var csrfHeader = $("meta[name='_csrf_header']").attr("content");
var csrfToken = $("meta[name='_csrf']").attr("content");

   function selectBest(userId, index) {

        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        })

        $.ajax({
            url: "/manager/best-user/" + userId,
            type: "POST",
            data: {
                userId : userId
            },
            success: function(response) {
                console.log(userId);
                alert('추가되었습니다');
                $(".select-best").eq(index).text("우수회원 선택완료");
            },
            error: function(request, status, error) {
                alert('이미 추가된 회원입니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

        // 우수회원 취소
        function deleteBest(userId, index) {

            $.ajaxSetup({
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            })

            $.ajax({
                url: "/manager/best-user/" + userId,
                type: "DELETE",
                data: {
                    userId : userId
                },
                success: function(response) {
                    console.log(userId);
                    alert('취소되었습니다');
                    $(".select-best").eq(index).text("우수회원 선택");
                },
                error: function(request, status, error) {
                    alert('이미 취소된 회원입니다.');
                        console.log("code: " + request.status)
                        console.log("message: " + request.responseText)
                        console.log("error: " + error);
                }
            });
        }

        // 우수회원 초기화
        function deleteAllBest() {

            $.ajaxSetup({
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            })

            $.ajax({
               url: "/manager/best-user/all",
               type: "DELETE",
               success: function(response) {
                   alert('초기화되었습니다');
                   $(".select-best").text("우수회원 선택");
               },
               error: function(request, status, error) {
                   alert('오류가 발생했습니다.');
                   console.log("code: " + request.status)
                   console.log("message: " + request.responseText)
                   console.log("error: " + error);
               }
            });
        }

        // 회원 삭제 확인/취소 창
        function deleteUserCheck(userId, num) {

         let say = '';
         if(num === 0) {
            say = '탈퇴하시겠습니까?';
         } else if (num === 1) {
            say = '강제로 탈퇴처리 하시겠습니까?';
         }

         if (confirm(say) == true){
             deleteUser(userId, num, csrfHeader, csrfToken);
         } else {
             return false;
         }

        }

        // 회원 삭제
        function deleteUser(userId, num, csrfHeader, csrfToken) {
            let url = "";
            if(num == 0) {
                url = "/mypage/" + userId;
            } else {
                url =  "/manager/" + userId;
            }

            $.ajaxSetup({
                headers: {
                    [csrfHeader] : csrfToken
                }
            });

            $.ajax({
               url: url,
               type: "DELETE",
               success: function(response) {
                   alert('탈퇴처리 되었습니다');
                   const url = num === 0 ? "/logout" : "/manager";
                   window.location.href = url;
               },
               error: function(request, status, error) {
                   alert('오류가 발생했습니다.');
                   console.log("code: " + request.status)
                   console.log("message: " + request.responseText)
                   console.log("error: " + error);
               }
            });
        }

    // 게시물 or 댓글 삭제
    function deleteM(commentId, postId, num) {
        let url = "";
        let data = {};
        if(num == 0) {
            url = "/community/" + postId;
            data.postId = postId;
        } else {
            url =  "/community/comment/" + commentId;
            data.commentId = commentId;
        }

        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        })

        $.ajax({
            url:  url,
            type: "DELETE",
            data: data,
            success: function(response) {
                alert('삭제되었습니다.');
                window.location.href = "/manager";
            },
            error: function(request, status, error) {
                alert('삭제 중 오류가 발생했습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }


