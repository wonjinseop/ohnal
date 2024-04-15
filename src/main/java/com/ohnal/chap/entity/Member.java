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
    private String name;
    private LocalDateTime regDate;

    private LocalDateTime limitTime;
    private String profileImage;
    private  LoginMethod loginMethod;

    public enum LoginMethod{
        COMMON,KAKAO
    }

}
