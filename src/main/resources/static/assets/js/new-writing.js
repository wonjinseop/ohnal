const $image = document.getElementById('imagePreview');
const $profile_btn = document.querySelector('.btn_image')
const $fileInput = document.getElementById('selectFile');

$profile_btn.onclick = e => {
  $fileInput.click();
}

$fileInput.onchange = e => {
  const fileData = $fileInput.files[0];
  const reader = new FileReader();

  reader.readAsDataURL(fileData);

  reader.onloadend = () => {
    $image.setAttribute('src', reader.result);
  }
}