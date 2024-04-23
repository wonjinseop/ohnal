//package com.ohnal.chap.controller;
//import com.ohnal.chap.service.NaverLoginService;
//import jakarta.servlet.http.HttpSession;
//import lombok.AllArgsConstructor;
//import lombok.Builder;
//import lombok.RequiredArgsConstructor;
//import lombok.ToString;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import java.net.URLEncoder;
//import java.security.SecureRandom;
//import java.util.Base64;
//import java.util.HashMap;
//import java.util.Map;
//@Controller
//@Slf4j
//@RequiredArgsConstructor
//@ToString
//public class NaverController {
//    private final NaverLoginService naverLoginService;
//    @Value("${sns.naver.client-id}")
//    private String clientId;
//    @Value("${sns.naver.client-secret}")
//    private String clientSecret;
//    @Value("${sns.naver.redirect-uri}")
//    private String redirectUri;
//    @Value("${sns.naver.state}")
//    private String state;
//    @Value("${sns.naver.grant_type")
//    private String grantType;
//
//
//
//
//    //네이버로그인
//    @GetMapping("/naver/login")
//    private String naverLogin(){
//        String  uri = "https://nid.naver.com/oauth2.0/authorize";
//        uri += "?response_type=code";
//        uri += "&client_id="+clientId;
//        uri += "&state="+state;
//        uri += "&redirect_uri="+redirectUri;
//        log.info("url: {}", uri);
//        return "redirect:"+uri;
//
//    }
//
//    //인가코드발급
//    @GetMapping("/auth/naver")
//    public String naverCallback(String code, String state) {
//        log.info("/auth/naver: GET!");
//        log.info("code: {}, state: {}", code, state);
//        Map<String , String > naverParams = new HashMap<>();
//        naverParams.put("grant_type",grantType);
//        naverParams.put("client_id",clientId);
//        naverParams.put("client_secret",clientSecret);
//        naverParams.put("code",code );
//        naverParams.put("state", state);
//        naverLoginService.getNaverToken(naverParams);
//        return "redirect:/index";
//    }
//}
