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
    private String name;
    private String gender;
    private String address;
    private String Auth;
    private LocalDateTime regDate;

    private LocalDateTime limitTime;
    private String sessionId;

    private String profileImage;
    private  LoginMethod loginMethod;

    public enum LoginMethod{
        COMMON,KAKAO
    }

}