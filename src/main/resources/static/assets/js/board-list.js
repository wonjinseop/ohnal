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

const $cardContainer = document.querySelector('.card-container');
const URL1 = '/board/detail';

$cardContainer.onclick = e => {
  const $card = e.target.closest('.select-card');
  if ($card) {
    const bno = $card.dataset.bno;
    console.log(bno);
    fetch(URL1 + '/' + bno)
      .then(res => res.json())
      .then(data => {
        console.log(data);
        document.querySelector('.modal .card').dataset.bno = bno;
        document.querySelector('.modal .card-account1').value = data.nickname;
        document.querySelector('.modal .card-account2').value = data.nickname;
        document.querySelector('.modal .content').value = data.content;
        document.querySelector('.modal .content-img').setAttribute('src', data.image);
        document.querySelector('.modal .like-count').value = data.likeCount;
        document.querySelector('.modal .reply-count').value = data.replyCount;
        document.querySelector('.modal .view-count').value = data.viewCount;
        document.querySelector('.modal .location').value = data.locationTag;
        document.querySelector('.modal .weather').value = data.weatherTag;
        document.querySelector('.modal .time-stamp').value = data.regDate;
      })

    document.getElementById('modalBtn').click();
  }
  
};





