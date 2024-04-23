<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <title>Today's weather, oh-nal</title>
    <%@include file="../include/static-head.jsp"%>
    <link rel="stylesheet" href="/assets/css/sign-in.css">
    <script type="text/javascript" src="/assets/js/sign-in.js" defer></script>

</head>

<body>
    <%@include file="../include/header.jsp"%>
    <div class="snowflakes" aria-hidden="true"> 
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
    </div>






    <div class="container">
        <h2 class="logintextlogin">로그인</h2>
        <form action="/members/sign-in" name="sign-in" method="post" id="signInForm">
            <div class="input-group">
                <input type="text" placeholder="이메일을 입력하세요" name="email" id="signInId" required="required"
                    aria-required="true">
            </div>
            <div class="input-group">
                <input type="password" placeholder="비밀번호를 입력하세요" id="signInPw" name="password" required="required"
                    aria-required="true">
            </div>

            <tr>
                <td class="autologinbox">
                    <span>
                        <i class="fas fa-sign-in-alt"></i>
                        자동 로그인
                        <input type="checkbox" id="auto-login" name="autoLogin">
                    </span>
                </td>
            </tr>


            <input type="submit" value="로그인">
        </form>
        <a href="/members/sign-up" class="signup-btn">회원가입</a>




        <div class="forgot-link">
            <a href="/sign-in/pwsearch">| 비밀번호 찾기 |</a>
        </div>


            <a href="/kakao/login" class="kakaologinlogo"><img class="kakaologo" src="/assets/img/kakaologo.png" alt="카카오톡로그인로고"></a>
            <a href="/naver/login" class="naverlogobackground"><img id="naverlogo" src="/assets/img/naverlogo.png" alt="네이버로그인로고"></a>
            <a href="/google/login" class="googlelogobackground"><img id="googlelogo" src="/assets/img/googlelogo.png" alt="Google 로그인 로고"></a>

    </div>
    <%@include file="../include/footer.jsp"%>

    <script>
        const serverResult = '${result}';
        console.log(serverResult);

        if (serverResult === 'NO_EMAIL') {
            alert('회원가입부터 하고 오세요~~');
        } else if (serverResult === 'NO_PW') {
            alert('비밀번호가 틀렸어요~');
        }
    </script>
</body>

</html>