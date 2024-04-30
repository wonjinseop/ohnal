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

// card-container /card-wrapper/ data-bno="${b.boardNo}
//게시물 클릭시 modal창 열리는 이벤트 발생, 클릭한 게시물 내용 모달창에 넣는 기능

const $cardContainer = document.querySelector('.card-container');

$cardContainer.onclick = e => {

    const $cardWrapper = e.target.closest('.card-wrapper');
    const $card = e.target.closest('.select-card');
    if ($card) {
        const $email = $card.dataset.email;
        const bno = $card.dataset.bno;
        const $like = e.target.closest('.like-icon');

        const $wrapper = $card.querySelector('.icon-wrapper');
        const $likeIcon = $wrapper.querySelector('.like-icon');
        const $likeImg = $likeIcon.querySelector('img');

        const src = $likeImg.getAttribute('src');

        const URL = '/board/detail/' + bno;
        if ($like) {
            if ($email == '') {
                alert("로그인한 회원만 가능합니다.");
            } else {
                toggleHeart($email, $like, bno);
            }
        } else {

            if (e.target.matches('button')) {
                console.log("button click!");
                if (!confirm("정말 삭제하시겠습니까?")) {
                          return;
                }
                // 글 삭제
                fetch('/board/delete/' + bno)
                    .then(res => {
                    console.log(res);
                    location.href = location.href;
                        // $cardWrapper.style.display = 'none';
                    // 해당 페이지에 나타나는 게시물 1개 있을 때 삭제하면 그 전페이지로 넘어가게 설정이 필요
                    });
            } else {

                // 모달창 채워넣기
                console.log(bno);
                fetch(URL)
                    .then(res => res.json())
                    .then(data => {
                        const $heart = document.querySelector('.modal .heart');
                        console.log(data);
                        document.querySelector('.modal .card').dataset.bno = bno;
                        document.querySelector('.modal .card-account').textContent = data.nickname;
                        document.querySelector('.modal .content').textContent = data.content;
                        document.querySelector('.modal .content-img').setAttribute('src', '/display' + data.image);
                        document.querySelector('.modal .like-count').textContent = '좋아요 ' + data.likeCount + '개';
                        document.querySelector('.modal .reply-count').textContent = '댓글 ' + data.replyCount + '개';
                        document.querySelector('.modal .view-count').textContent = '조회수 ' + data.viewCount + '회';
                        document.querySelector('.modal .location').textContent = data.locationTag;
                        document.querySelector('.modal .weather').textContent = data.weatherTag;
                        document.querySelector('.modal .time-stamp').textContent = data.regDate;
                        document.querySelector('.modal .profile-image').setAttribute('src', data.profileImage);
                        $heart.setAttribute('src', src);
                        $heart.setAttribute('data-email', $email)

                        document.body.style.overflow = 'hidden';

                    });

                document.getElementById('modalBtn').click();
                fetchGetReplies(bno);
            }

        };

        document.querySelector('.modal .heart').onclick = e => {
            const $likeEmail = e.target.dataset.email;
            const $liked = e.target;
            if ($email == '') {
                alert("로그인한 회원만 가능합니다.");
            } else {
                detailToggleHeart($likeEmail, $liked, $likeImg, bno);
            }

        }

    };




};

// 모달창 이벤트
const $modal = document.querySelector('.modal');
const $modalCard = document.querySelector('.modal-wrapper-card-2');
console.log($modal);
$modalCard.onclick = e => {
    const bno = $modal.querySelector('.card').dataset.bno;
    console.log(bno);
    const $reply = e.target.closest('.reply');
    if ($reply) {
        const replyNo = $reply.dataset.replyNo;

        const $email = $modal.dataset.email;
        console.log(replyNo);
        console.log($email);

        const select = $reply.querySelector('.reply-data');
        const $deleteBtn = select.querySelector('.reply-delete');
        console.log($deleteBtn);
        console.log(select);
        if (e.target.matches('.reply-delete')) {
            if ($email !== '') {
                if ($reply.querySelector('.card-account').dataset.email == $email ||
                    document.querySelector('.card-container').dataset.auth == 'ADMIN') {
                        if (!confirm("정말 삭제하시겠습니까?")) {
                            return;
                          }
                    const payLoad = {
                        bno: bno,
                        rno: replyNo,
                        email: $email
                    }

                    const requestInfo = {
                        method: 'DELETE',
                        headers: {
                            'content-type': 'application/json'
                        },
                        body: JSON.stringify(payLoad)
                    }

                    // 댓글 삭제
                    fetch("/board/reply", requestInfo)
                        .then(res => console.log(res));
                    $reply.style.display = 'none';

                } else {
                    alert("본인 글만 삭제가 가능합니다.")
                }
            } else {
                alert("로그인 후 이용 가능합니다.")
            }
            // 댓글 수정 이벤트
        } else if (e.target.matches('.reply-modify')) {
            document.removeEventListener('keydown', handleEnterKeyPress);
            const $modBtn = $reply.querySelector('.mod-btn');
            // console.log($modBtn);
            const $replyContent = $reply.querySelector('.reply-content');
            const $replyMod = $reply.querySelector('.reply-mod');

            document.addEventListener('keydown', function (event) {
                if (event.key === 'Escape') {
                    $replyMod.classList.add('toggle');
                }
            });

            if ($email !== '') {

                if ($reply.querySelector('.card-account').dataset.email == $email) {
                    // 엔터 키가 눌렸을 때 이벤트 리스너 추가
                    document.addEventListener('keydown', handleModEnterKeyPress);
                    // Esc 키가 눌렸을 때 이벤트 리스너 추가

                    $replyMod.classList.toggle('toggle');
                    $replyMod.focus();
                    $replyMod.onblur = () => {
                        $replyMod.classList.add('toggle');
                    }
                    $modBtn.onclick = () => {

                        const content = $replyMod.value;
                        // console.log($replyMod.value);
                        $replyMod.setAttribute('placeholder', content)
                        $replyMod.value = '';

                        // console.log("modBtn 클릭!");
                        const payLoad = {
                            rno: replyNo,
                            content: content
                        };

                        const requestInfo = {
                            method: 'POST',
                            headers: {
                                'content-type': 'application/json'
                            },
                            body: JSON.stringify(payLoad)
                        };
                        if (content != '') {
                            $replyContent.textContent = content
                            // 댓글 수정
                            fetch("/board/reply/update", requestInfo)
                                .then(res => {
                                    console.log(res)
                                    $replyMod.classList.toggle('toggle');
                                    document.removeEventListener('keydown', handleModEnterKeyPress);
                                });
                        }



                    }
                } else {
                    alert("본인 글만 수정이 가능합니다.")
                };
            } else {
                alert("로그인 후 이용 가능합니다.")
            }

            function handleModEnterKeyPress(event) {
                if (event.key === 'Enter') {
                    // submitButton을 클릭합니다.
                    $modBtn.click();
                }
            }
        }



    }



}

