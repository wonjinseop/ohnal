// 체크박스 요소를 가져옴
var autoLoginCheckbox = document.getElementById('auto-login');

// 페이지가 로드될 때 저장된 값이 있는지 확인하고, 있으면 해당 값으로 체크박스 상태 설정
document.addEventListener("DOMContentLoaded", function() {
    var autoLoginChecked = localStorage.getItem("autoLoginChecked");

    // 저장된 값이 true이면 체크박스를 체크된 상태로 설정
    if (autoLoginChecked === "true") {
        autoLoginCheckbox.checked = true;
    }
});

// 체크박스 클릭 시 상태를 로컬 스토리지에 저장
autoLoginCheckbox.addEventListener("click", function() {
    localStorage.setItem("autoLoginChecked", autoLoginCheckbox.checked);
});
