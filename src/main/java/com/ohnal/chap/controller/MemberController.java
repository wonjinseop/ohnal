package com.ohnal.chap.controller;

import com.ohnal.chap.common.Page;
import com.ohnal.chap.common.PageMaker;
import com.ohnal.chap.dto.request.LoginRequestDTO;
import com.ohnal.chap.dto.request.SignUpRequestDTO;
import com.ohnal.chap.dto.response.BoardListResponseDTO;
import com.ohnal.chap.dto.response.LoginUserResponseDTO;
import com.ohnal.chap.entity.Member;
import com.ohnal.chap.service.*;
import com.ohnal.util.FileUtils;
import com.ohnal.chap.service.MailSenderService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

import static com.ohnal.util.LoginUtils.*;

@Controller
@RequestMapping("/members")
@RequiredArgsConstructor
@Slf4j
public class MemberController {

    private final MemberService memberService;
    private final MailSenderService mailSenderService;
    private final BoardService boardService;

    @Value("${file.upload.root-path}")
    private String rootPath;

    @GetMapping("/sign-up")
    public String signUp() {
        return "chap/sign-up";
    }
    @GetMapping("/sign-in")
    public String signIn() {
        return "chap/sign-in";
    }

    @GetMapping("/check/{type}/{keyword}")
    @ResponseBody
    public ResponseEntity<?> check(@PathVariable String type,
                                   @PathVariable String keyword) {
        log.info("/members/check: async GET");
        log.debug("type: {}, keyword: {}", type, keyword);

        boolean flag = memberService.checkDuplicateValue(type, keyword);

        return ResponseEntity.ok().body(flag);
    }

    @PostMapping("/sign-up")
    public String signUp(SignUpRequestDTO dto) {
        
        if (!dto.getProfileImage().toString().contains("org.springframework.web")) { // 프사 등록 안 했을 시
            dto.setProfileImage(null);
            memberService.join(dto, null);
        } else {
            if (!rootPath.contains("/profile")) {
                rootPath +="/profile";
            }
            String savePath = "/profile" + FileUtils.uploadFile(dto.getProfileImage(), rootPath);
            log.info("save-path: {}", savePath);

            // 일반 방식(우리사이트를 통해)으로 회원가입
            dto.setLoginMethod(Member.LoginMethod.COMMON);

            memberService.join(dto, savePath);
        }

        return "redirect:/members/sign-in";
    }

    @PostMapping("/sign-in")
    public String signIn(LoginRequestDTO dto,
                         RedirectAttributes ra,
                         HttpServletResponse response,
                         HttpServletRequest request
    ) {




        // 자동 로그인 서비스를 추가하기 위해 세션과 응답객체도 함께 전달.
        LoginResult result = memberService.authenticate(dto, request.getSession(), response);
        log.info("result: {}", result);

        ra.addFlashAttribute("result", result);

        if (result == LoginResult.SUCCESS) { // 로그인 성공 시
            // 세션으로 로그인 유지
            memberService.maintainLoginState(request.getSession(), dto.getEmail());

            return "redirect:/index";
        }

        return "redirect:/members/sign-in"; // 로그인 실패 시
    }

    // 로그아웃 요청 처리
    @GetMapping("/sign-out")
    public String signOut(HttpSession session,
                          HttpServletRequest request,
                          HttpServletResponse response) {
        log.info("/member/sign-out: GET!");

        // 자동 로그인 중인지 확인
        if (isAutoLogin(request)) {
            // 쿠키를 삭제해주고 DB 데이터도 원래대로 돌려놓아야 한다.
            memberService.autoLoginClear(request, response);
        }

         //sns 로그인 상태인지를 확인
        LoginUserResponseDTO dto = (LoginUserResponseDTO) session.getAttribute(LOGIN_KEY);
        if (dto.getLoginMethod().equals("KAKAO")) {
            memberService.kakaoLogout(dto, session);
        } else if (dto.getLoginMethod().equals("NAVER")) {
            memberService.naverLogout(dto, session);
        }

        // 세션에서 로그인 정보 기록 삭제
        session.removeAttribute("login");

        // 세션 전체 무효화 (초기화)
        session.invalidate();

        return "redirect:/members/sign-in";

    }

