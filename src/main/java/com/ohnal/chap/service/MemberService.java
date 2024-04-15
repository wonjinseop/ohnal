package com.ohnal.chap.service;

import com.ohnal.chap.dto.LoginRequestDTO;
import com.ohnal.chap.mapper.MemberMapper;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberService {
    private final MemberMapper memberMapper;
    private final PasswordEncoder encoder;

    public LoginResult authenticate(LoginRequestDTO dto,
                                    HttpSession session , HttpServletResponse response) {
        return null;
    }

}
