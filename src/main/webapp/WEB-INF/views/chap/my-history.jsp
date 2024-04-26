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

                <div class="user-feed-button" id="mypost1"><a href="/members/my-history">작성 글</a></div>


                <div class="user-feed-button" id="mypost2"><a href="/members/my-history/find-my-comments">작성 댓글</a>
                </div>

                <div class="user-feed-button" id="mypost3"><a href="/members/my-history/find-my-like-post">좋아요 글</a>

                </div>

            </div>
        </div>

        <div class="card-container">
            
            <c:choose>
                <c:when test="${empty myPosts}">
                    <!-- 게시글 목록 조회 결과가 비어있다면 -->
                    <div class="empty-post-box">
                        <div>
                            <h1>텅</h1>
                        </div>
                        <p><span id="changeText">게시글</span>이 존재하지 않습니다.</p>
                    </div>
                </c:when>

                <c:otherwise>
                   
                    <c:forEach var="mp" items="${myPosts}">
          
                        <div class="card-wrapper" data-email="${login.email}">
                            <section class="card select-card" data-bno="${mp.boardNo}">
                                <div class="card-title-wrapper">
                                    <div class="profile-box">
                                        <img src="${mp.profileImage}" alt="프사">
                                    </div>
                                    <span class="card-account">${mp.nickname}</span>
                                    <c:if test="${login.email == mp.email}">
                                        <button class="board-del-btn" type="button">삭제</button>
                                    </c:if>
                                </div>

                                <div class="card-picture">
                                    <img src="/display${mp.image}" alt="sample">
                                </div>

                                <div class="icon-wrapper">
                                    <div class="like-icon">
                                        <c:choose>
                                           
                                            <c:when test="${mp.likeNo != 0 && mp.likeEmail == login.email}">
                                                <img class="heart" src="/assets/img/fill-heart.svg" alt="빨강색 좋아요 버튼">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="heart" src="/assets/img/heart.svg" alt="좋아요 버튼">
                                            </c:otherwise>

                                        </c:choose>
                                    </div>

                                    <span class="hashtag">${mp.locationTag}</span>
                                    <span class="hashtag">${mp.weatherTag}</span>
                                    <div class="reply-icon">

                                    </div>
                                </div>

                                <hr>
                                <div class="content-wrapper">
                                    <p class="count-wrapper">
                                        <span class="count">좋아요 ${mp.likeCount}개</span>
                                        &nbsp&nbsp&nbsp
                                        <span class="count">댓글 ${mp.replyCount}개</span>
                                        &nbsp&nbsp&nbsp
                                        <span class="count">조회수 ${mp.viewCount}회</span>
                                    </p>
                                    <p class="main-content">${mp.content}</p>
                                    <a href="#modalBtn">
                                        <p>... 더 보기</p>
                                    </a>
                                </div>
                            </section>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        <!-- 카드 복사 끝 -->
        <!-- 카드 끝 -->



        <!-- 게시글 목록 하단 영역 -->
        <div class="bottom-section">

            <!-- 페이지 버튼 영역 -->
            <nav aria-label="Page navigation example">
                <ul class="pagination pagination-lg pagination-custom">
                    <c:if test="${maker.page.pageNo != 1}">
                        <li class="page-item"><a class="page-link"
                                href="/member/my-history?pageNo=1&amount=${s.amount}">&lt;&lt;</a>
                        </li>
                    </c:if>

                    <c:if test="${maker.prev}">
                        <li class="page-item"><a class="page-link"
                                href="/member/my-history?pageNo=${maker.begin-1}&amount=${s.amount}">prev</a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                        <li data-page-num="${i}" class="page-item">
                            <a class="page-link" href="/member/my-history?pageNo=${i}&amount=${s.amount}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${maker.next}">
                        <li class="page-item"><a class="page-link"
                                href="/member/my-history?pageNo=${maker.end+1}&amount=${s.amount}">next</a>
                        </li>
                    </c:if>

                    <c:if test="${maker.page.pageNo != maker.finalPage}">
                        <li class="page-item"><a class="page-link"
                                href="/board/list?pageNo=${maker.finalPage}&amount=${s.amount}">&gt;&gt;</a>
                        </li>
                    </c:if>

                </ul>
            </nav>



        </div>
    </main>

    <button id="modalBtn" hidden>모달 글 확대</button>

    <!-- 모달 컨테이너 -->
    <div id="myModal" class="modal">
        <!-- 모달 컨텐츠 -->
        <div class="modal-content">
            <div class="card-wrapper">
                <section class="card" data-bno="">
                    <div class="modal-wrapper-card" style="display: flex;">

                        <!-- 글쓴 사람이 내용과 함께 올린 사진 -->
                        <div class="card-picture modal-wrapper-card-1">
                            <img src="" alt="sample" class="content-img">
                        </div>

                        <div class="modal-wrapper-card-2">
                            <div class="card-title-wrapper">
                                <div class="profile-box">
                                    <img src="/assets/img/anonymous.jpg" alt="프사">
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
                                    <span class="lnr lnr-heart"></span>
                                    <div class="hashtag-wrapper">
                                        <span class="hashtag location"></span>
                                        <span class="hashtag weather"></span>
                                    </div>

                                    <span class="like-count"></span>
                                    &nbsp&nbsp&nbsp
                                    <span class="reply-count"></span>
                                    &nbsp&nbsp&nbsp
                                    <span class="view-count"></span>
                                </div>

                            </div>



                            <div class="replys">
                                <p class="content-comments content"></p>
                                <div class='reply-wrapper'>

                                </div>
                            </div>

                            <form id="commentFrm" class="write-reply">
                                <div class="write-wrapper">
                                    <input name="content" class="write-input" placeholder="여기는 댓글 입력창입니다."></input>
                                    <button class="write-send" type="button">등록</button>
                                </div>
                            </form>

                        </div>

                </section>
            </div>
        </div>
    </div>

    <%@include file="../include/footer.jsp"%>

    <script>
        const $email = '${sessionScope.login}';
        const mp = '${mp}';
        console.log(mp);

        const btn1 = document.getElementById('mypost1');
        const btn2 = document.getElementById('mypost2');
        const btn3 = document.getElementById('mypost3');

        const $changeText = document.getElementById('changeText');

        const type = '${type}';

        if (type === '1') {
            console.log(`타입이 ${type} 입니다.`);
            btn1.classList.add('selected');
            $changeText.textContent = '게시글';

        } else if (type === '2') {
            console.log(`타입이 ${type} 입니다.`);
            btn2.classList.add('selected');
            $changeText.textContent = '작성 댓글';

        } else if (type === '3') {
            console.log(`타입이 ${type} 입니다.`);
            btn3.classList.add('selected');
            $changeText.textContent = '좋아요한 글';
        }
    </script>
</body>

</html>