    // 이메일 인증
    @PostMapping("/email")
    @ResponseBody
    public ResponseEntity<?> mailCheck(@RequestBody String email) {
        log.info("이메일 인증 요청: {}", email);
        try {
            String authNum = mailSenderService.joinEmail(email);
            return ResponseEntity.ok().body(authNum);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("이메일 전송 과정에서 에러 발생");
        }
    }

    //-----------------------my-history-----------------------

    // my-history로 이동하는 메서드와 내가 작성한 글 버튼 누르면 작동하는 메서드
    @GetMapping("/my-history")
    public String myHistory(HttpSession session, @ModelAttribute("s")Page page, Model model) {
        log.info("my-history 페이지 들어옴");
        log.info("page: {}", page);
        log.info("s: {}", "s");

        String email = getCurrentLoginMemberEmail(session); // 사용자 email 얻어옴
        log.info("email: {}", email);

        // 처음 들어왔을 때, my-history 페이지에서
        // 작성한 글 버튼 눌렀을 때 보여지는 화면이 기본 값이다.
        List<BoardListResponseDTO> myPosts = boardService.findAllByEmail(email, page);
        /*PageMaker maker = new PageMaker(page, myPosts.size());*/
        PageMaker maker = new PageMaker(page, boardService.findAllMyPostsCount(email));
        log.info("maker: {}", maker);
        log.info("내가 좋아요한 글 개수: {}", maker);
        log.info("내가 작성한 글 목록: {}", myPosts);

        int type = 1;
        model.addAttribute("type", type);
        model.addAttribute("myPosts", myPosts); // 내가 작성한 글 목록을 모델에 담아
        model.addAttribute("maker", maker); // 페이징 처리된 객체를 모델에 담아
        String url = "/members/my-history";
        model.addAttribute("url", url);

        return "chap/my-history";
    }

    @GetMapping("/my-history/find-my-comments")
    public String findMyComments(HttpSession session, @ModelAttribute("s")Page page, Model model) {
        log.info("my-history 페이지에서 작성 댓글(버튼) 누름");

        String email = getCurrentLoginMemberEmail(session); // 사용자 email 얻어옴
        log.info("email: {}", email);

        // 여기서 myPosts는 내가 작성한 댓글의 글들의 정보를 담은 List컬렉션
        List<BoardListResponseDTO> myPosts = boardService.findMyComments(email, page);

        PageMaker maker = new PageMaker(page, boardService.findAllMyComments(email));
        log.info("maker: {}", maker);
        log.info("내가 좋아요한 글 개수: {}", maker);
        log.info("내가 작성한 댓글 목록: {}", myPosts);


        int type = 2;
        model.addAttribute("type", type);
        model.addAttribute("myPosts", myPosts); // 내가 작성한 댓글 목록을 모델에 담아
        model.addAttribute("maker", maker); // 페이징 처리된 객체를 모델에 담아
        String url = "/members/my-history/find-my-comments";
        model.addAttribute("url", url);

        return "chap/my-history";
    }

    // 내가 좋아요한 글 버튼 누르면 작동하는 컨트롤러단 메서드
    @GetMapping("/my-history/find-my-like-post")
    public String findMyLikePosts(HttpSession session, @ModelAttribute("s")Page page, Model model) {
        log.info("my-history 페이지에서 좋아요한 글(버튼) 누름");

        String email = getCurrentLoginMemberEmail(session); // 사용자 email 얻어옴
        log.info("email: {}", email);

        // 여기서 myPosts는 내가 좋아요한 글의 정보를 담은 List컬렉션
        List<BoardListResponseDTO> myPosts = boardService.findMyLikePosts(email, page);
        PageMaker maker = new PageMaker(page, boardService.findMyLikeCount(email));

        log.info("maker: {}", maker);
        log.info("내가 좋아요한 글 개수: {}", maker);
        log.info("내가 좋아요한 글 목록: {}", myPosts);

        int type = 3;
        model.addAttribute("type", type);

        model.addAttribute("myPosts", myPosts); // 내가 작성한 댓글 목록을 모델에 담아
        model.addAttribute("maker", maker); // 페이징 처리된 객체를 모델에 담아
        String url = "/members/my-history/find-my-like-post";
        model.addAttribute("url", url);

        return "chap/my-history";
    }

}