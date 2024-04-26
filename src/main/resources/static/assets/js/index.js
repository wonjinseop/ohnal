// 사용자의 위치를 (자동으로) 가져오기

// 사용자의 위치(위도, 경도)를 가져올 변수 선언 및 초기화
// navigator.geolocation 객체 사용 가능 여부 확인
if("geolocation" in navigator) {
  // 브라우저가 지원한다면
  // console.log('success');
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

// BEST OOTD JS
// HTML 문서의 로딩이 완료되었을 때, 해당 함수를 실행
document.addEventListener("DOMContentLoaded", function () {
  // elements
  var modalBtn = document.getElementById("modalBtn");
  var modal = document.getElementById("myModal");
  var closeBtn = document.getElementById("closeBtn");

  // functions
  function toggleModal() {
    modal.classList.toggle("show");
    document.body.style.overflow = 'auto';
  }

  // events
  modalBtn.addEventListener("click", toggleModal);
  closeBtn.addEventListener("click", toggleModal);

  window.addEventListener("click", function (event) {
    // 모달의 검은색 배경 부분이 클릭된 경우 닫히도록 하는 코드
    if (event.target === modal) {
      toggleModal();
    }
  });
});

//게시물 클릭시 modal창 열리는 이벤트 발생, 클릭한 게시물 내용 모달창에 넣는 기능
const $cardContainer = document.querySelector('.card-container');

$cardContainer.onclick = e => {

  const $card = e.target.closest('.select-card');
  if ($card) {
    const $likeEmail = $card.dataset.email;
    const bno = $card.dataset.bno;
    const $like = e.target.closest('.like-icon');

    const $wrapper = $card.querySelector('.icon-wrapper');
    const $likeIcon = $wrapper.querySelector('.like-icon');
    const $likeImg = $likeIcon.querySelector('img');

    const src = $likeImg.getAttribute('src');

    const URL = '/board/detail/' + bno;
    if ($like) {
      toggleHeart($likeEmail, $like, bno);
    } else {

      if (e.target.matches('button')) {
        console.log("button click!");

        fetch('/board/delete/' + bno)
            .then(() => {
              document.getElementById('submitBtn').click();
            });
      } else {

        console.log(bno);
        fetch(URL)
            .then(res => res.json())
            .then(data => {
              const $heart = document.querySelector('.modal .heart');
              console.log(data);
              document.querySelector('.modal .card').dataset.bno = bno;
              document.querySelector('.modal .card-account').textContent = data.nickname;
              document.querySelector('.modal .content').textContent = data.content;
              document.querySelector('.modal .content-img').setAttribute('src', '/display' + data.image);
              document.querySelector('.modal .like-count').textContent = '좋아요 ' + data.likeCount + '개';
              document.querySelector('.modal .reply-count').textContent = '댓글 ' + data.replyCount + '개';
              document.querySelector('.modal .view-count').textContent = '조회수 ' + data.viewCount + '회';
              document.querySelector('.modal .location').textContent = data.locationTag;
              document.querySelector('.modal .weather').textContent = data.weatherTag;
              document.querySelector('.modal .time-stamp').textContent = data.regDate;
              document.querySelector('.modal .profile-image').setAttribute('src', data.profileImage);
              $heart.setAttribute('src', src);
              $heart.setAttribute('data-email', $likeEmail)

              document.body.style.overflow = 'hidden';

            });
      }

      document.getElementById('modalBtn').click();
      fetchGetReplies(bno);

    };

    document.querySelector('.modal .heart').onclick = e => {
      const $likeEmail = e.target.dataset.email;
      const $liked = e.target;
      detailToggleHeart($likeEmail, $liked, $likeImg, bno);
    }
  };
};

function toggleHeart(likeEmail, $like, bno) {
  like(likeEmail, bno);
  console.log(likeEmail);
  console.log($like);
  if (likeEmail !== '') {
    const likeIcon = $like.querySelector('img');
    if (likeIcon.getAttribute('src').endsWith('fill-heart.svg')) {
      likeIcon.setAttribute('src', '/assets/img/heart.svg');
    } else {
      likeIcon.setAttribute('src', '/assets/img/fill-heart.svg');
    };

  };
}

function detailToggleHeart(likeEmail, $like, likeImg, bno) {
  like(likeEmail, bno);
  console.log(likeEmail);
  console.log($like);
  if (likeEmail !== '') {
    if ($like.getAttribute('src').endsWith('fill-heart.svg')) {
      $like.setAttribute('src', '/assets/img/heart.svg');
      likeImg.setAttribute('src', '/assets/img/heart.svg');
    } else {
      $like.setAttribute('src', '/assets/img/fill-heart.svg');
      likeImg.setAttribute('src', '/assets/img/fill-heart.svg');
    };
  };

}

function like(email, bno) {

  const URL = '/board/like';

  const payLoad = {
    email: email,
    bno: bno
  };

  console.log(payLoad);

  const requestInfo = {
    method: 'POST',
    headers: {
      'content-type': 'application/json'
    },
    body: JSON.stringify(payLoad)
  };

  fetch(URL, requestInfo)
      .then(res => console.log(res));

};











//bno /  email nick prof reply-content reply-num regdate
//댓글 내용 불러오는 함수
function fetchGetReplies(bno) {
  console.log('응답');
  const URL = '/board/reply/';
  fetch(URL + bno)
      .then(res => res.json())
      .then(replyList => {
        // console.log(replyList);
        renderReplies(replyList);
      });

}

function renderReplies(replyList) {
  const $replyWrapper = document.querySelector('.reply-wrapper')
  let tag = '';

  if (replyList !== null && replyList.length > 0) {

    for (let reply of replyList) {

      // console.log(reply);

      const {
        replyNo,
        email,
        content,
        profileImage,
        nickname,
        time
      } = reply
      console.log(profileImage);
      tag += `
        <span class='card-account' data-email='${email}'><img src='${profileImage}' class='profile-img'>${nickname}</span>
        <p class='reply' data-no='${replyNo}'>
            ${content}
        </p>
        <!-- <input type='text' hidden> -->


        <div class='reply-data'>
          <span class='time'>${time}</span>
          <button class="reply-modify" data-reply-no="${replyNo}">수정</button>
          <button class="reply-delete" data-reply-no="${replyNo}">삭제</button>
        </div>
      `;

    }

  } else {
    tag += "<div id='replyContent' class='card-body'>댓글이 아직 없습니다! ㅠㅠ</div>";
  }
  $replyWrapper.innerHTML = tag;

}


// 버튼 요소 선택
var submitButton = document.querySelector('.write-send');

// 버튼 클릭 이벤트 핸들러 등록
submitButton.addEventListener('click', function () {
  const boardNo = document.querySelector('.modal .card').dataset.bno;

  // 입력 필드 선택
  const inputField = document.querySelector('.write-input');
  const content = inputField.value.trim();
  const nickname = document.querySelector('.nickname').value;
  const email = document.querySelector('.email').value;
  const URL = '/board/reply'

  console.log(boardNo);
  console.log(inputField.value);

  // 사용자 입력자 검증
  if (content === '') {
    alert('댓글 내용은 필수값입니다!!');
    return;
  };

  console.log(email);
  console.log(nickname);

  const payLoad = {
    text: content,
    bno: boardNo,
    nickname: nickname,
    email: email
  };

  // 요청 방식 및 데이터를 전달할 정보 객체 만들기 (POST)
  const requestInfo = {
    method: 'POST',
    headers: {
      'content-type': 'application/json'
    },
    body: JSON.stringify(payLoad) // js 객체를 JSON으로 변환해서 body에 추가
  };

  // 서버에 POST 요청 보내기
  fetch(URL, requestInfo)
      .then(res => {
        console.log(res.status);

        if (res.status === 200) {
          return res.text();
        } else {
          alert('입력값에 문제가 있습니다! 입력값을 다시 확인해 보세요!');
          return res.text();
        };

      })
      .then(data => {
        // console.log('응답 성공! ', data);

        // 입력 필드의 값 비우기
        inputField.value = '';

        // 댓글 목록 비동기 요청
        fetchGetReplies(boardNo);
      });

});