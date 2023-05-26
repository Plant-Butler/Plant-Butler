        // 체크박스 전체선택, 전체해제
        $(document).ready(function() {
			$("#checkAll1").click(function() {
				if($("#checkAll1").is(":checked")) $("input[name=post]").prop("checked", true);
				else $("input[name=post]").prop("checked", false);
			});

			$("#checkAll2").click(function() {
				if($("#checkAll2").is(":checked")) $("input[name=comment]").prop("checked", true);
                else $("input[name=comment]").prop("checked", false);
			});

			$("input[name=post]").click(function() {
				let total = $("input[name=post]").length;
				let checked = $("input[name=post]:checked").length;

				if(total != checked) $("#checkAll1").prop("checked", false);
				else $("#checkAll1").prop("checked", true);
			});

			$("input[name=comment]").click(function() {
				let total = $("input[name=comment]").length;
				let checked = $("input[name=comment]:checked").length;

				if(total != checked) $("#checkAll2").prop("checked", false);
				else $("#checkAll2").prop("checked", true);
			});
		});

	    // 게시물, 댓글 삭제
        function deleteSeveral(num) {
            let confirm_val = confirm('삭제하시겠습니까?');

            if(confirm_val) {
                let data = {};
                let idxList = "";

                if(num === 0) {
                    $( "input[name='post']:checked" ).each (function (){
                         idxList = idxList + $(this).val() + "," ;
                         data.num = 0;
                    });
                } else {
                    $( "input[name='comment']:checked" ).each (function (){
                         idxList = idxList + $(this).val() + "," ;
                         data.num = 1
                    });
                }
                idxList = idxList.substring(0, idxList.lastIndexOf(","));

                if(idxList === ''){
                  alert("선택해주세요.");
                  event.preventDefault();
                  return false;
                }
                data.idxList = idxList;

                var csrfHeader = $("meta[name='_csrf_header']").attr("content");
                var csrfToken = $("meta[name='_csrf']").attr("content");

                $.ajaxSetup({
                  beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                  }
                })

                $.ajax({
                    url:  "/mypage/community",
                    type: "DELETE",
                    data: data,
                    success: function(response) {
                        if(response) {
                            alert('삭제되었습니다.');
                        } else {
                            alert('삭제에 실패하였습니다.');
                        }
                        location.reload();
                    },
                    error: function(request, status, error) {
                        alert('오류가 발생했습니다.');
                        console.log("code: " + request.status)
                        console.log("message: " + request.responseText)
                        console.log("error: " + error);
                    }
                });
            }
        }