    // 댓글 수정창 열기
    function updateBox(commentContent, commentId, postId) {
          let span = document.getElementById("commentContent_" + commentId);

          let input = document.createElement("input");
          input.type = "text";
          input.name = "updatedComment";
          input.id = "inputComment";
          input.value = commentContent;

          //let updatedComment = input.value;
          let button = document.createElement("button");
          button.type = "button";
          button.onclick = function() {
            updateComment(input.value, commentId, postId);
          };
          button.innerHTML = "수정완료";

          span.innerHTML = "";
          span.appendChild(input);
          span.appendChild(button);
    }

    // 댓글 수정
    function updateComment(updatedComment, commentId, postId) {
        $.ajax({
            url: "/community/comment/" + commentId,
            type: "PUT",
            data: {
                commentContent : updatedComment,
                commentId : commentId
            },
            success: function(response) {
                window.location.href = "/community/" + postId;
            },
            error: function(request, status, error) {
                alert('댓글을 수정할 수 없습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }


    // 게시물 & 댓글 삭제
    function del(commentId, postId, num) {
        let url = "";
        let data = {};
        if(num == 0) {
            url = "/community/" + postId;
            data.postId = postId;
        } else {
            url =  "/community/comment/" + commentId;
            data.commentId = commentId;
        }

        $.ajax({
            url: url,
            type: "DELETE",
            data: data,
            success: function(response) {
                alert('삭제되었습니다.');
                if(num == 0) {
                    window.location.assign("/community");
                } else {
                    window.location.assign("./" + postId);
                }
            },
            error: function(request, status, error) {
                alert('삭제할 수 없습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

    // 게시물 & 댓글 신고
    function declare(commentId, postId, num) {
        let url = "";
        let data = {};
        if(num == 0) {
            url = "/community/" + postId;
            data.postId = postId;
        } else {
            url =  "/community/comment/" + commentId;
            data.commentId = commentId;
        }

        $.ajax({
            url:  url,
            type: "PATCH",
            data: data,
            success: function(response) {
                alert('신고되었습니다.');
                window.location.href = "/community/" + postId;
            },
            error: function(request, status, error) {
                alert('신고 중 오류가 발생했습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

    // 게시물 좋아요
    function heart(postId, userId) {
        event.preventDefault();
 		let heartBtn = document.getElementById("heartBtn");

 	    $.ajax({
 			type :'POST',
 			url : './' + postId + '/heart',
 			contentType : 'application/json',
 			data : JSON.stringify({
 			    postId : postId,
 			    userId : userId
 			}),
 			success : function(result){
 				if (result === 'add'){
 					heartBtn.innerHTML = '<i class="fa fa-heart" style="color: red;"></i>';
                    window.location.href = "/community/" + postId;
 				} else {
                    heartBtn.innerHTML = '<i class="fa fa-heart-o" style="color: red;"></i>';
                    window.location.href = "/community/" + postId;
 				}
 			},
 			 error: function(request, status, error) {
                  alert('오류가 발생했습니다.');
                  console.log("code: " + request.status)
                  console.log("message: " + request.responseText)
                  console.log("error: " + error);
             }
 		});
 	};