const $replyWrite = document.querySelector('.write-reply');

if ($replyWrite) {
    const $submitButton = document.querySelector('.write-send');
    const email = document.querySelector('.email').value;
    console.log(email);
    // 버튼 요소 선택
    $replyWrite.onclick = () => {
        if (email == '') {
            alert("로그인 후 이용 가능합니다.");
        }
    }


    // 버튼 클릭 이벤트 핸들러 등록
    $submitButton.addEventListener('click', function () {
        const boardNo = document.querySelector('.modal .card').dataset.bno;

        // 입력 필드 선택
        const inputField = document.querySelector('.write-input');
        const nickname = document.querySelector('.nickname').value;

        const URL = '/board/reply'

        console.log(boardNo);
        console.log(inputField.value);

        // 사용자 입력자 검증
        if (inputField.value.trim() === '') {
            alert('댓글 내용은 필수값입니다!!');
            return;
        };

        console.log(email);
        console.log(nickname);

        const payLoad = {
            text: inputField.value.trim(),
            bno: boardNo,
            nickname: nickname,
            email: email
        };

        // 요청 방식 및 데이터를 전달할 정보 객체 만들기 (POST)
        const requestInfo = {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payLoad) // js 객체를 JSON으로 변환해서 body에 추가
        };

        // 서버에 POST 요청 보내기
        fetch(URL, requestInfo)
            .then(res => {
                console.log(res.status);

                if (res.status === 200) {
                    return res.text();
                } else {
                    alert('입력값에 문제가 있습니다! 입력값을 다시 확인해 보세요!');
                    return res.text();
                };

            })
            .then(() => {
                // 입력 필드의 값 비우기
                inputField.value = '';

                // 댓글 목록 비동기 요청
                fetchGetReplies(boardNo);

            });
    });

    function handleEnterKeyPress(event) {
        if (event.key === 'Enter') {
            // submitButton을 클릭합니다.
            $submitButton.click();
        }
    }

    // 엔터 키가 눌렸을 때 이벤트 리스너 추가
    document.addEventListener('keydown', handleEnterKeyPress);

}

function toggleHeart(likeEmail, $like, bno) {
    like(likeEmail, bno);
    console.log(likeEmail);
    console.log($like);
    if (likeEmail !== '') {
        const likeIcon = $like.querySelector('img');
        if (likeIcon.getAttribute('src').endsWith('fill-heart.svg')) {
            likeIcon.setAttribute('src', '/assets/img/heart.svg');
        } else {
            likeIcon.setAttribute('src', '/assets/img/fill-heart.svg');
        };

    };
}

function detailToggleHeart(likeEmail, $like, likeImg, bno) {
    like(likeEmail, bno);
    console.log(likeEmail);
    console.log($like);
    if (likeEmail !== '') {
        if ($like.getAttribute('src').endsWith('fill-heart.svg')) {
            $like.setAttribute('src', '/assets/img/heart.svg');
            likeImg.setAttribute('src', '/assets/img/heart.svg');
        } else {
            $like.setAttribute('src', '/assets/img/fill-heart.svg');
            likeImg.setAttribute('src', '/assets/img/fill-heart.svg');
        };
    };

}

function like(email, bno) {

    const URL = '/board/like';

    const payLoad = {
        email: email,
        bno: bno
    };

    console.log(payLoad);

    const requestInfo = {
        method: 'POST',
        headers: {
            'content-type': 'application/json'
        },
        body: JSON.stringify(payLoad)
    };

    fetch(URL, requestInfo)
        .then(res => console.log(res));

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

}

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
            console.log(profileImage);
            tag += `
            <div class="reply" data-reply-no="${replyNo}">
            <span class='card-account' data-email='${email}'><img src='${profileImage}' class='profile-img'>${nickname}</span>
            <p class='reply-content'>
                ${content}
            </p>
            <input class='reply-mod toggle' type='text' placeholder='${content}'>
            <button class='mod-btn' type='button' hidden></button>
  
  
            <div class='reply-data'>
              <span class='time'>${time}</span>
              <button class="reply-modify">수정</button>
              <button class="reply-delete">삭제</button>
            </div>
          </div>
        `;

        }

    } else {
        tag += "<div id='replyContent' class='card-body'>댓글이 아직 없습니다! ㅠㅠ</div>";
    }

    $replyWrapper.innerHTML = tag;

};