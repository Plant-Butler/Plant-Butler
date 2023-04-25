<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test2</title>

</head>
<body>
        <h2>게시판 등록</h2>
        <form method="post" action="/test">
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
        </form>

</body>
</html>