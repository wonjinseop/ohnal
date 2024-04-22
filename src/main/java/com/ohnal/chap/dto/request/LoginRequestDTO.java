package com.ohnal.chap.dto.request;

import lombok.*;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginRequestDTO {
    private String nickname;
    private String email;
    private  String password;
    private  boolean autoLogin;
}



