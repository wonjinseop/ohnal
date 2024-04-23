<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <style>
    html, body {
      background-color: white;
      width: 100%;
      height: 100%;
      overflow: hidden;
    }
    
#bear {
  width: 300px;
  height: 300px;
  
}
.gom {
  width: 400px;
    height: 550px;
    position: absolute;
    float: inline-start;
    left: 187px;
    top: 194px;
    opacity: 0.9;
    border-radius: 78%;
}

.container {
  display: flex;
    width: 800px;
    height: 682px;
    justify-content: center;
    align-items: center;
    position: absolute;
    left: 429px;
    top: -8px;
}


.message-container {
  flex-shrink: 1;
    height: 400px;
    width: 500px;
    display: flex;
    justify-content: center;
    align-items: center;
    padding-right: 5%;
}


.message-container::before {
  content: "";
  top: 50%;
  left: 1em;
  border: 1em solid transparent;
  border-right: 1em solid rgb(211 118 208 / 90%);
  z-index: 0;
}

.message-box {
  display: flex;
  position: relative;
  width: 100%;
  height: 60%;
  justify-content: center;
  align-items: center;
  background: rgb(211 118 208 / 90%);
  border-radius: 15px;
  padding-left: 1.8em;
  padding-right: 1.8em;
  font-family:'YEONGJUSeonbiTTF' ;
  opacity: 0.9;
    font-size: 57px;
    color: #e7acdd;
    text-shadow: 0 2px 3px rgba(0, 0, 0, 0.5);
    animation: shine 1s infinite alternate;
}

.message-box p {
  font-size: 34px;
    color: white;
    text-align: center;
}

.message-box-next {
  position: absolute;
  right: 0;
  padding-right: 1em;
} 

.message-box-next p {
  font-size: 27px;
  color: white;
}


@keyframes shine {
            from {
                text-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
            }
            to {
                text-shadow: 0 4px 16px rgba(0, 0, 0, 0.8), 0 0 8px rgba(255, 255, 255, 0.8);
            }
        }

 @font-face {
    font-family: 'YEONGJUSeonbiTTF';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/2403@1.0/YEONGJUSeonbiTTF.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
    
  </style>
</head>
<body>
  <canvas></canvas>
  <div id="bear"><img class="gom" src="./bear.jpg" alt="곰"></div>
  <script type="text/javascript" src="./errorpage.js"></script>

  <div class="container">
    <div class="message-container">
      <div class='message-box'>
        <p>이 페이지는<br> 아직 준비중 입니다 <br>죄송합니다</p>
      </div>
    </div>
  </div>

</body>
</html>