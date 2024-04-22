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

console.log('my-history 페이지에 접속 완료')
// 내가 쓴 글 버튼(div)을 누르면 내가 쓴 글 목록이 조회된다.
function getMyPosts() {
    fetch('/members/my-history/' + email)
        .then((response) => response.json())
        .then(data => console.log(data));




}

// 내가 쓴 댓글 버튼(div)을 누르면 내가 쓴 댓글 목록이 모두 조회된다.
function getMyReplyPosts() {
    console.log("내가 쓴 댓글 목록 모두 조회 버튼 눌렀다.");
    fetch('/members/my-history/my-write-reply/' + email)
        .then((response) => response.json())
        .then(data => console.log(data));
}

// 내가 좋아요한 글 버튼(div)을 누르면 내가 좋아요한 글 목록이 조회된다.
function getLikedPosts() {
    console.log("내가 좋아요한 글 목록 모두 조회 버튼 눌렀다.");



}

const $cardContainer = document.querySelector('.card-container');

$cardContainer.onclick = e => {
    const URL = '/board/detail/';
    const $card = e.target.closest('.select-card');
    if ($card) {
        const bno = $card.dataset.bno;
        boardNo = bno;
        console.log(bno);
        fetch(URL + bno)
            .then(res => res.json())
            .then(data => {
                console.log(data);
                document.querySelector('.modal .card').dataset.bno = bno;
                document.querySelector('.modal .card-account').textContent = data.nickname;
                document.querySelector('.modal .content').textContent = data.content;
                document.querySelector('.modal .content-img').setAttribute('src', '/display' + data
                    .image);
                document.querySelector('.modal .like-count').textContent = '좋아요 ' + data.likeCount +
                    '개';
                document.querySelector('.modal .reply-count').textContent = '댓글 ' + data
                    .replyCount + '개';
                document.querySelector('.modal .view-count').textContent = '조회수 ' + data.viewCount +
                    '회';
                document.querySelector('.modal .location').textContent = data.locationTag;
                document.querySelector('.modal .weather').textContent = data.weatherTag;
                document.querySelector('.modal .time-stamp').textContent = data.regDate;
                document.body.style.overflow = 'hidden';

            })

        document.getElementById('modalBtn').click();
        fetchGetReplies(bno);

    }

};

function fetchGetReplies(bno) {
    console.log('응답');
    const URL = '/board/reply/';
    fetch(URL + bno)
        .then(res => res.json())
        .then(replyList => {
            // console.log(replyList);
            renderReplies(replyList);
        });

};


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

            tag += `
                      <span class='card-account' data-email='${email}'><img src='${profileImage}' class='profile-img'>${nickname}</span>
                      <p class='reply' data-no='${replyNo}'>
                          ${content}
                      </p>
                      <!-- <input type='text' hidden> -->
                    
              
                      <div class='reply-data'>
                        <span>${time}</span>
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

    $replyWrapper.innerHTML = tag;

};