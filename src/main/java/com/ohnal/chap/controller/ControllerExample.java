package com.ohnal.chap.controller;

import com.ohnal.chap.dto.LoginRequestDTO;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ControllerExample {



    @GetMapping("/index")
    private String veiwIndex() {

        return "chap/index";
    }

    //로그인메인화면
    @GetMapping("/sign-in")
    private String signIn() {

        return "chap/sign-in";
    }

    @PostMapping("/sign-in")
    public String SignIn(LoginRequestDTO dto) {
        System.out.println("sign-in : post 로 요청들어옴");
        System.out.println(dto +"dto요청");


        return null;
    }










}
