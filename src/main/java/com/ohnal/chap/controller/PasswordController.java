package com.ohnal.chap.controller;

import com.ohnal.chap.service.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/sign-in")
public class PasswordController {

    private final MemberService memberService;

    @Autowired
    public PasswordController(MemberService memberService) {
        this.memberService = memberService;
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
}
