<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>my-history</title>
    <%@include file="../include/static-head.jsp"%>
    <link rel="stylesheet" href="/assets/css/my-history.css">
</head>

<body>
    <%@include file="../include/header.jsp"%>
    <header>
        <h1>My History</h1>
    </header>
    <main>
        <section class="my-posts">
            <h2>My Posts</h2>
            <ul id="my-posts-list">
                <!-- 내가 작성한 글 목록이 여기에 동적으로 추가됩니다. -->
                <li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
                <li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
                <li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
                <li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
                <li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
            </ul>
        </section>
        <section class="liked-posts">
            <h2>Liked Posts</h2>
            <ul id="liked-posts-list">
                <!-- 내가 좋아요한 글 목록이 여기에 동적으로 추가됩니다. -->
                <li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
                <li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
                <li>rrrr
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
<li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
<li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
</ul>
</section>
<section class="my-comments">
<h2>My Comments</h2>
<ul id="my-comments-list">
<!-- 내가 작성한 댓글 목록이 여기에 동적으로 추가됩니다. -->
<li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
<li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
<li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
<li>rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
<li>rrrr

rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr<li>
</ul>
</section>
</main>
<%@include file="../include/footer.jsp"%>

</body>
</html>