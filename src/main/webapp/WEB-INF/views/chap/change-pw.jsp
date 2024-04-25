<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="/assets/css/change-password.css">
    <script type="text/javascript" src="/assets/js/pwsearch.js" defer></script>
    <%@include file="../include/static-head.jsp"%>
</head>

<body>

    <%@include file="../include/header.jsp"%>


    <form action="/members/changePassword" name="signup" id="signUpForm" method="post" enctype="multipart/form-data">
        <div class="pwFind container">
            <div class="newPwInput">
                <p class="font"><strong>새로운 비밀번호를 입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
                <input type="password" placeholder="영문, 숫자, 특수문자를 포함한 8자 이상의 비밀번호를 입력해주세요" id="newPw" name="password" required="required"
                    aria-required="true">
                <span id="pwChk"></span>
            </div>
            <div class="newPwChkInput">
                <p class="font"><strong>입력한 비밀번호를 재확인해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
                <input type="password" placeholder="입력하신 비밀번호와 동일하게 입력해주세요" id="newPwChk"
                    required="required" aria-required="true">
                <span id="pwChk2"></span>
                <input type="text" name="email" value="${login.email}" hidden>
            </div>
        </div>

        <button type="button" id="pwChange">비밀번호 변경</button>

    </form>

    <%@include file="../include/footer.jsp"%>


    <script>
        const checkResultList = [false, false];

        const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~@#$!%*?&])[a-zA-Z\d~@#$!%*?&]{8,}$/;

        const $pwInput = document.getElementById('newPw');
        $pwInput.addEventListener('keyup', () => {
            const pwValue = $pwInput.value.trim();
            if (pwValue === '') {
                $pwInput.style.borderColor = 'red';
                document.getElementById('pwChk').innerHTML = '<b style="color: red;">비밀번호는 필수값입니다</b>';
                checkResultList[0] = false;
                return;
            } else if (!passwordPattern.test(pwValue)) {
                $pwInput.style.borderColor = 'red';
                document.getElementById('pwChk').innerHTML = '<b style="color: red;">특수문자 포함 8자 이상 입력해주세요</b>';
                checkResultList[0] = false;
                return;
            } else {
                $pwInput.style.borderColor = 'black';
                document.getElementById('pwChk').innerHTML = '<b style="color: skyblue;">[사용가능한 비밀번호입니다]</b>';
                checkResultList[0] = true;
            }
        });

        const $newPwChkInput = document.getElementById('newPwChk');
        $newPwChkInput.addEventListener('keyup', () => {
            const reChkPwVal = $newPwChkInput.value.trim();
            const pwValue = $pwInput.value.trim();
            if (reChkPwVal === '') {
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">비밀번호 확인은 필수입력입니다.</b>';
                checkResultList[1] = false;
                return;
            } else if (reChkPwVal !== pwValue) {
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">비밀번호와 일치하지 않습니다.</b>';
                checkResultList[1] = false;
                return;
            } else {
                $newPwChkInput.style.borderColor = 'black';
                document.getElementById('pwChk2').innerHTML = '<b style="color: skyblue;">[비밀번호와 일치합니다.]</b>';
                checkResultList[1] = true;
            }
        });


     document.getElementById('pwChange').onclick = e => {
       if (checkResultList.includes(false)) {
         alert('입력란을 다시 확인해주세요');
       } else {
         const form = document.getElementById('signUpForm');
         form.submit(); // HTML 폼 제출
         alert('비밀번호 변경이 완료되었습니다.');
       }
     }
    </script>



</body>

</html>