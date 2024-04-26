const $img = document.getElementById('img');
const $image = document.getElementById('image');
const $profile_btn = document.querySelector('.btn_image')
const $fileInput = document.getElementById('selectFile');

$profile_btn.onclick = e => {
  $fileInput.click();
};

$fileInput.onchange = e => {
  const fileData = $fileInput.files[0];
  const reader = new FileReader();

  reader.readAsDataURL(fileData);

  reader.onloadend = () => {
    $img.setAttribute('src', reader.result);
  };
};





