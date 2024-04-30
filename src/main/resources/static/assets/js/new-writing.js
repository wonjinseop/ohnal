const $img = document.getElementById('img');
const $image = document.getElementById('image');
const $profile_btn = document.querySelector('.btn_image')
const $fileInput = document.getElementById('selectFile');
const $btn = document.querySelector('.btn');
let src = document.getElementById('img').getAttribute('src');

$profile_btn.onclick = e => {
  $fileInput.click();
};

$fileInput.onchange = e => {
  const fileData = $fileInput.files[0];
  const reader = new FileReader();

  reader.readAsDataURL(fileData);
  src = reader.result;

  reader.onloadend = () => {
    $img.setAttribute('src', reader.result);
  };
};

$btn.onclick = () => {
  if (src === '/assets/img/upload.png') {
    alert('이미지를 선택해 주세요');
  }
}



