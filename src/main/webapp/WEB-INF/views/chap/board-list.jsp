<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <title>Today's weather, oh-nal</title>
    <%@include file="../include/static-head.jsp"%>
    <link rel="stylesheet" href="/assets/css/board-list.css">
    <script type="text/javascript" src="/assets/js/board-list.js" defer></script>

</head>

<body>
    <%@include file="../include/header.jsp"%>
    
    <!-- BEST OOTD 게시판 영역 -->

        <div class="top-wrapper">
            <input id="keywordValue" type="text" value="${s.keyword}" hidden></input>
            <form action="/board/list" method="get">
                <select name="keyword" id="keyword">
                    <option id="option1" value=""></option>
                    <option id="option2" value=""></option>
                    <option id="option3" value=""></option>
                    <option id="option4" value=""></option>
                </select>
                <button id="submitBtn" type="submit" hidden></button>
            </form>
            <a href="/board/write" class="upload-btn">새 글쓰기</a>
        </div>

        <a class="refresh" href="/board/list?pageNo=${maker.page.pageNo}&amount=${s.amount}&keyword=${s.keyword}" hidden></a>

    <!-- 카드 시작 -->
    <div class="card-container" data-auth="${login.auth}">


        <!-- 카드 복사 -->
        <c:forEach var="b" items="${bList}">
            <div class="card-wrapper box">
                <section class="card select-card" data-bno="${b.boardNo}" data-email="${login.email}">
                    <div class="card-title-wrapper">
                        <div class="profile-box">
                            <img src="${b.profileImage}" alt="프사">
                        </div>
                        <span class="card-account">${b.nickname}</span>
                        <c:if test="${login.email == b.email || login.auth == 'ADMIN'}"><button class="board-del-btn" type="button">삭제</button>
                        </c:if>
                    </div>

                    <div class="card-picture">
                        <img src="/display${b.image}" alt="sample">
                    </div>

                    <div class="icon-wrapper">
                        <div class="like-icon">
                            <c:choose>
                                <c:when test="${b.likeNo != 0 && b.likeEmail == login.email}">
                                    <img class="heart" src="/assets/img/fill-heart.svg" alt="좋아요 버튼">
                                </c:when>
                                <c:otherwise>
                                    <img class="heart" src="/assets/img/heart.svg" alt="좋아요 버튼">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <span class="hashtag">${b.locationTag}</span>
                        <span class="hashtag">${b.weatherTag}</span>
                        <div class="reply-icon">

                        </div>
                    </div>
                    <hr>
                    <div class="content-wrapper">
                        <p class="count-wrapper">
                            <span class="count">좋아요 ${b.likeCount}개</span>
                            &nbsp&nbsp&nbsp
                            <span class="count">댓글 ${b.replyCount}개</span>
                            &nbsp&nbsp&nbsp
                            <span class="count">조회수 ${b.viewCount}회</span>
                        </p>
                        <p class="main-content">${b.content}</p>
                        <a href="#modalBtn">
                            <p>... 더 보기</p>
                        </a>
                    </div>
                </section>
            </div>
        </c:forEach>
        <!-- 카드 복사 끝 -->
        <!-- 카드 끝 -->



    </div>



    <!-- 게시글 목록 하단 영역 -->
    <div class="bottom-section">

        <!-- 페이지 버튼 영역 -->
        <nav aria-label="Page navigation example">
            <ul class="pagination pagination-lg pagination-custom">
                <c:if test="${maker.page.pageNo != 1}">
                    <li class="page-item"><a class="page-link"
                            href="/board/list?pageNo=1&amount=${s.amount}&keyword=${s.keyword}">&lt;&lt;</a>
                    </li>
                </c:if>

                <c:if test="${maker.prev}">
                    <li class="page-item"><a class="page-link"
                            href="/board/list?pageNo=${maker.begin-1}&amount=${s.amount}&keyword=${s.keyword}">prev</a>
                    </li>
                </c:if>

                <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                    <c:if test="${maker.page.pageNo != i}">
                        <li data-page-num="${i}" class="page-item">
                            <a class="page-link"
                                href="/board/list?pageNo=${i}&amount=${s.amount}&keyword=${s.keyword}">${i}</a>
                        </li>
                    </c:if>
                    <c:if test="${maker.page.pageNo == i}">
                        <li data-page-num="${i}" class="page-item hover">
                            <a class="page-link"
                                href="/board/list?pageNo=${i}&amount=${s.amount}&keyword=${s.keyword}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>

                <c:if test="${maker.next}">
                    <li class="page-item"><a class="page-link"
                            href="/board/list?pageNo=${maker.end+1}&amount=${s.amount}&keyword=${s.keyword}">next</a>
                    </li>
                </c:if>

                <c:if test="${maker.page.pageNo != maker.finalPage}">
                    <li class="page-item"><a class="page-link"
                            href="/board/list?pageNo=${maker.finalPage}&amount=${s.amount}&keyword=${s.keyword}">&gt;&gt;</a>
                    </li>
                </c:if>

            </ul>
        </nav>

    </div>




    <!-- 모달 열기 버튼 -->
    <button id="modalBtn" hidden>모달 글 확대</button>

    <!-- 모달 컨테이너 -->
    <div id="myModal" class="modal" data-email="${login.email}">
        <!-- 모달 컨텐츠 -->
        <div class="modal-content">



            <div class="card-wrapper">



                <section class="card" data-bno="">

                    <div class="modal-wrapper-card" style="display: flex;">

                        <div class="card-picture modal-wrapper-card-1">
                            <img src="" alt="sample" class="content-img">
                        </div>






                        <div class="modal-wrapper-card-2">

                            <div class="card-title-wrapper">

                                <div class="profile-box">
                                    <img src="" alt="프사" class="profile-image">
                                </div>
                                <span class="card-account"></span>
                                <span class="time-stamp"></span>
                                <!-- 모달 닫기 버튼 -->
                                <span class="close" id="closeBtn">&times;</span>

                            </div>


                            <div class="icon-wrapper">
                                <div class="reply-icon">
                                    <!-- <span class="lnr lnr-bubble"></span> -->
                                </div>
                            </div>

                            <div class="li-ha">

                                <div class="like-icon">
                                    <c:choose>
                                        <c:when test="${b.likeNo != 0 && b.likeEmail == login.email}">
                                            <img class="heart" src="/assets/img/fill-heart.svg" alt="좋아요 버튼">
                                        </c:when>
                                        <c:otherwise>
                                            <img class="heart" src="/assets/img/heart.svg" alt="좋아요 버튼">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="hashtag-wrapper">
                                        <span class="hashtag location"></span>
                                        <span class="hashtag weather"></span>
                                    </div>

                                    <span class="like-count count"></span>
                                    &nbsp&nbsp&nbsp
                                    <span class="reply-count count"></span>
                                    &nbsp&nbsp&nbsp
                                    <span class="view-count count"></span>
                                </div>
                            </div>




                            <div class="replys">
                                <p class="content-comments content"></p>
                                <div class='reply-wrapper'>

                                </div>
                            </div>

                            <div id="commentFrm" class="write-reply">
                                <div class="write-wrapper">
                                    <input name="nickname" class="nickname" value="${login.nickname}" hidden></input>
                                    <input name="email" class="email" value="${login.email}" hidden></input>
                                    <c:if test="${login != ''}">
                                        <input name="content" class="write-input" placeholder="여기는 댓글 입력창입니다."></input>
                                    </c:if>
                                    <c:if test="${login == ''}">
                                        <input name="content" class="write-input" placeholder="여기는 댓글 입력창입니다." readonly></input>
                                    </c:if>
                                    <button class="write-send" type="button">등록</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </section>
            </div>
        </div>
    </div>


    <%@include file="../include/footer.jsp"%>
</body>

</html>