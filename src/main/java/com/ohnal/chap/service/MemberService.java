package com.ohnal.chap.service;

import com.ohnal.chap.dto.request.AutoLoginDTO;
import com.ohnal.chap.dto.request.LoginRequestDTO;
import com.ohnal.chap.dto.request.ModifyRequestDTO;
import com.ohnal.chap.dto.request.ModifyRequestDTO;
import com.ohnal.chap.dto.request.NaverSignUpRequestDTO;
import com.ohnal.chap.dto.request.SignUpRequestDTO;
import com.ohnal.chap.dto.response.LoginUserResponseDTO;
import com.ohnal.chap.entity.Member;
import com.ohnal.chap.mapper.MemberMapper;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.WebUtils;

import java.time.LocalDateTime;

import static com.ohnal.chap.service.LoginResult.NO_PW;
import static com.ohnal.chap.service.LoginResult.SUCCESS;
import static com.ohnal.util.LoginUtils.*;

import java.util.Map;


@Service
@RequiredArgsConstructor
@Slf4j
public class MemberService {

    private final MemberMapper memberMapper;
    private final PasswordEncoder encoder;

    // 회원 가입 처리 서비스
    public void join(SignUpRequestDTO dto, String savePath) {
        // 클라이언트가 보낸 회원가입 데이터를
        // 패스워드 인코딩하여 엔터티로 변환해서 전달.
       // String encodedPw = encoder.encode(dto.getPassword());
       // dto.setPassword(encodedPw);
        memberMapper.save(dto.toEntity(encoder, savePath));
    }

    public void snsJoin(NaverSignUpRequestDTO dto, String savePath) {

        memberMapper.save(dto.toEntity(encoder, savePath));
    }

    // 로그인 검증 처리
    public LoginResult authenticate(LoginRequestDTO dto,
                                    HttpSession session,
                                    HttpServletResponse response) {

        Member foundMember = memberMapper.findMember(dto.getEmail());
        log.info(String.valueOf(foundMember));

        if (foundMember == null) { // 회원가입 안한 상태
            System.out.println(dto.getEmail() + "(은) 가입되지 않은 아이디입니다.");
            return LoginResult.NO_EMAIL;
        }

        String inputPassword = dto.getPassword();
        String realPassword = foundMember.getPassword();

        if (!encoder.matches(inputPassword, realPassword)) {
            System.out.println("비밀번호가 일치하지 않습니다.");
            return NO_PW;
        }
        // 자동 로그인 처리
        if (dto.isAutoLogin()) {
            // 1. 자동 로그인 쿠키 생성 - 쿠키 안에 절대 중복되지 않는 값을 저장. (브라우저 세션 아이디)
            Cookie autoLoginCookie = new Cookie(AUTO_LOGIN_COOKIE, session.getId());

            // 2. 쿠키 설정 - 사용경로, 수명....
            int limitTime = 60 * 60 * 24 * 90; // 자동 로그인 유지 시간
            autoLoginCookie.setPath("/");
            autoLoginCookie.setMaxAge(limitTime);

            // 3. 쿠키를 클라이언트에게 전송하기 위해 응답 객체에 태우기
            response.addCookie(autoLoginCookie);

            // 4. DB에도 쿠키에 관련된 값들(랜덤한 세션아이디, 자동로그인 만료시간)을 갱신.
            memberMapper.saveAutoLogin(AutoLoginDTO.builder()
                    .sessionId(session.getId())
                    .limitTime(LocalDateTime.now().plusDays(90))
                    .email(dto.getEmail())
                    .build()
            );
        }
        System.out.println(dto.getNickname() + "님 환영합니다.");
        return SUCCESS;
    }

    // 중복 값 체크
    public boolean checkDuplicateValue(String type, String keyword) {
        return memberMapper.isDuplicate(type, keyword);
    }

    public void changePassword(String email, String password){
        String encodedPw = encoder.encode(password);
        memberMapper.changePw(email, encodedPw);
    }

