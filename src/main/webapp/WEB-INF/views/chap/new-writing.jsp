<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <title>Today's weather, oh-nal</title>
  <%@include file="../include/static-head.jsp"%>
  <link rel="stylesheet" href="/assets/css/new-writing.css">
  <script src="/assets/js/new-writing.js" defer></script>
  

</head>

<body>
  <%@include file="../include/header.jsp"%>

  <form class="new-writing-wrapper" action="/board/write" method="post" enctype="multipart/form-data">

    <div class="image_container cody-load">
      <div class="btn_image">
        <label for="img">
          <img id="img" src="/assets/img/upload.png" alt="이미지 미리보기">
        </label>
      </div>
      <input type="file" id="selectFile" name="image" accept="image/*" style="display: none;"  required>
    </div>

    <div class="user-info">
      <div>

        <div class="profile-name">
          <div class="profile-box">
            <img src="${login.profile}" alt="프사">
          </div>
          <input type="text" value="${login.nickname}" readonly>
        </div>

        <div class="hash">
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
              <select name="h_area2" class="h_area2">
                <option>시,군,구를 선택하세요</option>
              </select>
              <input type="text" name="valueArea1" id="valueArea1" hidden>
              <input type="text" name="valueArea2" id="valueArea2" hidden>
        </div>

      </div>

      <div class="write-content1">
        <!-- <label class="write-input" placeholder="게시글 문구를 입력해주세요."></label> -->
        <textarea class="write-input" id="content" name="content" maxlength="200" required placeholder=" 게시물 문구를 작성해주세요."></textarea>
        <button class="btn" type="submit">등록</button>
      </div>
    </div>

  </form>


  <%@include file="../include/footer.jsp"%>
  <script>
    // 날씨 옵션 메뉴 제공하는 JS
    var cat1_num = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
    var cat1_name = new Array('서울', '부산', '대구', '인천', '광주', '대전', '울산', '강원', '경기', '경남', '경북', '전남', '전북', '제주', '충남', '충북');
    var cat2_num = new Array();
    var cat2_name = new Array();
    cat2_num[1] = new Array(17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41);
    cat2_name[1] = new Array('강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구');
    cat2_num[2] = new Array(42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57);
    cat2_name[2] = new Array('강서구', '금정구', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구', '기장군');
    cat2_num[3] = new Array(58, 59, 60, 61, 62, 63, 64, 65);
    cat2_name[3] = new Array('남구', '달서구', '동구', '북구', '서구', '수성구', '중구', '달성군');
    cat2_num[4] = new Array(66, 67, 68, 69, 70, 71, 72, 73, 74);
    cat2_name[4] = new Array('계양구', '남동구', '동구', '부평구', '서구', '연수구', '중구', '강화군', '옹진군');
    cat2_num[5] = new Array(75, 76, 77, 78, 79);
    cat2_name[5] = new Array('광산구', '남구', '동구', '북구', '서구');
    cat2_num[6] = new Array(80, 81, 82, 83, 84);
    cat2_name[6] = new Array('대덕구', '동구', '서구', '유성구', '중구');
    cat2_num[7] = new Array(85, 86, 87, 88, 89);
    cat2_name[7] = new Array('남구', '동구', '북구', '중구', '울주군');
    cat2_num[8] = new Array(90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107);
    cat2_name[8] = new Array('강릉시', '동해시', '삼척시', '속초시', '원주시', '춘천시', '태백시', '고성군', '양구군', '양양군', '영월군', '인제군', '정선군', '철원군', '평창군', '홍천군', '화천군', '횡성군');
    cat2_num[9] = new Array(108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143);
    cat2_name[9] = new Array('고양시 덕양구', '과천시', '광명시', '광주시', '구리시', '군포시', '김포시', '남양주시', '동두천시', '부천시 소사구', '부천시 오정구', '부천시 원미구', '성남시 분당구', '성남시 수정구', '성남시 중원구', '수원시 권선구', '수원시 장안구', '수원시 팔달구', '시흥시', '안산시 단원구', '안산시 상록구', '안성시', '안양시 동안구', '안양시 만안구', '오산시', '용인시', '의왕시', '의정부시', '이천시', '파주시', '평택시', '하남시', '화성시', '가평군', '양평군', '연천군');
    cat2_num[10] = new Array(144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161);
    cat2_name[10] = new Array('거제시', '김해시', '밀양시', '사천시', '양산시', '진주시', '창원시', '통영시', '거창군', '고성군', '남해군', '산청군', '의령군', '창녕군', '하동군', '함안군', '함양군', '합천군');
    cat2_num[11] = new Array(162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184);
    cat2_name[11] = new Array('경산시', '경주시', '구미시', '김천시', '문경시', '상주시', '안동시', '영주시', '영천시', '포항시 남구', '포항시 북구', '고령군', '봉화군', '성주군', '영덕군', '영양군', '예천군', '울릉군', '울진군', '의성군', '청도군', '청송군', '칠곡군');
    cat2_num[12] = new Array(185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206);
    cat2_name[12] = new Array('광양시', '나주시', '목포시', '순천시', '여수시', '강진군', '고흥군', '곡성군', '구례군', '담양군', '무안군', '보성군', '신안군', '영광군', '영암군', '완도군', '장성군', '장흥군', '진도군', '함평군', '해남군', '화순군');
    cat2_num[13] = new Array(207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221);
    cat2_name[13] = new Array('군산시', '김제시', '남원시', '익산시', '전주시 덕진구', '전주시 완산구', '정읍시', '고창군', '무주군', '부안군', '순창군', '완주군', '임실군', '장수군', '진안군');
    cat2_num[14] = new Array(222, 223);
    cat2_name[14] = new Array('서귀포시', '제주시');
    cat2_num[15] = new Array(224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236);
    cat2_name[15] = new Array('공주시', '논산시', '보령시', '서산시', '아산시', '천안시', '금산군', '부여군', '서천군', '예산군', '청양군', '태안군', '홍성군');
    cat2_num[16] = new Array(237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247);
    cat2_name[16] = new Array('제천시', '청주시 상당구', '청주시 흥덕구', '충주시', '괴산군', '단양군', '보은군', '영동군', '옥천군', '음성군', '진천군');
    function cat1_change(key, sel) {
      if (key == '') return;
      var name = cat2_name[key];
      var val = cat2_num[key];
      for (i = sel.length - 1; i >= 0; i--)
        sel.options[i] = null;
      sel.options[0] = new Option('시,군,구를 선택하세요', '', '', 'true');
      for (i = 0; i < name.length; i++) {
        sel.options[i + 1] = new Option(name[i], val[i]);
      }
    }

    const $valueArea1 = document.getElementById('valueArea1');
    const $valueArea2 = document.getElementById('valueArea2');
    const $area1 = document.querySelector('.h_area1');
    const $area2 = document.querySelector('.h_area2');
    let targetNum = 0;
    let targetNum2 = 0;

    // 사용자가 선택 안 했을 시 '서울시' '중구'로 기본 세팅
    $valueArea1.setAttribute("value", '서울특별시');
    $valueArea2.setAttribute("value", '중구');

    // 사용자가 직접 select 옵션을 선택했을 시 작동하는 이벤트
    document.querySelector('.h_area2').onchange = () => {
      const $area1 = document.querySelector('select[name=h_area1]');
      const $area2 = document.querySelector('select[name=h_area2]');
      $valueArea1.setAttribute("value", $area1.options[$area1.selectedIndex].textContent);
      // value를 지목하면 숫자가 오므로 option 중 선택된 인텍스의 텍스트값을 가지고 오는 문법을 사용한다.
      $valueArea2.setAttribute("value", $area2.options[$area2.selectedIndex].textContent);
    };

    // login 사용자의 주소 정보가 있을 시 작동하는 코드

    if (${login.address != null}) {
      console.log('사용자의 주소 정보가 있습니다. 주소 정보로 기본 세팅합니다.');

      // 사용자가 설정한 주소를 기본값으로 설정하는 세팅
      const address = '${login.address}';
      console.log(address);
      const area = address.split(" ");
      const area1 = area[0];
      const area2 = area[1];

      // area1 설정하는 로직(주소 API에서 제공하는 주소는 '충북', 우리 DB 주소는 '충청북도'이므로 정규표현식으로 문자열 비교
      let start = area1.charAt(0);
      let middle = area1.charAt(1);

      let pattern = new RegExp("^" + start + ".*" + middle);
      console.log(pattern);

      // select 태그의 모든 option을 순회
      for (let i = 0; i < $area1.options.length; i++) {
        // 현재 option의 textContent
        const optionText = $area1.options[i].textContent;

        // textContent 비교
        if (pattern.test(optionText)) {
          console.log('textContent가 일치하는 option을 찾았습니다: ', $area1.options[i].value);
          console.log('기본으로 세팅될 area1 textContent: ', $area1.options[i].textContent);
          $valueArea1.setAttribute("value", $area1.options[i].textContent); // form에 전송될 area1을 해당 지역명으로 세팅
          $area1.options[i].setAttribute("selected", "selected"); // 사용자가 해당 지역명을 selected된 채로 보도록 세팅
          targetNum = i;
          break; // 찾았으면 반복문 종료
        }
      }

      // area2 설정하는 로직
      // area1이 설정되었을 시 area2를 얻기 위한 배열 순회
      for (let i = 0; i < cat2_name[targetNum].length; i++) {

        if (cat2_name[targetNum][i] === area2) { // 사용자가 주소 설정한 area2와 select 옵션들을 비교
          console.log('지역2가 배열의 몇 번째에 있나요?' + i + '번째 인덱스에 있습니다');
          targetNum2 = i;
          break; // 찾았으면 반복문 종료
        }
      }

      console.log('첫번째 targetNum은 '+ targetNum);
      console.log('두번째 targetNum은 '+ targetNum2)
      setDefault(targetNum, targetNum2, $area2);
    } else {
      console.log('주소가 없는 경우 서울시 중구를 기본으로 설정합니다');
      // 서울시는 첫번째 select의 1번 인덱스, 중구는 두번째 select의 23번 인덱스이기 때문에 함수에 1, 23을 대입
      $area1.options[1].setAttribute("selected", "selected");
      setDefault(1, 23, $area2);
    }

    function setDefault(key, targetNum2, sel) {
      console.log('setDefault 호출됨!')
      if (key == '') return;
      var name = cat2_name[key];
      var val = cat2_num[key];
      for (i = sel.length - 1; i >= 0; i--)
        sel.options[i] = null;
      sel.options[0] = new Option('시,군,구를 선택하세요', '', '', 'true');
      for (i = 0; i < name.length; i++) {
        sel.options[i + 1] = new Option(name[i], val[i]);
        if(i === targetNum2) { // targetNum2을 바꾸면 원하는 것으로 selected가 된다.
          sel.options[i+1].selected = true;
          console.log('기본으로 세팅될 area2 textContent: ', sel.options[i+1].textContent);
          $valueArea2.setAttribute("value", sel.options[i+1].textContent);
          break;
        }
      }
    }

  </script>

</body>

</html>