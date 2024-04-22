package com.ohnal.chap.service;

import com.ohnal.chap.dto.request.AutoLoginDTO;
import com.ohnal.chap.dto.request.LoginRequestDTO;
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
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import java.time.LocalDateTime;

import static com.ohnal.chap.service.LoginResult.NO_PW;
import static com.ohnal.chap.service.LoginResult.SUCCESS;
import static com.ohnal.util.LoginUtils.*;
import org.springframework.web.util.WebUtils;

import java.time.LocalDateTime;

import static com.ohnal.chap.service.LoginResult.NO_PW;
import static com.ohnal.util.LoginUtils.*;


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

    // 회원 정보 수정 처리 서비스
    public void modify(SignUpRequestDTO dto, String savePath) {
        log.info("회원 정보 수정 처리 요청 들어옴! mapper로 접근합니다");
        memberMapper.modify(dto.toEntity(encoder, savePath));
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
                .profile(foundMember.getProfileImage())
                .loginMethod(foundMember.getLoginMethod().toString())
                .address(foundMember.getAddress())
                .gender(foundMember.getGender())
                .regDate(String.valueOf(foundMember.getRegDate()))
                .build();

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
}