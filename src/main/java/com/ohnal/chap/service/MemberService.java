package com.ohnal.chap.service;

import com.ohnal.chap.dto.LoginRequestDTO;
import com.ohnal.chap.entity.Member;
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


        Member foundMember = memberMapper.findMember(dto.getAddress());
        if (foundMember == null) {
            return LoginResult.NO_ACC;
        }
        String inputPassword = dto.getPassword();
        String realPassword = foundMember.getPassword();

        if (!encoder.matches(inputPassword,realPassword)) {
             return  LoginResult.NO_PW;
        }

    
        
          return LoginResult.SUCCESS;
    }
    

}
