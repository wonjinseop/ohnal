<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Today's weather, oh-nal</title>
    <%@include file="../include/static-head.jsp"%>
    <link rel="stylesheet" href="/assets/css/sign-in.css">
</head>
<body>
    <%@include file="../include/header.jsp"%>

    <div class="container">
            <h2 class="logintextlogin">로그인</h2>
            <form action="/sign-in" name="sign-in" method ="post" id="signInForm">
                <div class="input-group">
                    <input type="text" placeholder="이메일을 입력하세요">
                </div>
                <div class="input-group">
                    <input type="password" placeholder="비밀번호를 하세요">
                </div>
                <input type="submit" value="로그인">
            </form>
            <a href="/sign-up" class="signup-btn">회원가입</a>
            <a href="#" class="kakaologinlogo"><img src="./assets/img/kakaologo.png" alt="카카오톡로그인로고"></a>
            <div class="forgot-link">
                <a href="#">이메일찾기</a> | <a href="#">비밀번호찾기</a>
            </div>
    </div>

    <%@include file="../include/footer.jsp"%>
</body>
</html>