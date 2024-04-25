<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <title>Today's weather, oh-nal</title>
  <%@include file="../include/static-head.jsp"%>
  <link rel="stylesheet" href="/assets/css/new-writing.css">
  <script src="/assets/js/new-writing.js" defer></script>
  

</head>

<body>
  <%@include file="../include/header.jsp"%>

  <form class="new-writing-wrapper" action="/board/write" method="post" enctype="multipart/form-data">

    <div class="image_container cody-load">
      <div class="btn_image">
        <label for="img">
          <img id="img" src="/assets/img/upload.png" alt="이미지 미리보기">
        </label>
      </div>
      <input type="file" id="selectFile" name="image" accept="image/*" style="display: none;">
    </div>

    <div class="user-info">
      <div>

        <div class="profile-name">
          <div class="profile-box">
            <img src="${login.profile}" alt="프사">
          </div>
          <input type="text" id="nickname" name="nickname" value="${login.nickname}" readonly>
        </div>

        <div class="hash">
              <select name="h_area1" onChange="cat1_change(this.value,h_area2)" class="h_area1">
                <option>시, 도를 선택하세요</option>
                <option value='1'>서울특별시</option>
                <option value='2'>부산광역시</option>
                <option value='3'>대구광역시</option>
                <option value='4'>인천광역시</option>
                <option value='5'>광주광역시</option>
                <option value='6'>대전광역시</option>
                <option value='7'>울산광역시</option>
                <option value='8'>강원특별자치도</option>
                <option value='9'>경기도</option>
                <option value='10'>경상남도</option>
                <option value='11'>경상북도</option>
                <option value='12'>전라남도</option>
                <option value='13'>전라북도</option>
                <option value='14'>제주특별자치도</option>
                <option value='15'>충청남도</option>
                <option value='16'>충청북도</option>
              </select>
              <select name="h_area2" class="h_area2">
                <option>시,군,구를 선택하세요</option>
              </select>
              <input type="text" name="valueArea1" id="valueArea1" hidden>
              <input type="text" name="valueArea2" id="valueArea2" hidden>
        </div>

      </div>

      <div class="write-content1">
        <!-- <label class="write-input" placeholder="게시글 문구를 입력해주세요."></label> -->
        <textarea class="write-input" id="content" name="content" maxlength="200" required placeholder=" 게시물 문구를 작성해주세요."></textarea>
        <button class="btn" type="submit">등록</button>
      </div>
    </div>

  </form>


  <%@include file="../include/footer.jsp"%>

</body>

</html>