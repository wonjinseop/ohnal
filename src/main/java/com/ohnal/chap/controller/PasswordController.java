package com.ohnal.chap.controller;

import com.ohnal.chap.service.MailSenderService;
import com.ohnal.chap.service.MemberService;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@Slf4j
@RequestMapping("/sign-in")
public class PasswordController {

    private final MemberService memberService;

   private final MailSenderService mailSenderService;

    @Autowired
    public PasswordController(MemberService memberService, MailSenderService mailSenderService) {
        this.memberService = memberService;
        this.mailSenderService = mailSenderService;
    }

    @GetMapping("/pwsearch")
    private String passwordSearch() {
        return "chap/pwsearch";
    }

    @PostMapping("/pwsearch")
    private String pwChange(String email, String password) {
            memberService.changePassword(email, password);
            return "redirect:/members/sign-in";
    }
    @PostMapping("/email")
    @ResponseBody
    public ResponseEntity<?> mailCheck(@RequestBody String email) {
        log.info("이메일 인증 요청 들어옴!: {}", email);
        try {
            String authNum = mailSenderService.pwEmail(email);
            return ResponseEntity.ok().body(authNum);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("이메일 전송 과정에서 에러 발생!");
        }
    }
}
