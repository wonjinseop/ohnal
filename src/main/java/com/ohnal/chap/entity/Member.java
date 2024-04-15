package com.ohnal.chap.entity;

import java.time.LocalDateTime;

public class Member {

    private String email;
    private String password;
    private String name;
    private LocalDateTime regDate;

    private LocalDateTime limitTime;
    private String profileImage;
    private LoginMethod loginMethod;


    private class LoginMethod {

    }
}
