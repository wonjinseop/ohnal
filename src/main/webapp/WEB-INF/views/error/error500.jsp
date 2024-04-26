<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <title>Today's weather, oh-nal</title>
    <meta charset="UTF-8">
    
    <style>

    @font-face {
    font-family: 'WagleWagle';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2301-wagle@1.0/WagleWagle.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'TAEBAEKmilkyway';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2310@1.0/TAEBAEKmilkyway.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

        body{
            width: 100%;
            height: 100%;
            font-family: 'TAEBAEKmilkyway';
        }
        
    
    .cat {
        width: 100%;
        height: 1022px;
    }
    .container{
        float: left;
    position: absolute;
    left: 748px;
    top: 74px;
    font-size: 50px;
    color: white;
    text-align: center;
    letter-spacing: 10px;
    }
    .alink {
     float: left;
    position: relative;
    left: 171px;
    top: 140px;
    text-decoration: none;
    letter-spacing: -1px;
    font-family: 'WagleWagle';
    font-size: 81px;
    color: cornsilk;
    animation: shine 0.4s infinite alternate;

}
@keyframes shine {
            from {
                text-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
            }
            to {
                text-shadow: 0 4px 16px rgba(0, 0, 0, 0.8), 0 0 8px rgba(255, 255, 255, 0.8);
            }
        }
    
    
        </style>
    <title>Document</title>
    
</head>
<body>
    <div class="catbox"><img src="/assets/img/cat.jpg" alt="cat" class="cat"></div>
   <div class="container">
    <p class="text">I'm Sorry! <br> 다시 한번 시도해주세요</p>
    <a href="http://localhost:8282/index" class="alink">메인페이지 이동</a>
</div>
 </body>
</html>