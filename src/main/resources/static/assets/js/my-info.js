const checkResultList = [true, true, true]; // 0 - 닉네임 중복, 1,2 - 비밀번호 변경 시 결과 확인

// 수정하기 버튼 누르면 수정 모드로 전환하기
document.getElementById('submit_button').onclick = e => {
    const $form = document.getElementById('modify-info');
    const $submit = document.getElementById('submit_button'); // 수정하기 버튼
    const $before = document.querySelector('.inner-before'); // 수정하기 전 사용자 정보 화면
    const $modify = document.querySelector('.inner-change'); // 사용자가 수정할 수 있는 화면

    if ($submit.textContent === "수정하기") {
        $submit.textContent = "수정 완료";
        $before.setAttribute("style", "display:none");
        $modify.removeAttribute("style");
        return;
    }
    console.log($submit.textContent);

    if (e.textContent !== "수정 완료") {
        if (checkResultList.includes(false)) {
            alert('입력란을 다시 확인해주세요');
        } else {
            $form.submit();
            alert('정보 수정이 완료되었습니다! 다시 로그인해주세요.');
        }
    }
}

// 프로필 사진 변경 버튼
const $image = document.getElementById('image-preview');
const $profile_btn = document.querySelector('.btn_image')
const $fileInput = document.getElementById('profileImage');

$profile_btn.onclick = e => {
    $fileInput.click();
}

$fileInput.onchange = e => {
    const fileData = $fileInput.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(fileData);

    reader.onloadend = e => {
        $image.setAttribute('src', reader.result);
    }
}

// 수정 모드에서 닉네임 수정하고 중복확인 처리
    const $nickInput = document.getElementById('nick');
    const $duplicationCheck = document.getElementById('nickname-check');
    const nickPattern = /^[a-zA-Z가-힣]{2,}$/;
    const originNick = $nickInput.value.trim();

    $duplicationCheck.addEventListener('click', () => {
        const nickValue = $nickInput.value.trim();
        checkResultList[0] = false;

        if(originNick === nickValue){
            alert('기존 닉네임을 그대로 사용합니다')
            checkResultList[0] = true;
        } else if (nickValue === '' || !nickPattern.test(nickValue)) {
            alert('닉네임은 2글자 이상의 영문, 한글로 입력해주세요');
            checkResultList[0] = false;
        } else {
            fetch(`/members/check/nickname/` + nickValue)
                .then(res => res.json())
                .then(flag => {
                    if (flag) {
                        alert('닉네임이 중복되었습니다');
                        checkResultList[0] = false;
                    } else {
                        alert('사용 가능한 닉네임입니다');
                        checkResultList[0] = true;
                    }
                })
                .catch(error => {
                    console.error('Error checking nickname:', error);
                });
        }
    });

// 수정 모드에서 비밀번호 변경 버튼 누르면 비밀번호 변경 창 생성
document.getElementById('modify-pw').onclick = () => {
    checkResultList[1] = false;
    document.querySelector('.form-list').setAttribute("style", "display:block");
    document.getElementById('pw-inform').setAttribute("style","display:none");
    document.getElementById('modify-pw').setAttribute("style", "display:none")
};

// 비밀번호 입력 검증
const $pwInput = document.getElementById('pw');
const $reChkPw = document.getElementById('pw2');

const passwordPattern =/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~@#$!%*?&])[a-zA-Z\d~@#$!%*?&]{8,}$/;

$pwInput.addEventListener('keyup', () => {
    const pwValue = $pwInput.value.trim();

    if (pwValue === '') {
        $pwInput.style.borderColor = 'red';
        document.getElementById('pwChk').innerHTML = '<b style="color: red;">비밀번호는 필수값입니다</b>';
        checkResultList[1] = false;
        return;
    } else if (!passwordPattern.test(pwValue)) {
        $pwInput.style.borderColor = 'red';
        document.getElementById('pwChk').innerHTML = '<b style="color: red;">영문+특수문자 8자 이상 입력해 주세요</b>';
        checkResultList[1] = false;
        return;
    } else {
        $pwInput.style.borderColor = 'black';
        document.getElementById('pwChk').innerHTML = '<b style="color: #0a0064;">[사용가능한 비밀번호입니다]</b>';
        checkResultList[1] = true;
    }
});

$reChkPw.addEventListener('keyup', () => {
    const reChkPwVal = $reChkPw.value.trim();
    const pwValue = $pwInput.value.trim();

    if (reChkPwVal === '') {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호 확인은 필수입니다.</b>';
        checkResultList[2] = false;
        return;
    } else if (reChkPwVal !== pwValue) {
        document.getElementById('reChkPw').innerHTML = '<b style="color: red;">비밀번호와 일치하지 않습니다.</b>';
        checkResultList[2] = false;
        return;
    } else {
        $reChkPw.style.borderColor = 'black';
        document.getElementById('reChkPw').innerHTML = '<b style="color: #0a0064;">[비밀번호와 일치합니다.]</b>';
        checkResultList[2] = true;
    }
});