<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <title>Today's weather, oh-nal</title>
  <%@include file="../include/static-head.jsp"%>

  <link rel="stylesheet" href="/assets/css/sign-up.css">

</head>

<body>
<%@include file="../include/header.jsp"%>

  <div class="container">

    <form action="/members/sign-up" name="signup" id="signUpForm" method="post" enctype="multipart/form-data">

      <div class="inner">

        <div class="image_container">

          <img id="imagePreview" src="/assets/img/anonymous.jpg" alt="이미지 미리보기">
          <div class="btn_image">
              프로필 사진
          </div>
          <input type="file" id="selectFile" name="profileImage" accept="image/*" style="display: none;">

        </div>

        <div class="form-selection">
          <div class="form-list">

            <div class="form-email" id="femail">
              <p class="font"><strong>이메일을 입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="email" id="email" name="email" placeholder=" ex) on-nal@gmail.com" required="required"
                aria-required="true" class="input">
              <button type="button" id="emailAuth">이메일 인증</button>
              <input type="text" id="emailChkInput" placeholder=" 인증번호 6자리를 입력하세요." maxlength="6" disabled> <br>
              <span id="mailCheckMsg"></span>
              <span id="emailChk"></span>
            </div>

            <div class="form-pw" id="fpw">
              <p class="font"><strong>비밀번호를 입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="password" id="pw" name="password" placeholder=" 영문, 숫자, 특수문자를 포함한 8자 이상의 비밀번호를 입력해주세요" maxlength="20"
                required="required" aria-required="true" class="input">
              <span id="pwChk"></span>
            </div>
            <div class="form-pw2" id="fpw2">
              <p class="font"><strong>비밀번호를 재입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="password" id="pw2" placeholder=" 입력하신 비밀번호와 동일하게 입력해주세요" maxlength="20" required="required"
                aria-required="true" class="input">
              <span id="reChkPw"></span>
            </div>

            <div class="address" name="address">
              <input type="text" id="sample6_postcode" placeholder=" 우편번호">
              <input type="button" class="addressbtn" onclick="sample6_execDaumPostcode()" value=" 우편번호 찾기"><br>
              <input type="text" id="sample6_address" placeholder=" 주소"><br>
              <input type="text" id="sample6_detailAddress" placeholder=" 상세주소">
              <input type="text" id="sample6_extraAddress" placeholder=" 참고항목">

              <input type="hidden" id="address" name="address">

            </div>

            <div class="form-nick" id="fnick">
              <p class="font"><strong>닉네임을 입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="text" id="nick" name="nickname" placeholder=" 필수입력란입니다." required="required"
                aria-required="true" maxlength="8" class="input">
              <span id="nickChk"></span>
            </div>

            <div class="gender" id="divgender" name="gender">
              <button type="button" class="btn_gender M" name="gender" value="M" class="blind">남자</button>
              <button type="button" class="btn_gender F" name="gender" value="F" class="blind">여자</button>

               <input type="hidden" id="gender" name="gender">

            </div>

            <div class="btn_submit">
              <button type="button" id="btn_submit_button">회원가입</button>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>



  <%@include file="../include/footer.jsp"%>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    const checkResultList = [false, false, false, false, false, false];
    const $nickInput = document.getElementById('nick');
    const $pwInput = document.getElementById('pw');
    const $reChkPw = document.getElementById('pw2');



    document.getElementById('emailAuth').onclick = e => {
      alert('이메일을 확인 후 눌러주세요!');
    }


    const emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
    const $emailInput = document.getElementById('email');

    $emailInput.onkeyup = e => {
      const emailValue = $emailInput.value;
      if (emailValue.trim() === '') {
        $emailInput.style.borderColor = 'red';
        document.getElementById('emailChk').innerHTML = '<b style="color: red;">[이메일은 필수값입니다!]</b>';
        checkResultList[0] = false;
      } else if (!emailPattern.test(emailValue)) {
        $emailInput.style.borderColor = 'red';
        document.getElementById('emailChk').innerHTML = '<b style="color: red;">[이메일 형식에 맞게 작성해주세요]</b>';
        checkResultList[0] = false;
      } else {
        fetch(`/members/check/email/` + emailValue)
          .then(res => res.json())
          .then(flag => {
            if (flag) {
              $emailInput.style.borderColor = 'red';
              document.getElementById('emailChk').innerHTML = '<b style="color: red;">[이메일이 중복되었습니다.]</b>';
              checkResultList[0] = false;
            } else {
              $emailInput.style.borderColor = 'skyblue';
              document.getElementById('emailChk').innerHTML = '<b style="color: skyblue;">[사용가능한 이메일입니다.]</b>';


              let code = '';

              document.getElementById('emailAuth').onclick = () => {
                const email = document.getElementById('email').value.trim();
                console.log(email);

                fetch(`/members/email`, {
                    method: `post`,
                    headers: {
                      'Content-type': 'text/plain'
                    },
                    body: email
                  })
                  .then(res => res.text())
                  .then(data => {
                    code = data;

                    document.getElementById(`email`).readOnly = true;

                    document.getElementById('emailChkInput').disabled = false;

                    document.getElementById('emailChkInput').onblur = e => {
                      const inputCode = e.target.value;
                      if (inputCode === code) {
                        document.getElementById('mailCheckMsg').textContent = '인증번호가 일치합니다!';
                        document.getElementById('mailCheckMsg').style.color = 'skyblue';
                        e.target.style.display = 'none';
                        checkResultList[0] = true;
                      } else {
                        document.getElementById('mailCheckMsg').textContent = '인증번호를 다시 확인하세요!';
                        document.getElementById('mailCheckMsg').style.color = 'red';
                        e.target.focus();
                      }
                    }
                    alert('인증번호가 전송되었습니다.');
                  })
                  .catch(error => {
                    alert('이메일 전송에 실패했습니다. 이메일을 다시 확인해주세요.');
                  });
              };
            }
          });
      }
    };



    const passwordPattern =/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~@#$!%*?&])[a-zA-Z\d~@#$!%*?&]{8,}$/;

    $pwInput.addEventListener('keyup', () => {
      const pwValue = $pwInput.value.trim();

      if (pwValue === '') {
        $pwInput.style.borderColor = 'red';
        document.getElementById('pwChk').innerHTML = '<b style="color: red;">비밀번호는 필수값입니다</b>';
        checkResultList[1] = false;
        return;
      } else if (!passwordPattern.test(pwValue)) {
        $pwInput.style.borderColor = 'red';
        document.getElementById('pwChk').innerHTML = '<b style="color: red;">영문, 숫자, 특수문자 포함 8자 이상 입력해주세요</b>';
        checkResultList[1] = false;
        return;
      } else {
        $pwInput.style.borderColor = 'black';
        document.getElementById('pwChk').innerHTML = '<b style="color: skyblue;">[사용가능한 비밀번호입니다]</b>';
        checkResultList[1] = true;
      }
    });

    $reChkPw.addEventListener('keyup', () => {
      const reChkPwVal = $reChkPw.value.trim();
      const pwValue = $pwInput.value.trim();

      if (reChkPwVal === '') {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호 확인은 필수입력입니다.</b>';
        checkResultList[2] = false;
        return;
      } else if (reChkPwVal !== pwValue) {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호와 일치하지 않습니다.</b>';
        checkResultList[2] = false;
        return;
      } else {
        $reChkPw.style.borderColor = 'black';
        document.getElementById('reChkPw').innerHTML = '<b style="color: skyblue;">[비밀번호와 일치합니다.]</b>';
        checkResultList[2] = true;
      }
    });


    const nickPattern = /^[a-zA-Z가-힣]{2,}$/;

    $nickInput.addEventListener('keyup', () => {
      const nickValue = $nickInput.value.trim();

      if (nickValue === '') {
        $nickInput.style.borderColor = 'red';
        document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임은 필수값입니다!]</b>';
        checkResultList[3] = false;
        return;
      } else if (!nickPattern.test(nickValue)) {
        $nickInput.style.borderColor = 'red';
        document.getElementById('nickChk').innerHTML =
          '<b style="color: red;">[닉네임은 2글자 이상의 영문,한글로만 입력해주세요]</b>';
        checkResultList[3] = false;
        return;
      } else {
        fetch(`/members/check/nickname/` + nickValue)
          .then(res => res.json())
          .then(flag => {
            if (flag) {
              $nickInput.style.borderColor = 'red';
              document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임이 중복되었습니다.]</b>';
              checkResultList[3] = false;
            } else {
              $nickInput.style.borderColor = 'black';
              document.getElementById('nickChk').innerHTML = '<b style="color: skyblue;">[사용 가능한 닉네임입니다.]</b>';
              checkResultList[3] = true;
            }
          })
          .catch(error => {
            console.error('Error checking nickname:', error);
          });
      }
    });



    const $image = document.getElementById('imagePreview');
    const $profile_btn = document.querySelector('.btn_image')
    const $fileInput = document.getElementById('selectFile');

    $profile_btn.onclick = e => {
      $fileInput.click();
    }
    $fileInput.onchange = e => {
      const fileData = $fileInput.files[0];
      const reader = new FileReader();

      reader.readAsDataURL(fileData);

      reader.onloadend = () => {
        $image.setAttribute('src', reader.result);
      }
    }

    const $maleButton = document.querySelector('.M');
    const $femaleButton = document.querySelector('.F');

    function handleButtonClick(selectedButton, unselectedButton) {
      const selectedValue = selectedButton.value;
      selectedButton.style.backgroundColor = "rgba(4, 25, 44, 0.3)";
      unselectedButton.style.backgroundColor = "";
      unselectedButton.value = ""; // 선택되지 않은 버튼의 값 삭제
      checkResultList[4] = true;
    }

    $maleButton.addEventListener('click', () => {
      $maleButton.style.backgroundColor = "skyblue";
      $maleButton.value="M";
      $femaleButton.style.backgroundColor = "";
      $femaleButton.value = ""; // 선택되지 않은 버튼의 값 삭제
      document.getElementById('gender').value = 'M';
      checkResultList[4] = true;
      $maleButton.style.color = "#ffffff";
    });

    $femaleButton.addEventListener('click', () => {
      $femaleButton.style.backgroundColor = "pink";
      $femaleButton.value="F";
      $maleButton.style.backgroundColor = "";
      $maleButton.value = ""; // 선택되지 않은 버튼의 값 삭제
       document.getElementById('gender').value = 'F';
      checkResultList[4] = true;
      $femaleButton.style.color = "#ffffff";

    });


    function sample6_execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function (data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ''; // 주소 변수
          var extraAddr = ''; // 참고항목 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
          }

          // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
          if (data.userSelectedType === 'R') {
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
              extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== '' && data.apartment === 'Y') {
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraAddr !== '') {
              extraAddr = ' (' + extraAddr + ')';
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById("sample6_extraAddress").value = extraAddr;

          } else {
            document.getElementById("sample6_extraAddress").value = '';
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById('sample6_postcode').value = data.zonecode;
          document.getElementById("sample6_address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("sample6_detailAddress").focus();

          document.getElementById('sample6_postcode').readOnly = true;
          document.getElementById('sample6_address').readOnly = true;
          document.getElementById('sample6_extraAddress').readOnly = true;

              document.getElementById('address').value = addr;
          checkResultList[5] = true;

        }
      }).open();
    }



    document.getElementById('btn_submit_button').onclick = e => {
      const $form = document.getElementById('signUpForm');

      if (checkResultList.includes(false)) {
        alert('입력란을 다시 확인해주세요');
      } else {
        $form.submit();
      }
    }

  </script>
</body>

</html>