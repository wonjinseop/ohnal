// HTML 문서의 로딩이 완료되었을 때, 해당 함수를 실행
document.addEventListener("DOMContentLoaded", function () {
  // elements
  var modalBtn = document.getElementById("modalBtn");
  var modal = document.getElementById("myModal");
  var closeBtn = document.getElementById("closeBtn");


  // functions
  function toggleModal() {
    modal.classList.toggle("show");
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


// card-container /card-wrapper/ data-bno="${b.boardNo}
//게시물 클릭시 modal창 열리는 이벤트 발생, 클릭한 게시물 내용 모달창에 넣는 기능

const $cardContainer = document.querySelector('.card-container');
const URL1 = '/board/detail/';

$cardContainer.onclick = e => {
  const $card = e.target.closest('.select-card');
  if ($card) {
    const bno = $card.dataset.bno;
    console.log(bno);
    fetch(URL1 + bno)
      .then(res => res.json())
      .then(data => {
        console.log(data);
        document.querySelector('.modal .card').dataset.bno = bno;
        document.querySelector('.modal .card-account').textContent = data.nickname;
        document.querySelector('.modal .content').textContent = data.content;
        document.querySelector('.modal .content-img').setAttribute('src', data.image);
        document.querySelector('.modal .like-count').textContent = '좋아요 ' + data.likeCount + '개';
        document.querySelector('.modal .reply-count').textContent = '댓글 ' + data.replyCount + '개';
        document.querySelector('.modal .view-count').textContent = '조회수 ' + data.viewCount + '회';
        document.querySelector('.modal .location').textContent = data.locationTag;
        document.querySelector('.modal .weather').textContent = data.weatherTag;
        document.querySelector('.modal .time-stamp').textContent = data.regDate;


      })

    document.getElementById('modalBtn').click();
    fetchGetReplies(bno);

  }

};



//bno /  email nick prof reply-content reply-num regdate
//댓글 내용 불러오는 함수

/* <div class="reply-wrapper">
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
</div> */


function fetchGetReplies(bno) {
  console.log('응답');
  const $replys = document.querySelector('.replys')
  const URL1 = '/board/reply/';
  fetch(URL1 + bno)
    .then(res => res.json())
    .then(replyList => {
      console.log(replyList);
      renderReplies(replyList);
    });
  
};

function renderReplies(replyList) {
  
  let tag = '';

  if (replyList !== null && replyList.length > 0) {
    
    for (let reply of replyList) {

      const {replyNo, email, content, profileImage, nickname, time} = reply

      tag += `
      <div class="reply-wrapper">
      <span class="card-account" data-email="\${email}"><img src="\${profileImage}">\${nickname}</span>
        <p class="reply" data-no="\${replyNo}">
            \${content}
        </p>
      <!-- <input type="text" hidden> -->
      </div>

      <div class="reply-data">
        <span>\${time}</span>
        <button id="comments-modify">수정</button>
        <button>삭제</button>
      </div>
      `

    }

  } else {
    tag += "<div id='replyContent' class='card-body'>댓글이 아직 없습니다! ㅠㅠ</div>";
  }

// var btn = document.getElementById("like")

//   btn.addEventListener('click',function(){
//             btn.classList.toggle('active')
//     })

  $replys.innerHTML = tag;

}





document.addEventListener('DOMContentLoaded', function() {
  // 버튼 요소 선택
  var submitButton = document.querySelector('.write-send');

  // 버튼 클릭 이벤트 핸들러 등록
  submitButton.addEventListener('click', function() {
      // 입력 필드 선택
      var inputField = document.querySelector('.write-input');

      console.log(inputField.value);

      // 입력 필드의 값 비우기
      inputField.value = '';
  });
});



