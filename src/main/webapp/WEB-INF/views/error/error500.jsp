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
    height: 905px;
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
    left: 94px;
    top: 105px;
    text-decoration: none;
    letter-spacing: -1px;
    font-family: 'WagleWagle';
    font-size: 81px;
    color: cornsilk;

}
    
    
        </style>
    <title>Document</title>
    
</head>
<body>
    <div class="catbox"><img src="./cat.jpg" alt="cat" class="cat"></div>
   <div class="container">
    <p class="text">I'm Sorry! <br> 다시 한번 시도해주세요</p>
    <a href="http://localhost:8282/index" class="alink">메인페이지 이동</a>
</div>
 </body>
</html>