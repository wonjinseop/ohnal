package com.ohnal.chap.service;


import com.ohnal.chap.dto.request.NaverSignUpRequestDTO;
import com.ohnal.chap.dto.response.NaverResponseDTO;
import com.ohnal.chap.entity.Member;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
@Getter
public class NaverLoginService {

    private final MemberService memberService;

    public void naverLogin(Map<String, String> naverParams , HttpSession session) {

        String accessToken = getNaverToken(naverParams);
        session.setAttribute("access_token", accessToken);
        log.info("access_token: {}",accessToken);

        NaverResponseDTO dto = getNaverUserInfo(accessToken);

        //네이버에서받은정보로 회원가입
        String email = dto.getResponse().getEmail();
        log.info("이메일: {}",email);
        if (!memberService.checkDuplicateValue("email",email)) {
                    memberService.snsJoin(NaverSignUpRequestDTO.builder()
                                    .email(email)
                                    .password("0000")
                                    .nickname(dto.getResponse().getNickname())
                                    .loginMethod(Member.LoginMethod.NAVER)
                                    .build(),
                            dto.getResponse().getProfileImage()
                    );

        }

        memberService.maintainLoginState(session,email);

    }

    //토큰발급
    public String getNaverToken(Map<String, String> naverParams) {
        String getTokenUri = "https://nid.naver.com/oauth2.0/token";
        MultiValueMap<String ,String> tokenParams = new LinkedMultiValueMap<>();
        tokenParams.add("grant_type" , "authorization_code");
        tokenParams.add("client_id",naverParams.get("client_id"));
        tokenParams.add("client_secret",naverParams.get("client_secret"));
        tokenParams.add("code",naverParams.get("code"));
        tokenParams.add("state",naverParams.get("state"));
        log.info("tokenParams : {}",tokenParams);

        RestTemplate template = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        HttpEntity<Object> requestEntity = new HttpEntity<>(tokenParams, headers);
        ResponseEntity<Map> responseEntity
                = template.exchange(getTokenUri, HttpMethod.POST, requestEntity, Map.class);

        Map<String, Object> responseJSON = (Map<String, Object>) responseEntity.getBody();
        log.info("응답 JSON 데이터: {}", responseJSON);

        String accessToken = (String) responseJSON.get("access_token");

        return accessToken;

    }

    //유저 정보가져오기
    private NaverResponseDTO getNaverUserInfo(String accessToken){
        String RequestUrl = "https://openapi.naver.com/v1/nid/me";
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);

        RestTemplate template = new RestTemplate();
        ResponseEntity<NaverResponseDTO> responseEntity = template.exchange(
                RequestUrl, HttpMethod.POST,new HttpEntity<>(headers), NaverResponseDTO.class
        );
        NaverResponseDTO responseJSON = responseEntity.getBody();
        log.info("응답JSON 데이터(유저정보): {}", responseJSON);

        return responseJSON;
    }








}

