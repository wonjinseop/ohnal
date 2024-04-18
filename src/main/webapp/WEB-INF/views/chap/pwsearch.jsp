<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Insert Your Title</title>
    <link rel="stylesheet" href="/assets/css/pwsearch.css">
        <script type="text/javascript" src="/assets/js/pwsearch.js" defer></script>
</head>
<body>

<div></div>
<div class="ohnallogo">
<a href="/board/list"><img class="ohnalimg" src="/assets/img/navbar-logo.svg" alt="오날로고"></a>
 </div>
 <div class="container">
        <h1>비밀번호 찾기</h1>
        <form id="resetForm">
            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" placeholder="이메일을 입력해주세요" required>
            </div>
            <div class="form-group">
                <button type="submit">비밀번호 찾기</button>
            </div>
            <div id="message"></div>
        </form>
    </div>
    <script src="script.js"></script>

</body>
</html>