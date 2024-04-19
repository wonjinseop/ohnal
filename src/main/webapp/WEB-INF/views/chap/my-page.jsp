<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <title>Today's weather, oh-nal</title>
  <%@include file="../include/static-head.jsp"%>

  <link rel="stylesheet" href="/assets/css/my-page.css">

</head>

<%@include file="../include/header.jsp"%>

<body>


  <div class="container">
    <h2>My PAGE</h2>
    <form action="/members/modify-info" class="form" name="modify-info" id="modify-info" method="post" enctype="multipart/form-data">

      <div class="inner-before">

        <div class="image_container">
          <img class="image-preview" src="/assets/img/cody.png" alt="이미지 미리보기">
        </div>

        <div class="form-selection">
          <div class="form-list">
            <div class="form-email">
              <p class="font"><strong>사용자 이메일</strong>&nbsp;&nbsp;&nbsp;</p>
              <p>example@gmail.com</p>
            </div>

            <div class="form-nick">
              <p class="font"><strong>닉네임</strong>&nbsp;&nbsp;&nbsp;</p>
            </div>

            <div class="address">
              <p> 주소 </p>
              <p> 서울시 마포구 신수동</p>
            </div>

            <div class="gender">
              <p>성별</p>
              <p>여자</p>
            </div>
          </div>

        </div>
      </div>


      <div class="inner-change" style="display: none">

        <div class="image_container">
          <img class="image-preview" src="/assets/img/cody.png" alt="이미지 미리보기">
          <div class="btn_image">
            <label for="selectFile">
              프로필 사진 변경
            </label>
            <input type="file" id="selectFile" name="selectFile" accept="image/*" style="display: none;">
          </div>

        </div>

        <div class="form-selection">
          <div class="form-list">

            <div class="form-email">
              <p class="font"><strong>이메일 (이메일은 수정이 불가합니다)</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="email" id="email" name="email" placeholder="사용자 이메일" required="required"
                aria-required="true" class="input" readonly>
            </div>

            <div class="form-nick">
              <p class="font"><strong>새로운 닉네임을 입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="text" id="nick" name="nick" placeholder="필수 입력란입니다." required="required" aria-required="true"
                     maxlength="8" class="input">
              <span id="nickChk"></span>
            </div>

            <div class="form-pw">
              <p class="font"><strong> 새로운 비밀번호를 입력해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="password" id="pw" name="pw" placeholder="영문과 특수문자를 포함한 8자를 입력해주세요" maxlength="20"
                required="required" aria-required="true" class="input">
              <span id="pwChk"></span>
            </div>
            <div class="form-pw2">
              <p class="font"><strong>비밀번호를 재확인해주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="password" id="pw2" name="pw2" placeholder="입력하신 비밀번호와 동일하게 입력해주세요" maxlength="20"
                required="required" aria-required="true" class="input">
              <span id="reChkPw"></span>
            </div>

            <div class="address">
              <p class="font"><strong>주소를 입력해 주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <input type="text" id="sample6_postcode" placeholder="우편번호">
              <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
              <input type="text" id="sample6_address" placeholder="주소"><br>
              <input type="text" id="sample6_detailAddress" placeholder="상세주소">
              <input type="text" id="sample6_extraAddress" placeholder="참고항목">
            </div>

            <div class="gender">
              <p class="font"><strong>성별을 선택해 주세요</strong>&nbsp;&nbsp;&nbsp;</p>
              <button type="button" class="btn_gender M" name="gender" value="M" class="blind">남자</button>
              <button type="button" class="btn_gender F" name="gender2" value="F" class="blind">여자</button>
            </div>
          </div>

        </div>


      </div>

      <button type="button" id="submit_button">수정하기</button>

    </form>
  </div>

  <%@include file="../include/footer.jsp"%>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    const checkResultList = [false, false, false];
    const $nickInput = document.getElementById('nick');
    const $pwInput = document.getElementById('pw');
    const $reChkPw = document.getElementById('pw2');


    const passwordPattern = /([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/;

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

    $reChkPw.addEventListener('keyup', () => {
      const reChkPwVal = $reChkPw.value.trim();
      const pwValue = $pwInput.value.trim();

      if (reChkPwVal === '') {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호 확인은 필수입력입니다.</b>';
        checkResultList[1] = false;
        return;
      } else if (reChkPwVal !== pwValue) {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호와 일치하지 않습니다..</b>';
        checkResultList[1] = false;
        return;
      } else {
        $reChkPw.style.borderColor = 'black';
        document.getElementById('reChkPw').innerHTML = '<b style="color: skyblue;">[비밀번호와 일치합니다.]</b>';
        checkResultList[1] = true;
      }
    });

    const nickPattern = /^[a-zA-Z가-힣]{2,}$/;

    $nickInput.addEventListener('keyup', () => {
      const nickValue = $nickInput.value.trim();

      if (nickValue === '') {
        $nickInput.style.borderColor = 'red';
        document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임은 필수값입니다!]</b>';
        checkResultList[2] = false;
        return;
      } else if (!nickPattern.test(nickValue)) {
        $nickInput.style.borderColor = 'red';
        document.getElementById('nickChk').innerHTML =
          '<b style="color: red;">[닉네임은 2글자 이상의 영문,한글로 입력해주세요]</b>';
        checkResultList[2] = false;
        return;
      } else {
        $nickInput.style.borderColor = 'skyblue';
        document.getElementById('nickChk').innerHTML = '<b style="color: skyblue;">[확인되었습니다.]</b>';
        checkResultList[2] = true;
      }

      // Fetch API를 사용하여 서버에서 중복 여부 확인
      fetch(`/checkNick?nick=${nickValue}`)
        .then(res => res.json())
        .then(flag => {
          if (flag) {
            $nickInput.style.borderColor = 'red';
            document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임이 중복되었습니다.]</b>';
            checkResultList[4] = false;
          } else {
            $nickInput.style.borderColor = 'black';
            document.getElementById('nickChk').innerHTML = '<b style="color: black;">[사용 가능한 닉네임입니다.]</b>';
            checkResultList[4] = true;
          }
        })
        .catch(error => {
          console.error('Error checking nickname:', error);
        });
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
    let selectGender = null;

    $maleButton.addEventListener('click', () => {
      selectGender = 'M';
      $maleButton.style.backgroundColor = "rgba(4, 25, 44, 0.3)";
      $femaleButton.style.backgroundColor = "";
    });

    $femaleButton.addEventListener('click', () => {
      selectGender = 'F';
      $femaleButton.style.backgroundColor = "rgba(4, 25, 44, 0.3)";
      $maleButton.style.backgroundColor = "";
    });




    document.getElementById('submit_button').onclick = e => {
      const $form = document.getElementById('modify-info');
      const $submit = document.getElementById('submit_button'); // 수정하기 버튼
      const $before = document.querySelector('.inner-before'); // 수정하기 전 사용자 정보 화면
      const $modify = document.querySelector('.inner-change'); // 사용자가 수정할 수 있는 화면

      if ($submit.textContent === "수정하기") {
        $submit.textContent = "수정 완료";
        $before.setAttribute("style", "display:none");
        $modify.removeAttribute("style");
        return;
      }

      console.log($submit.textContent);

      if (e.textContent !== "수정 완료") {
        if (!checkResultList.includes(false)) {
          alert('입력란을 다시 확인해주세요');
        } else {
          $form.submit();
        }
      }
    }

    // 카카오 주소API
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
        }
      }).open();
    }
  </script>
</body>

</html>