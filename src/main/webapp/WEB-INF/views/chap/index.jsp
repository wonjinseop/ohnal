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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</head>

<body>
    <%@include file="../include/header.jsp"%>

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
                                    <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-female.png">
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
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-male.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-male.png">
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
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-0-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-1-female.png">
                            </div>
                            <div class="right-down swiper-slide" data-swiper-autoplay="3000">
                                <img class = "clothes-img" src="/assets/img/clothes-image/range_code_${dto.styleImage}/${dto.styleImage}-2-female.png">
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
                <select name="h_area2">
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

        <!-- 카드 복붙 -->
        <div class="card-container">

            <div class="card-wrapper">
                <section class="card" data-bno="${b.boardNo}">
                    <div class="card-title-wrapper">
                        <div class="profile-box">
                            <img src="./assets/img/anonymous.jpg" alt="프사">
                        </div>
                        <span class="card-account">test3</span>
                    </div>

                    <div class="card-picture">
                        <img src="./assets/img/cody.png" alt="sample">
                    </div>

                    <div class="icon-wrapper">
                        <div class="like-icon">
                            <span class="lnr lnr-heart"></span>
                        </div>
                        <span class="hashtag">#서울시강남구</span>
                        <span class="hashtag">#최저12최고25</span>
                        <div class="reply-icon">
                            <!-- <span class="lnr lnr-bubble"></span> -->
                        </div>
                    </div>
                    <hr>
                    <div class="content-wrapper">
                        <p><span>좋아요 598개</span>&nbsp&nbsp&nbsp<span>댓글 30개</span></p>
                        <p><span class="card-account">test3</span> 일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아</p>
                        <a href="#">
                            <p>... 더 보기</p>
                        </a>
                    </div>
                </section>
            </div>

            <!-- 카드 복붙 -->
            <div class="card-wrapper">
                <section class="card" data-bno="${b.boardNo}">
                    <div class="card-title-wrapper">
                        <div class="profile-box">
                            <img src="/assets/img/anonymous.jpg" alt="프사">
                        </div>
                        <span class="card-account">test3</span>
                    </div>

                    <div class="card-picture">
                        <img src="./assets/img/cody.png" alt="sample">
                    </div>

                    <div class="icon-wrapper">
                        <div class="like-icon">
                            <span class="lnr lnr-heart"></span>
                        </div>
                        <span class="hashtag">#서울시강남구</span>
                        <span class="hashtag">#최저12최고25</span>
                        <div class="reply-icon">
                            <!-- <span class="lnr lnr-bubble"></span> -->
                        </div>
                    </div>
                    <hr>
                    <div class="content-wrapper">
                        <p><span>좋아요 598개</span>&nbsp&nbsp&nbsp<span>댓글 30개</span></p>
                        <p><span class="card-account">test3</span> 일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아</p>
                        <a href="#">
                            <p>... 더 보기</p>
                        </a>
                    </div>
                </section>
            </div>

            <!-- 카드 복붙 -->
            <div class="card-wrapper">
                <section class="card" data-bno="${b.boardNo}">
                    <div class="card-title-wrapper">
                        <div class="profile-box">
                            <img src="/assets/img/anonymous.jpg" alt="프사">
                        </div>
                        <span c lass="card-account">test3</span>
                    </div>

                    <div class="card-picture">
                        <img src="./assets/img/cody.png" alt="sample">
                    </div>

                    <div class="icon-wrapper">
                        <div class="like-icon">
                            <span class="lnr lnr-heart"></span>
                        </div>
                        <span class="hashtag">#서울시강남구</span>
                        <span class="hashtag">#최저12최고25</span>
                        <div class="reply-icon">
                            <!-- <span class="lnr lnr-bubble"></span> -->
                        </div>
                    </div>
                    <hr>
                    <div class="content-wrapper">
                        <p><span>좋아요 598개</span>&nbsp&nbsp&nbsp<span>댓글 30개</span></p>
                        <p><span class="card-account">test3</span> 일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아</p>
                        <a href="#">
                            <p>... 더 보기</p>
                        </a>
                    </div>
                </section>
            </div>

            <!-- 카드 복붙 -->
            <div class="card-wrapper">
                <section class="card" data-bno="${b.boardNo}">
                    <div class="card-title-wrapper">
                        <div class="profile-box">
                            <img src="/assets/img/anonymous.jpg" alt="프사">
                        </div>
                        <span class="card-account">test3</span>
                    </div>

                    <div class="card-picture">
                        <img src="./assets/img/cody.png" alt="sample">
                    </div>

                    <div class="icon-wrapper">
                        <div class="like-icon">
                            <span class="lnr lnr-heart"></span>
                        </div>
                        <span class="hashtag">#서울시강남구</span>
                        <span class="hashtag">#최저12최고25</span>
                        <div class="reply-icon">
                            <!-- <span class="lnr lnr-bubble"></span> -->
                        </div>
                    </div>
                    <hr>
                    <div class="content-wrapper">
                        <p><span>좋아요 598개</span>&nbsp&nbsp&nbsp<span>댓글 30개</span></p>

                        <p><span class="card-account">test3</span> 일교차가 클 땐 아우터를 가볍게 걸치는 게 좋아</p>
                        <a href="#">
                            <p>... 더 보기</p>
                        </a>
                    </div>
                </section>
            </div>
        </div>
    </div>


    <%@include file="../include/footer.jsp"%>

    <script>
        // 사용자의 위치를 (자동으로) 가져오기
        
        // 사용자의 위치(위도, 경도)를 가져올 변수 선언 및 초기화
        // navigator.geolocation 객체 사용 가능 여부 확인
        if("geolocation" in navigator) {
            // 브라우저가 지원한다면
            console.log('success');
            // 콘솔창에 success 출력되어 navigator.geolocation 객체를 사용해서 사용자의 위치를 가져오겠습니다.
        } else {
            console.log(fail);
        }

        navigator.geolocation.getCurrentPosition(function(permitPosition) {
            console.log(permit);
            var latitude = permitPosition.coords.latitude; // 위도
            var longitude = permitPosition.coords.longitude; // 경도
            console.log("현재 위치는 : " + latitude + ", "+ longitude);
        });

        // swiper 함수
        const swiper = new Swiper('.swiper', {
            // Optional parameters
            direction: 'horizontal',
            loop: true,

            // If we need pagination
            pagination: {
                el: '.swiper-pagination',
            },

            // Navigation arrows
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },

            // And if we need scrollbar
            scrollbar: {
                el: '.swiper-scrollbar',
            },
        });
        swiper.autoplay.start();





    </script>
</body>
</html>