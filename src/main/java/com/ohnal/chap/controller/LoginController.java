package com.ohnal.chap.controller;

import com.ohnal.chap.dto.LoginRequestDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.PushbackInputStream;

@Controller
public class LoginController {
    @GetMapping("/sign-up")
    public String signUp(){
    return "chap/sign-up";
    }


    //로그인메인화면
    @GetMapping("/sign-in")
    private String signIn() {

        return "chap/sign-in";
    }

    @PostMapping("/sign-in")
    public String SignIn(LoginRequestDTO dto) {


        return null;
    }


}
