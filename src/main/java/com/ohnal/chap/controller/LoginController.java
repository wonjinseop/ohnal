package com.ohnal.chap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.PushbackInputStream;

@Controller
public class LoginController {
    @GetMapping("/sign-up")
    public String signUp(){
    return "chap/sign-up";
    }
}
