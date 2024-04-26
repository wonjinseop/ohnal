package com.ohnal.chap.service;

import com.ohnal.chap.dto.request.SignUpRequestDTO;
import com.ohnal.chap.dto.response.GoogleUserResponseDTO;
import com.ohnal.chap.dto.response.KakaoUserResponseDTO;
import com.ohnal.chap.dto.response.LoginUserResponseDTO;
import com.ohnal.chap.entity.Member;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class SnsLoginService {
    private final MemberService memberService;

    @Value("${spring.security.oauth2.client.registration.google.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.registration.google.redirect-uri}")
    private String redirectUri;

    @Value("${spring.security.oauth2.client.registration.google.client-secret}")
    private String clientSecret;

    public void kakaoLogin(Map<String, String> params , HttpSession session) {


        String accessToken = getKakaoAccessToken(params);

        KakaoUserResponseDTO dto = getKakaoUserInfo(accessToken);
        log.info(dto.toString());

        String email = dto.getAccount().getEmail();
        log.info("사용자의 이메일 : {}", email);

        if (!memberService.checkDuplicateValue("email",email)) {
            memberService.join(
                    SignUpRequestDTO.builder()
                            .email(email)
                            .password("0000")
                            .nickname(dto.getProperties().getNickname())
                            .loginMethod(Member.LoginMethod.KAKAO)
                            .build(),
                    dto.getProperties().getProfileImage()
            );
        }
        //sns로그인 ohnal사이트로 로그인
        memberService.maintainLoginState(session, email);

    }

    private KakaoUserResponseDTO getKakaoUserInfo(String accessToken) {
        String requestUri = "https://kapi.kakao.com/v2/user/me";

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization" , "Bearer "+accessToken);
        headers.add("Content-type","application/x-www-form-urlencoded;charset=utf-8");

        RestTemplate template = new RestTemplate();
        ResponseEntity<KakaoUserResponseDTO> responseEntity = template.exchange(
                requestUri, HttpMethod.POST, new HttpEntity<>(headers), KakaoUserResponseDTO.class
        );
        KakaoUserResponseDTO responseJSON = responseEntity.getBody();


        return responseJSON;

    }

   //토큰 발급
    private String getKakaoAccessToken(Map<String , String> requestParam) {
        String requestUri = "https://kauth.kakao.com/oauth/token";
        HttpHeaders headers = new HttpHeaders();
        headers.add("content-type","application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("grant_type","authorization_code");
        params.add("client_id" , requestParam.get("appKey"));
        params.add("redirect_uri" , requestParam.get("redirect"));
        params.add("code", requestParam.get("code"));

        RestTemplate template = new RestTemplate();

        HttpEntity<Object> requestEntity = new HttpEntity<>(params, headers);

        ResponseEntity<Map> responseEntity
                = template.exchange(requestUri, HttpMethod.POST, requestEntity, Map.class);


        Map<String, Object> responseJSON = (Map<String, Object>) responseEntity.getBody();
        log.info("응답 JSON 데이터: {}", responseJSON);

        String accessToken = (String) responseJSON.get("access_token");
        return accessToken;

    }

    private String GoogleAccessToken(String code, String clientId, String clientSecret, String redirectUri) {
        // Google OAuth 2.0의 토큰 발급 엔드포인트 URL
        String tokenUri = "https://oauth2.googleapis.com/token";

        // HTTP 요청을 보낼 때 필요한 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        // HTTP 요청을 보낼 때 필요한 파라미터 설정
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("code", code);
        params.add("client_id", clientId);
        params.add("client_secret", clientSecret);
        params.add("redirect_uri", redirectUri);
        params.add("grant_type", "authorization_code");

        // REST API를 호출하기 위한 RestTemplate 객체 생성
        RestTemplate restTemplate = new RestTemplate();

        // Google OAuth 서버에 POST 요청을 보내서 액세스 토큰을 요청
        ResponseEntity<Map> responseEntity = restTemplate.postForEntity(
                tokenUri,
                new HttpEntity<>(params, headers),
                Map.class
        );

        // 응답에서 액세스 토큰을 추출하여 반환
        Map<String, String> responseMap = responseEntity.getBody();
        String accessToken = responseMap.get("access_token");

        return accessToken;
    }


    public void googleLogin(Map<String, String> params, HttpSession session) {
        String code = params.get("code");


        String accessToken = GoogleAccessToken(code, clientId,
                clientSecret,
                "http://localhost:8282/auth/google");


        GoogleUserResponseDTO dto = getGoogleUserInfo(accessToken);


        String email = dto.getEmail();
        log.info("email: {}", email);
        String nickname = dto.getNickname();
        log.info("nickname : {}", nickname);


        if (!memberService.checkDuplicateValue("email", email)) {
            memberService.join(
                    SignUpRequestDTO.builder()
                            .email(email)
                            .password("0000")
                            .nickname(dto.getNickname())
                            .loginMethod(Member.LoginMethod.GOOGLE)
                            .build(),
                    null
            );
        }


        memberService.maintainLoginState(session, email);
    }



    private GoogleUserResponseDTO getGoogleUserInfo(String accessToken) {
        String userInfoUri = "https://www.googleapis.com/oauth2/v3/userinfo";


        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);


        RestTemplate restTemplate = new RestTemplate();


        ResponseEntity<GoogleUserResponseDTO> responseEntity = restTemplate.exchange(
                userInfoUri,
                HttpMethod.GET,
                new HttpEntity<>(headers),
                GoogleUserResponseDTO.class
        );


        GoogleUserResponseDTO userResponseDTO = responseEntity.getBody();
        log.info("구글에서 받은 사용자 정보 {}", userResponseDTO);

        return userResponseDTO;
    }

}
