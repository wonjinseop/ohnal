package com.ohnal.chap.controller;

import com.ohnal.chap.service.SnsLoginService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
public class GoogleController {

    private final SnsLoginService snsLoginService;

    @Value("${spring.security.oauth2.client.registration.google.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.registration.google.redirect-uri}")
    private String redirectUri;


    @GetMapping("/google/login")
    public String googleLogin() {
        String authorizationUri = "https://accounts.google.com/o/oauth2/auth";
        String scope = "openid email profile";
        String responseType = "code";
        String uri = authorizationUri + "?client_id=" + clientId + "&redirect_uri=" + redirectUri +
                "&response_type=" + responseType + "&scope=" + scope;
        return "redirect:" + uri;
    }

    @GetMapping("/auth/google")
    public String snsGoogle( String code, HttpSession session) {
        Map<String, String> params = new HashMap<>();
        params.put("appKey",  clientId);
        params.put("redirect", redirectUri);
        params.put("code", code);

        snsLoginService.googleLogin(params, session);
        return "redirect:/index";
    }
}