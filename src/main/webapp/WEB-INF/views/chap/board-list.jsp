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


    <!-- 카드 시작 -->
    <div class="card-container">

        <div class="new-upload-wrapper">
            <a href="/board/write" class="upload-btn">새 글쓰기</a>
        </div>




        <!-- 카드 복사 -->
        <c:forEach var="b" items="${bList}">
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




    <!-- 모달 열기 버튼 -->
    <button id="modalBtn" hidden>모달 글 확대</button>

    <!-- 모달 컨테이너 -->
    <div id="myModal" class="modal">
        <!-- 모달 컨텐츠 -->
        <div class="modal-content">



            <div class="card-wrapper">



                <section class="card" data-bno="${b.boardNo}">

                    <div class="modal-wrapper-card" style="display: flex;">

                        <div class="card-picture modal-wrapper-card-1">
                            <img src="/assets/img/cody.png" alt="sample" class="content-img">
                        </div>






                        <div class="modal-wrapper-card-2">

                            <div class="card-title-wrapper">

                                <div class="profile-box">
                                    <img src="/assets/img/anonymous.jpg" alt="프사">
                                </div>
                                <span class="card-account card-account1">test3</span>
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
                                    <p class="content-comments content"><span class="card-account card-account2"></span>
                                    </p>

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





                                <div class="reply-wrapper">
                                    <span class="card-account">test3</span>
                                    <p class="reply">
                                        일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게
                                        좋아일교차가 클일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를
                                    </p>
                                    <!-- <input type="text" hidden> -->
                                </div>

                                <div class="reply-data">
                                    <span>시간영역</span>
                                    <button id="comments-modify">수정
                                    </button>
                                    <button>삭제</button>
                                </div>
                                <div class="reply-wrapper">
                                    <span class="card-account">test3</span>
                                    <p class="reply">
                                        일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게
                                        좋아일교차가 클일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를
                                    </p>
                                    <!-- <input type="text" hidden> -->
                                </div>

                                <div class="reply-data">
                                    <span>시간영역</span>
                                    <button id="comments-modify">수정
                                    </button>
                                    <button>삭제</button>
                                </div>
                                
                                <div class="reply-wrapper">
                                    <span class="card-account">test3</span>
                                    <p class="reply">
                                        일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게
                                        좋아일교차가 클일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를
                                    </p>
                                    <!-- <input type="text" hidden> -->
                                </div>

                                <div class="reply-data">
                                    <span>시간영역</span>
                                    <button id="comments-modify">수정
                                    </button>
                                    <button>삭제</button>
                                </div>

                                <div class="reply-wrapper">
                                    <span class="card-account">test3</span>
                                    <p class="reply">
                                    걸치는 게 좋아일교차가 클 땐 아우터를
                                    </p>
                                    <!-- <input type="text" hidden> -->
                                </div>

                                <div class="reply-data">
                                    <span>시간영역</span>
                                    <button id="comments-modify">수정
                                    </button>
                                    <button>삭제</button>
                                </div>

                                <div class="reply-wrapper">
                                    <span class="card-account">test3</span>
                                    <p class="reply">
                                        일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게
                                        좋아일교차가 클일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를
                                    </p>
                                    <!-- <input type="text" hidden> -->
                                </div>

                                <div class="reply-data">
                                    <span>시간영역</span>
                                    <button id="comments-modify">수정
                                    </button>
                                    <button>삭제</button>
                                </div>

                                <div class="reply-wrapper">
                                    <span class="card-account">test3</span>
                                    <p class="reply">
                                        일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아일교차가 클 땐 아우터를 가볍게 걸치는 게
                                    </p>
                                    <!-- <input type="text" hidden> -->
                                </div>

                                <div class="reply-data">
                                    <span>시간영역</span>
                                    <button id="comments-modify">수정
                                    </button>
                                    <button>삭제</button>
                                </div>


                            </div>



                            <div class="write-reply">
                                <div class="write-wrapper"><input class="write-input"
                                        placeholder="여기는 댓글 입력창입니다."></input>
                                </div>
                                <div><a class="write-send" href="#">입력</a></div>
                            </div>


                        </div>

                </section>
            </div>
        </div>
    </div>


    <%@include file="../include/footer.jsp"%>
</body>

</html>