package com.ohnal.chap.entity;

import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {

    private String email;
    private String password;
    private String nickname;
    private String Auth;
    private String gender;
    private String address;
    private String profileImage;
    private LoginMethod loginMethod;
    private LocalDateTime regDate;
    private String sessionId;
    private LocalDateTime limitTime;


    public enum LoginMethod{
        COMMON,KAKAO,NAVER,GOOGLE
    }

}