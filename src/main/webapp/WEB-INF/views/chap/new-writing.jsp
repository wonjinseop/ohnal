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

  <div class="new-writing-wrapper">


    <!-- <form class="cody-load btn_image">
      <label for="ex_file"><img class="imagePreview" src="/assets/img/upload1.png" alt="">
        <input type="file" id="ex_file selectFile" name="filename" multiple hidden>
      </label>

    </form> -->

    <div class="image_container cody-load">
      <div class="btn_image">
        <label for="selectFile">
          <img id="imagePreview" src="/assets/img/upload.png" alt="이미지 미리보기">
        </label>
      </div>
      <input type="file" id="selectFile" name="selectFile" accept="image/*" style="display: none;">
    </div>

    <div class="user-info">
      <div>

        <div class="profile-name">
          <div class="profile-box">
            <img src="/assets/img/anonymous.jpg" alt="프사">
          </div>
          <span class="user-name">
            <p>test3</p>
          </span>
        </div>

        <div class="hash">
          <span class="hashtag">#서울시강남구</span>
          <span class="hashtag">#최저12최고25</span>
        </div>

      </div>




      <div class="write-content1">
        <!-- <label class="write-input" placeholder="게시글 문구를 입력해주세요."></label> -->
        <textarea class="write-input" id="content" name="content" maxlength="200" required placeholder=" 게시물 문구를 작성해주세요."></textarea>
        <button class="content" type="submit">등록</button>
      </div>
    </div>

  </div>


  <%@include file="../include/footer.jsp"%>
</body>

</html>