    public void maintainLoginState(HttpSession session, String account) {

        // 세션은 서버에서만 유일하게 보관되는 데이터로서
        // 로그인 유지 등 상태 유지가 필요할 때 사용되는 내장 객체입니다.
        // 세션은 쿠키와 달리 모든 데이터를 저장할 수 있으며 크기도 제한이 없습니다.
        // 세션의 수명은 기본 1800초 -> 원하는 만큼 수명을 설정할 수 있습니다.
        // 브라우저가 종료되면 남은 수명에 상관없이 세션 데이터는 소멸합니다.

        // 현재 로그인한 회원의 모든 정보 조회
        Member foundMember = memberMapper.findMember(account);

        // DB 데이터를 보여줄 것만 정제
        LoginUserResponseDTO dto = LoginUserResponseDTO.builder()
                .email(foundMember.getEmail())
                .nickname(foundMember.getNickname())
                .loginMethod(foundMember.getLoginMethod().toString())
                .address(foundMember.getAddress())
                .gender(foundMember.getGender())
                .regDate(String.valueOf(foundMember.getRegDate()))
                .build();

        // 프로필 사진 설정 여부에 따라 다른 이미지 경로 적용
        if(foundMember.getProfileImage() == null) { // 설정된 이미지 정보가 없으면
            dto.setProfile("/assets/img/anonymous-image.png"); // 기본 프로필 사진
        } else if(foundMember.getProfileImage().contains("/profile")) { // 설정한 이미지 정보가 있고, profile 경로로 시작하면
            dto.setProfile("/display" + foundMember.getProfileImage());
        } else { // profile 경로로 시작하지 않음(예: 카카오 로그인)
            dto.setProfile(foundMember.getProfileImage());
        }

        log.info(dto.toString());

        // 세션에 로그인한 회원 정보를 저장
        session.setAttribute(LOGIN_KEY, dto);
        // 세션 수명 설정
        session.setMaxInactiveInterval(60 * 60); // 1시간
    }

    public void autoLoginClear(HttpServletRequest request, HttpServletResponse response) {

        // 1. 자동 로그인 쿠키를 가져온다.
        Cookie c = WebUtils.getCookie(request, AUTO_LOGIN_COOKIE);

        // 2. 쿠키를 삭제한다.
        // -> 쿠키의 수명을 0초로 설정하여 다시 클라이언트에 전송 -> 자동 소멸
        if (c != null) {
            c.setMaxAge(0);
            c.setPath("/");
            response.addCookie(c);

            // 3. 데이터베이스에서도 세션아이디와 만료시간을 제거하자.
            memberMapper.saveAutoLogin(
                    AutoLoginDTO.builder()
                            .sessionId("none") // 세션아이디 지우기
                            .limitTime(LocalDateTime.now()) // 로그아웃한 현재 날짜
                            .email(getCurrentLoginMemberEmail(request.getSession())) // 로그인 중이었던 사용자 아이디.
                            .build()
            );
        }

    }

    public LoginUserResponseDTO getMemberInfo(String account) {
        Member foundMember = memberMapper.findMember(account);

        LoginUserResponseDTO dto = LoginUserResponseDTO.builder()
                .email(foundMember.getEmail())
                .nickname(foundMember.getNickname())
                .address(foundMember.getAddress())
                .gender(foundMember.getGender())
                .profile(foundMember.getProfileImage())
                .loginMethod(foundMember.getLoginMethod().toString())
                .regDate(String.valueOf(foundMember.getRegDate()).substring(0,10))
                .build();
        return dto;
    }

    public void kakaoLogout(LoginUserResponseDTO dto, HttpSession session) {

        String requestUri = "https://kapi.kakao.com/v1/user/logout";

        String accessToken = (String) session.getAttribute("access_token");

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);

        MultiValueMap<String, Object> params = new LinkedMultiValueMap<>();
        params.add("target_id_type", "user_id");
        params.add("target_id", dto.getEmail());

        RestTemplate template = new RestTemplate();
        ResponseEntity<Map> responseEntity = template.exchange(
                requestUri,
                HttpMethod.POST,
                new HttpEntity<>(params, headers),
                Map.class
        );

        Map<String, Object> responseJSON = (Map<String, Object>) responseEntity.getBody();
        log.info("응답 데이터: {}", responseJSON); // 로그아웃하는 사용자의 id

        // 만약 access_token의 값을 DB에 저장한 경우에는, 응답받은 id를 통해서
        // DB의 access_token의 값을 update를 때려서 null로 만들어 주시면 됩니다.

    }


    // 회원 정보 수정 처리 서비스
    public void modifyInfo(ModifyRequestDTO dto) {
        memberMapper.modify(dto.toEntity());
    }

    public void modifyProfileImage(String email, String savePath) {
        memberMapper.modifyProfileImage(email, savePath);
    }
}