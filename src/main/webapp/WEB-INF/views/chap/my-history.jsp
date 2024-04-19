<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>my-history</title>
    <%@include file="../include/static-head.jsp"%>
    <link rel="stylesheet" href="/assets/css/my-history.css">
    <script type="text/javascript" src="/assets/js/my-history.js" defer></script>
</head>

<body>
    <%@include file="../include/header.jsp"%>
    <!-- My history -->
    <main class="main-wrapper">
        <div class="title">

            <div>
                <h1>My history</h1>
            </div>
            <div class="user-feed">
                <div class="user-feed-button" onclick="getMyPosts()">작성 글</div>
                <div class="user-feed-button" onclick="getMyReplyPosts()">작성 댓글</div>
                <div class="user-feed-button" onclick="getLikedPosts()">좋아요한 글</div>
            </div>
        </div>


        <c:choose>
            <c:when test="${empty bList}">
                <!-- 게시글 목록 조회 결과가 비어있다면 -->
                <tr>
                    <th colspan="5">게시글이 존재하지 않습니다.</th>
                </tr>
            </c:when>

            <c:otherwise>
                <!-- 게시글 목록 조회 결과가 비어있지 않다면 -->
                <!-- 카드 복사 -->
                <c:forEach var="b" items="${bList}">
                    <!-- 인스타 형식의 카드(글)들 전체를 감싸는 컨테이너
                이 컨테이너 안에 회원이 쓴 글, 댓글, 좋아요한 글들이 배치된다.-->
                    <div class="card-wrapper">
                        <section class="card select-card" data-bno="${b.boardNo}">
                            <div class="card-title-wrapper">
                                <div class="profile-box">
                                    <img src="/assets/img/anonymous.jpg" alt="프사">
                                </div>
                                <span class="card-account">test3</span>
                            </div>

                            <div class="card-picture">
                                <img src="/assets/img/cody.png" alt="sample">
                            </div>

                            <div class="icon-wrapper">
                                <div class="like-icon">
                                    <span class="lnr lnr-heart"></span>
                                </div>
                                <span class="hashtag">${b.locationTag}</span>
                                <span class="hashtag">${b.weatherTag}</span>
                                <div class="reply-icon">

                                </div>
                            </div>
                            <hr>
                            <div class="content-wrapper">
                                <p>
                                    <span>좋아요 ${b.likeCount}개</span>
                                    &nbsp&nbsp&nbsp
                                    <span>댓글 ${b.replyCount}개</span>
                                    &nbsp&nbsp&nbsp
                                    <span>조회수 회</span>
                                </p>
                                <p><span class="card-account">${b.nickname}</span> ${b.content}</p>
                                <a href="#">
                                    <p>... 더 보기</p>
                                </a>
                            </div>
                        </section>
                    </div>
                </c:forEach>
                <!-- 카드 복사 끝 -->
                <!-- 카드 끝 -->
                </div>


            </c:otherwise>
        </c:choose>


        <!-- 게시글 목록 하단 영역 -->
        <div class="bottom-section">

            <!-- 페이지 버튼 영역 -->
            <nav aria-label="Page navigation example">
                <ul class="pagination pagination-lg pagination-custom">
                    <c:if test="${maker.page.pageNo != 1}">
                        <li class="page-item"><a class="page-link"
                                href="/board/list?pageNo=1&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&lt;&lt;</a>
                        </li>
                    </c:if>

                    <c:if test="${maker.prev}">
                        <li class="page-item"><a class="page-link"
                                href="/board/list?pageNo=${maker.begin-1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">prev</a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                        <li data-page-num="${i}" class="page-item">
                            <a class="page-link"
                                href="/board/list?pageNo=${i}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${maker.next}">
                        <li class="page-item"><a class="page-link"
                                href="/board/list?pageNo=${maker.end+1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">next</a>
                        </li>
                    </c:if>

                    <c:if test="${maker.page.pageNo != maker.finalPage}">
                        <li class="page-item"><a class="page-link"
                                href="/board/list?pageNo=${maker.finalPage}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&gt;&gt;</a>
                        </li>
                    </c:if>

                </ul>
            </nav>



        </div>

        <%@include file="../include/footer.jsp"%>
</body>

</html>