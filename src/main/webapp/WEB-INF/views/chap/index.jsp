<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <title>Today's weather, oh-nal</title>
    <%@include file="../include/static-head.jsp"%>

    <!-- index page css -->
    <link rel="stylesheet" href="/assets/css/main.css">

    <!-- weather search event js -->
    <script src="/assets/js/weather-search.js" defer></script>

    <%-- swiper.js --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="/assets/js/index.js" defer></script>
</head>

<body>
    <%@include file="../include/header.jsp"%>
    <div class="snowflakes" aria-hidden="true">
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
        <div class="snowflake">❄</div>
    </div>

    <div id="wrap">
        <div class="top-section">
            <div class="left-section">
                <div class="left-top">
                    <img class="weather-icon" src="/assets/img/weather-icon/${dto.weatherIcon}" alt="weather">
                </div>
                <div class="left-middle">
                    <p>현재 기온<span>${dto.presentTemperature}°</span></p>
                </div>
                <div class="left-down">
                    <h2>오늘 ${dto.area1} ${dto.area2}의 기온은</h2>
                    <h2>최저 ${minInt}도, 최고 ${maxInt}도입니다</h2>
                </div>
            </div>
            <div class="right-section">
                <div class="right-top">
                    <h2>오늘의 패션 예보</h2>
                </div>
                <c:if test="${login.gender == null}">
                    <div class="swiper">
                        <!-- Additional required wrapper -->
                        <div class="swiper-wrapper">
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-female.png">
                            </div>
                        </div>
                        <!-- If we need pagination -->
                        <div class="swiper-pagination"></div>
                    </div>
                </c:if>

                <c:if test="${login.gender eq 'M'}">
                    <div class="swiper">
                        <!-- Additional required wrapper -->
                        <div class="swiper-wrapper">
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-male.png">
                            </div>
                        </div>
                        <!-- If we need pagination -->
                        <div class="swiper-pagination"></div>
                    </div>
                </c:if>

                <c:if test="${login.gender eq 'F'}">
                    <div class="swiper">
                        <!-- Additional required wrapper -->
                        <div class="swiper-wrapper">
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class="clothes-img"
                                    src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-female.png">
                            </div>
                        </div>
                        <!-- If we need pagination -->
                        <div class="swiper-pagination"></div>
                    </div>
                </c:if>

            </div>
        </div>

        <!-- 검색창 영역 -->
        <div class="search-section">
            <h2 class="main-title">WEATHER SEARCH</h2>

            <form action="#">
                <select name="h_area1" onChange="cat1_change(this.value,h_area2)" class="h_area1"
                    style="font-family:'SejonghospitalBold';font-size:13;letter-spacing:1;">
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
                <select name="h_area2" style="font-family:'SejonghospitalBold';font-size:13;letter-spacing:1;">
                    <option>시,군,구를 선택하세요</option>
                </select>
                <button id="send-btn" class="btn btn-primary" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>

        <div class="board-section">
            <h2 class="main-title">BEST OOTD</h2>
            <button id="add-btn">더 보기</button>
        </div>



        <!-- BEST OOTD 게시판 영역 -->
        <!-- 카드 시작 -->
        <div class="card-container">
            <!-- 카드 복사 -->
            <c:forEach var="b" items="${bList}">
                <div class="card-wrapper box">
                    <section class="card select-card" data-bno="${b.boardNo}" data-email="${login.email}">
                        <div class="card-title-wrapper">
                            <div class="profile-box">
                                <img src="${b.profileImage}" alt="프사">
                            </div>
                            <span class="card-account">${b.nickname}</span>
                            <c:if test="${login.email == b.email || login.auth == 'ADMIN'}"><button
                                    class="board-del-btn" type="button">삭제</button>
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

        <!-- 모달 열기 버튼 -->
        <button id="modalBtn" hidden>모달 글 확대</button>

        <!-- 모달 컨테이너 -->
        <div id="myModal" class="modal" data-email="${login.email}">
            <!-- 모달 컨텐츠 -->
            <div class="modal-content">



                <div class="card-wrapper" data-email="${login.email}">



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

                                <form id="commentFrm" class="write-reply">
                                    <div class="write-wrapper">
                                        <input name="nickname" class="nickname" value="${login.nickname}"
                                            hidden></input>
                                        <input name="email" class="email" value="${login.email}" hidden></input>
                                        <c:if test="${login != ''}">
                                            <input name="content" class="write-input"
                                                placeholder="여기는 댓글 입력창입니다."></input>
                                        </c:if>
                                        <c:if test="${login == ''}">
                                            <input name="content" class="write-input" placeholder="여기는 댓글 입력창입니다."
                                                readonly></input>
                                        </c:if>
                                        <button class="write-send" type="button">등록</button>
                                    </div>
                                </form>
                            </div>

                        </div>

                    </section>
                </div>
            </div>
        </div>
    </div>


    <%@include file="../include/footer.jsp"%>
</body>

</html>