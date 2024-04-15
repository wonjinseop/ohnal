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



document.addEventListener("DOMContentLoaded", function () {
  // elements
  var modalBtn1 = document.getElementById("modalBtn-1");
  var modal1 = document.getElementById("myModal-1");
  var closeBtn1 = document.getElementById("closeBtn-1");

  // functions
  function toggleModal() {
    modal1.classList.toggle("show");
  }

  // events
  modalBtn1.addEventListener("click", toggleModal);
  closeBtn1.addEventListener("click", toggleModal);

  window.addEventListener("click", function (event) {
    // 모달의 검은색 배경 부분이 클릭된 경우 닫히도록 하는 코드
    if (event.target === modal1) {
      toggleModal();
    }
  });
});



