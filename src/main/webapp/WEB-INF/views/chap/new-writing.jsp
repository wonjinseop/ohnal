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
        <label for="image">
          <img id="img" src="/assets/img/upload.png" alt="이미지 미리보기">
        </label>
      </div>
      <input type="file" id="selectFile" name="image" accept="image/*" style="display: none;">
    </div>

    <div class="user-info">
      <div>

        <div class="profile-name">
          <div class="profile-box">
            <img src="/display${login.profile}" alt="프사">
          </div>
          <input type="text" id="nickname" name="nickname" value="user" readonly>
        </div>

        <div class="hash">
          <input type="text" class="hashtag" id="locationTag" name="locationTag" value="#서울시강남구"></input>
          <input type="text" class="hashtag" id="weatherTag" name="weatherTag" value="#최저12최고25"></input>
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