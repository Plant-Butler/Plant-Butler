<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test2</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		    $('#submit').click(function(){
		    	let title = $('#title').val();
		        let content = $('#content').val();
		        let writer = $('#writer').val();
		        let json = {'title':title, 'content':content, 'writer':writer};
		        $.ajax({
		            type:'POST',
		            url:'/test',
		            contentType: 'application/json',
		            data: JSON.stringify(json),
		            success:function(data){
		                alert('Data inserted successfully.');
		            },
		            error:function(){
		                alert('Error occurred while inserting data.');
		            }
		        });
		    });
		});
	</script>
</head>
<body>
        <h2>게시판 등록</h2>
            <table>
                <tr>
                    <td>제목</td>
                    <td><input type="text" id="title" name="title"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea id="content" name="content"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td><input type="text" id="writer" name="writer"></td>
                </tr>
            </table>
            <input type="submit" id="submit" value="저장">
        

</body>
</html>