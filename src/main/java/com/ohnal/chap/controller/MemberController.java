package com.ohnal.chap.controller;

import com.ohnal.chap.dto.request.LoginRequestDTO;
import com.ohnal.chap.dto.request.SignUpRequestDTO;
import com.ohnal.chap.entity.Member;
import com.ohnal.chap.service.LoginResult;
import com.ohnal.chap.service.MemberService;
import com.ohnal.util.FileUtils;
import com.ohnal.chap.service.MailSenderService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/members")
@RequiredArgsConstructor
@Slf4j
public class MemberController {

    @Value("${file.upload.root-path}")
    private String rootPath;


    private final MemberService memberService;
    private final MailSenderService mailsenderService;

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
        String savePath = FileUtils.uploadFile(dto.getProfileImage(), rootPath);
        log.info("save-path: {}", savePath);

        // 일반 방식(우리사이트를 통해)으로 회원가입
        dto.setLoginMethod(Member.LoginMethod.COMMON);

        memberService.join(dto, savePath);
        return "redirect:/chap/sign-in";
    }

    @PostMapping("/sign-in")
    public String signIn(LoginRequestDTO dto,
                         // Model에 담긴 데이터는 리다이렉트 시 jsp로 전달되지 못한다.
                         // 리다이렉트는 응답이 나갔다가 재요청이 들어오는데, 그 과정에서
                         // 첫번째 응답이 나가는 순간 모델은 소멸함. (Model의 생명주기는 한 번의 요청과 응답 사이에서만 유효)
                         RedirectAttributes ra,
                         HttpServletResponse response,
                         HttpServletRequest request
    ) {

        // 자동 로그인 서비스를 추가하기 위해 세션과 응답객체도 함께 전달.
        LoginResult result = memberService.authenticate(dto, request.getSession(), response);
        log.info("result: {}", result);

        ra.addFlashAttribute("result", result);

        if (result == LoginResult.SUCCESS) { // 로그인 성공 시

            // 로그인을 했다는 정보를 계속 유지하기 위한 수단으로 쿠키를 사용하자.

             makeLoginCookie(dto, response);

            // 세션으로 로그인 유지
            memberService.maintainLoginState(request.getSession(), dto.getEmail());

            return "redirect:/index";
        }

        return "redirect:/chap/sign-in"; // 로그인 실패 시
    }

    private void makeLoginCookie(LoginRequestDTO dto, HttpServletResponse response) {
        Cookie cookie = new Cookie("login", dto.getEmail());

        cookie.setMaxAge(60);
        cookie.setPath("/");

        response.addCookie(cookie);
    }
    // 이메일 인증
    @PostMapping("/email")
    @ResponseBody
    public ResponseEntity<?> mailCheck(@RequestBody String email) {
        log.info("이메일 인증 요청 들어옴!: {}", email);
        try {
            String authNum = mailsenderService.joinEmail(email);
            return ResponseEntity.ok().body(authNum);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("이메일 전송 과정에서 에러 발생!");
        }
    }

    // my-page로 이동하는 메서드
    @GetMapping("/my-history")
    public String myHistory() {
        return "chap/my-history";
    }

}