<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="/assets/css/pwsearch.css">
    <script type="text/javascript" src="/assets/js/pwsearch.js" defer></script>
    <%@include file="../include/static-head.jsp"%>
</head>

<body>

    <%@include file="../include/header.jsp"%>


    <form action="/sign-in/pwsearch" name="signup" id="signUpForm" method="post" enctype="multipart/form-data">

        <div class="container">
            <div class="form-group">
                <p class="font"><strong>이메일 인증 후 비밀번호를 변경해 주십시오</strong>&nbsp;&nbsp;&nbsp;</p>
                <input type="email" id="email" name="email" placeholder="ex) on-nal@gmail.com" required="required"
                    aria-required="true" class="input">
            </div>
            <div class="form-group">
                <button type="button" id="button">이메일 인증</button>
                <input type="text" id="emailChkInput" placeholder="인증번호 6자리를 입력하세요" maxlength="6" disabled> <br>
                <span id="mailCheckMsg"></span>
            </div>
            <div id="message"></div>
        </div>
        <div class="pwFind container">
            <div class="newPwInput">
                <p class="font"><strong>새로 설정하실 비밀번호를 입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
                <input type="password" placeholder="영문과 특수문자를 포함한 8자를 입력해주세요" id="newPw" name="password" required="required"
                    aria-required="true" readonly>
                <span id="pwChk"></span>
            </div>
            <div class="newPwChkInput">
                <p class="font"><strong>입력하신 비밀번호를 재확인해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
                <input type="password" placeholder="입력하신 비밀번호와 동일하게 입력해주세요" id="newPwChk"
                    required="required" aria-required="true" readonly>
                <span id="pwChk2"></span>
            </div>
        </div>

        <button type="button" id="pwChange">비밀번호 변경</button>

    </form>

    <%@include file="../include/footer.jsp"%>


    <script>
        const checkResultList = [false, false];


        document.getElementById('button').onclick = e => {
            alert('이메일 확인 후 눌러주세요!');
        }


        const emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
        const $emailInput = document.getElementById('email');


        $emailInput.onkeyup = e => {
            const emailValue = $emailInput.value;
            if (emailValue.trim() === '') {
                $emailInput.style.borderColor = 'red';
                document.getElementById('mailCheckMsg').innerHTML = '<b style="color: red;">[이메일은 필수값입니다!]</b>';
                checkResultList[0] = false;
            } else if (!emailPattern.test(emailValue)) {
                $emailInput.style.borderColor = 'red';
                document.getElementById('mailCheckMsg').innerHTML =
                    '<b style="color: red;">[이메일 형식에 맞게 작성해주세요]</b>';
                checkResultList[0] = false;
            } else {


                $emailInput.style.borderColor = 'skyblue';
                document.getElementById('mailCheckMsg').innerHTML = '<b style="color: skyblue;">[확인되었습니다.]</b>';


                document.getElementById('button').onclick = e => {


                    fetch('/members/check/email/' + emailValue)
                        .then(res => res.json())
                        .then(flag => {
                            if (flag) {


                                let code = '';
                                fetch('/members/email', {
                                        method: 'post',
                                        headers: {
                                            'Content-type': 'text/plain'
                                        },
                                        body: emailValue
                                    })
                                    .then(res => res.text())
                                    .then(data => {
                                        code = data;


                                        document.getElementById(`email`).readOnly = true;
                                        document.getElementById('emailChkInput').disabled = false;


                                        document.getElementById('emailChkInput').onblur = e => {
                                            const inputCode = e.target.value;
                                            if (inputCode === code) {
                                                document.getElementById('mailCheckMsg')
                                                    .textContent = '인증번호가 일치합니다!';
                                                document.getElementById('mailCheckMsg').style
                                                    .color = 'skyblue';
                                                e.target.style.display = 'none';
                                                checkResultList[0] = true;
                                                document.getElementById('newPw').removeAttribute(
                                                    'readonly');
                                                document.getElementById('newPwChk').removeAttribute(
                                                    'readonly');
                                            } else {
                                                document.getElementById('mailCheckMsg')
                                                    .textContent = '인증번호를 다시 확인하세요!';
                                                document.getElementById('mailCheckMsg').style
                                                    .color = 'red';
                                                e.target.focus();
                                            }
                                        }
                                        alert('인증번호가 전송되었습니다.');
                                    })
                                    .catch(error => {
                                        alert('이메일 전송에 실패했습니다. 이메일을 다시 확인해주세요.');
                                    });
                            }
                        });
                }
            }
        }

        const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~@#$!%*?&])[a-zA-Z\d~@#$!%*?&]{8,}$/;

        const $pwInput = document.getElementById('newPw');
        $pwInput.addEventListener('keyup', () => {
            const pwValue = $pwInput.value.trim();
            if (pwValue === '') {
                $pwInput.style.borderColor = 'red';
                document.getElementById('pwChk').innerHTML = '<b style="color: red;">비밀번호는 필수값입니다</b>';
                checkResultList[1] = false;
                return;
            } else if (!passwordPattern.test(pwValue)) {
                $pwInput.style.borderColor = 'red';
                document.getElementById('pwChk').innerHTML = '<b style="color: red;">특수문자 포함 8자 이상 입력해주세요</b>';
                checkResultList[1] = false;
                return;
            } else {
                $pwInput.style.borderColor = 'black';
                document.getElementById('pwChk').innerHTML = '<b style="color: skyblue;">[사용가능한 비밀번호입니다]</b>';
                checkResultList[1] = true;
            }
        });

        const $newPwChkInput = document.getElementById('newPwChk');
        $newPwChkInput.addEventListener('keyup', () => {
            const reChkPwVal = $newPwChkInput.value.trim();
            const pwValue = $pwInput.value.trim();
            if (reChkPwVal === '') {
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">비밀번호 확인은 필수입력입니다.</b>';
                checkResultList[2] = false;
                return;
            } else if (reChkPwVal !== pwValue) {
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">비밀번호와 일치하지 않습니다.</b>';
                checkResultList[2] = false;
                return;
            } else {
                $newPwChkInput.style.borderColor = 'black';
                document.getElementById('pwChk2').innerHTML = '<b style="color: skyblue;">[비밀번호와 일치합니다.]</b>';
                checkResultList[2] = true;
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