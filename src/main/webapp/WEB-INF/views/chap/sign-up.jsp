<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <title>Today's weather, oh-nal</title>

  <link rel="stylesheet" href="/assets/css/sign-up.css">

</head>

<body>

  <div class="container">
    <div class="inner">
      <div class="image_container">
        <img id="imagePreview" src="ohnal-test/assets/img/cody.png" alt="이미지 미리보기">
        <form method="post" enctype="multipart/form-data">
          <div class="btn_image">
            <label for="selectFile">
              프로필사진
            </label>
          </div>
          <input type="file" id="selectFile" name="selectFile" accept="image/*">
        </form>
      </div>
      <div class="form-selection">
        <div class="form-list">
          <div class="form-nick" id="fnick">
            <p class="font"><strong>닉네임을 입력해주세요</strong>&nbsp;&nbsp;&nbsp;
              <input type="text" id="nick" name="nick" placeholder="필수입력란입니다." required="required" aria-required="true" maxlength="8" class="input">
              <span id="nickChk"></span>
          </div>
          <div class="form-pw" id="fpw">
            <p class="font"><strong>비밀번호를 입력해주세요</strong>&nbsp;&nbsp;&nbsp;
              <input type="password" id="pw" name="pw" placeholder="영문과 특수문자를 포함한 8자를 입력해주세요" maxlength="20" required="required" aria-required="true" class="input">
              <span id="pwChk"></span>
          </div>
          <div class="form-pw2" id="fpw2">
            <p class="font"><strong>비밀번호를 재확인해주세요</strong>&nbsp;&nbsp;&nbsp;
              <input type="password" id="pw2" name="pw2" placeholder="입력하신 비밀번호와 동일하게 입력해주세요" maxlength="20" required="required" aria-required="true" class="input">
          </div>
        </div>
        <div class="address">
          <input type="text" id="sample4_postcode" placeholder="우편번호">
          <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
          <input type="text" id="sample4_roadAddress" placeholder="도로명주소">
          <input type="text" id="sample4_jibunAddress" placeholder="지번주소">
          <span id="guide" style="color:#999;display:none"></span>
          <input type="text" id="sample4_detailAddress" placeholder="상세주소">
          <input type="text" id="sample4_extraAddress" placeholder="참고항목">
        </div>
        <div class="form-list">
          <div class="form-name" id="fname">
            <p class="font"><strong>이름을 입력해주세요</strong>&nbsp;&nbsp;&nbsp;
              <input type="text" id="name" name="name" placeholder="이름을 입력해주세요" required="required" aria-required="true" maxlength="6" class="input">
          </div>
          <div class="form-birth" id="fbirth">
            <p class="font"><strong>생년월일 8자리를 입력해주세요</strong>&nbsp;&nbsp;&nbsp;
              <input type="text" id="birthdayInput" placeholder="생년월일 8자리를 입력해주세요" required="required" aria-required="true" maxlength="8" class="input">
          </div>
          <div class="form-email" id="femail">
            <p class="font"><strong>이메일을 입력해주세요</strong>&nbsp;&nbsp;&nbsp;
              <input type="email" id="email" name="email" placeholder="ex) on-nal@gmail.com" required="required" aria-required="true" class="input">
          </div>
        </div>
        <div class="gender" id="divgender">
          <button type="button" class="btn_gender" name="gender" value="M" class="blind">남자</button>
          <button type="button" class="btn_gender" name="gender2" value="F" class="blind">여자</button>
        </div>
        <div class="btn_submit">
          <button type="button" class="btn_submit_button">회원가입</button>
        </div>
      </div>
    </div>
  </div>


    <%@include file="../include/footer.jsp"%>



    <script>
      //회원가입 script -form-
      const checkResultList = [false, false, false, false, false, false, false, false];
      const $nickInput = document.getElementById('nick');
      $nickInput.onkeyup = e => {
          const nickValue = $nickInput.value;

          if (nickValue.trim() === '') {
            $nickInput.style.borderColor = 'red';
            document.getElementById('nickchk').innerHTML = '<b style="color: red;">[닉네임은 필수값입니다!]</b>';
            checkResultList[0] = false;
          } else if (!accountPattern.test(nickValue)) {
            $nickInput.style.borderColor = 'red';
            document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임은 2글자 이상의 영문,한글로 입력해주세요]</b>';
            checkResultList[0] = false;
          } else {

            fetch('#' + nickValue)
              .then(res => res.json())
              .then(flag => {
                if (flag) {
                  $idInput.style.borderColor = 'red';
                  document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임이 중복되었습니다.]</b>';
                  checkResultList[0] = false;

                } else {
                  $idInput.style.borderColor = 'black';
                  document.getElementById('nickChk').innerHTML = '<b style="color: black;">[사용 가능한 닉네임입니다.]</b>';
                  checkResultList[0] = true;
                }
              });
          }

          const passwordPattern = /([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/;
          const pwInput = document.getElementById('pw');
          $pwInput.onkeyup = e => {
            const pwValue = $pwInput.value;
            if (pwValue.trim() === '') {
              $pwInput.style.borderColor = 'red';
              document.getElementById('pwChk').innerHTML = '<b style="color: red;">[비밀번호는 필수값입니다]</b>';
              checkResultList[1] = false;
            } else if (!passwordPattern.test(pwValue)) {
              $pwInput.style.borderColor = 'red';
              document.getElementById('pwChk').innerHTML = '<b style="color: red;">[특수문자 포함 8자 이상 입력해주세요]</b>';
              checkResultList[1] = false;

            } else {
              $pwInput.style.borderColor = 'black';
              document.getElementById('pwChk').innerHTML = '<b style="color: skyblue;">[사용가능한 비밀번호입니다]</b>';
              checkResultList[1] = true;
            }
          };



          // 카카오 주소API
          function sample4_execDaumPostcode() {
            new daum.Postcode({
              oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                  extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                  extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if (roadAddr !== '') {
                  document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                  document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if (data.autoRoadAddress) {
                  var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                  guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                  guideTextBox.style.display = 'block';

                } else if (data.autoJibunAddress) {
                  var expJibunAddr = data.autoJibunAddress;
                  guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                  guideTextBox.style.display = 'block';
                } else {
                  guideTextBox.innerHTML = '';
                  guideTextBox.style.display = 'none';
                }
              }
            }).open();
          }
    </script>
</body>

</html>