//버튼의 요소 노드 취득
const menuBtn = document.querySelector('header .menu-open');
const closeBtn = document.querySelector('.gnb .close');

const gnb = document.querySelector('.gnb');


//클릭 이벤트 생성
menuBtn.addEventListener('click', () => {
  gnb.classList.add('on');
});

closeBtn.addEventListener('click', () => {
  gnb.classList.remove('on');
});


// 프로필 사진이나 닉네임 영역 클릭했을 시 my-info 페이지로 이동 이벤트

const $profileBox = document.querySelector('.profile-box');
const $introText = document.querySelector('.intro-text');

$profileBox.onclick = () => {
  location.replace('/members/my-info');
};

$introText.onclick = () => {
  $profileBox.onclick();
}

