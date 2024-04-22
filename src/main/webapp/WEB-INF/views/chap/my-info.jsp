<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <title>Today's weather, oh-nal</title>
  <%@include file="../include/static-head.jsp"%>

  <link rel="stylesheet" href="/assets/css/my-info.css">

  <!-- my-info js -->
  <script src="/assets/js/my-info.js" defer></script>

</head>

<%@include file="../include/header.jsp"%>

<body>


  <div class="container">
    <h2>My Info</h2>
    <form action="/modify-info" class="form" name="modify-info" id="modify-info" method="post" enctype="multipart/form-data">

      <div class="image_container">
        <img id="image-preview" src="/display${login.profile}" alt="프로필 사진">
      </div>

      <div class="inner-before">
        <div class="form-selection">
          <p class="inform"> ${login.nickname}님의 등록 정보입니다</p>
          <table>
            <tr>
              <td>
                <p><strong>이메일</strong></p>
              </td>
              <td><p>${login.email}</p>
                <input type="hidden" id="email" name="email" value="${login.email}">
              </td>
            </tr>
            <tr>
              <td>
                <p><strong>닉네임</strong></p>
              </td>
              <td><p>${login.nickname}</p></td>
            </tr>
            <tr>
              <td>
                <p><strong>주소</strong></p>
              </td>
              <td><p>${login.address}</p></td>
            </tr>
            <tr>
              <td>
                <p><strong>성별</strong></p>
              </td>
              <c:if test="${login.gender eq 'M'}">
                <td><p>남자</p></td>
              </c:if>
              <c:if test="${login.gender eq 'F'}">
                <td><p>여자</p></td>
              </c:if>
              <c:if test="${login.gender eq null}">
                <td><p>미입력</p></td>
              </c:if>
            </tr>
            <tr>
              <td>
                <p><strong>가입일</strong></p>
              </td>
              <td><p>${login.regDate}</p></td>
            </tr>

          </table>

        </div>
      </div>


      <%-- 수정하기 버튼 클릭 시 노출 --%>
      <div class="inner-change" style="display: none">

          <div class="btn_image">
              프로필 사진 변경
          </div>
          <input type="file" id="profileImage" name="profileImage" accept="image/*" style="display: none;">

        <div class="form-selection">

          <table>
            <tr>
              <td>
                <p><strong>이메일</strong></p>
              </td>
              <td><p>${login.email}</p></td>
              <td></td>
            </tr>
            <tr>
              <td>
                <p><strong>닉네임</strong></p>
              </td>
              <td><input class="input-part" id="nick" type="text" value=${login.nickname} name="nickname" required="required" aria-required="true"
                         placeholder="2자 이상 영문/한글 입력" maxlength="8"></input></td>
              <td><button id="nickname-check" class="btn-modify">중복 확인</button></td>
            </tr>
            <tr>
              <td>
                <p><strong>주소</strong></p>
              </td>
              <td>
                <input class="input-part" type="text" id="origin-address" value="${login.address}" readonly>
                <input class="input-part" type="text" id="sample6_address" placeholder="주소" style="display: none"><br>
                <input class="input-part" type="text" id="sample6_detailAddress" placeholder="상세주소" style="display: none">
                <input class="input-part" type="hidden" id="address" name="address">
              </td>
              <td><input class="btn-modify" type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기"></td>
            </tr>
            <tr>
              <td>
                <p><strong>성별</strong></p>
              </td>
              <c:if test="${login.gender eq 'M'}">
                <td><input type="radio" name="gender" value="M" checked> 남자
                <input type="radio" name="gender" value="F"> 여자</td>
                <td></td>
              </c:if>
              <c:if test="${login.gender eq 'F'}">
                <td><input type="radio" name="gender" value="M"> 남자
                <input type="radio" name="gender" value="F" checked> 여자</td>
                <td></td>
              </c:if>
              <c:if test="${login.gender eq null}">
                <td><input type="radio" name="gender" value="M"> 남자
                <input type="radio" name="gender" value="F"> 여자</td>
                <td></td>
              </c:if>
            </tr>
            <tr>
              <td>
                <p><strong>가입일</strong></p>
              </td>
              <td><p>${login.regDate}</p></td>
              <td></td>
            </tr>

            <tr>
              <td>
                <p><strong>비밀번호</strong></p>
              </td>
              <td>
                <p id="pw-inform">암호화되어 저장됨</p>
                <div class="form-list" style="display: none;">
                  <p class="font"><strong>새 비밀번호 입력</strong></p>
                  <input class="input-part" type="password" name="password" id="pw" name="pw" placeholder="영문+특수문자 8자리 이상" maxlength="20"
                         required="required" aria-required="true" class="input">
                  <span id="pwChk"></span>
                  <p class="font"><strong>비밀번호 재확인</strong></p>
                  <input class="input-part" type="password" id="pw2" name="pw2" placeholder="비밀번호 재입력" maxlength="20"
                         required="required" aria-required="true" class="input">
                  <span id="reChkPw"></span>
                </div>
              </td>
              <td><input id="modify-pw" class="btn-modify" type="button" value="비밀번호 변경"></td>
            </tr>

          </table>

        </div>


      </div>

      <button type="button" id="submit_button">수정하기</button>

    </form>
  </div>

  <%@include file="../include/footer.jsp"%>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    function sample6_execDaumPostcode() {
      // 수정 모드에서 주소 변경 버튼 누르면 input 태그 생성
      document.getElementById('origin-address').setAttribute("style", "display:none");
      document.getElementById('sample6_address').removeAttribute("style");
      document.getElementById('sample6_detailAddress').removeAttribute("style");


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
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById("sample6_address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("sample6_detailAddress").focus();

          document.getElementById('sample6_address').readOnly = true;

          document.getElementById('address').value = addr;
        }
      }).open();
    }

  </script>

</body>

</html>