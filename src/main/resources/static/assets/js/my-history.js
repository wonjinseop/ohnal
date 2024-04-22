// HTML 문서 로딩이 완료되었을 때, 해당 함수를 실행
console.log("my-history.js 파일이 업로드 되었습니다.");
// 컨트롤러(서버단)에서 전달한 값을 템플릿 리터럴로 꺼내기
console.log('${loginUserEmail}');
console.log('${mp}');


// 내가 쓴 글 버튼(div)을 누르면 내가 쓴 글 목록이 조회된다.
function getMyPosts() {
    console.log("내가 쓴 글 목록 모두 조회 버튼 눌렀다.");

}

// 내가 쓴 댓글 버튼(div)을 누르면 내가 쓴 댓글 목록이 모두 조회된다.
function getMyReplyPosts() {
    console.log("내가 쓴 댓글 목록 모두 조회 버튼 눌렀다.");
    const url = '/members/';
}

// 내가 좋아요한 글 버튼(div)을 누르면 내가 좋아요한 글 목록이 조회된다.
function getLikedPosts() {
    console.log("내가 좋아요한 글 목록 모두 조회 버튼 눌렀다.");


}