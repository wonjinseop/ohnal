package com.ohnal.chap.dto.response;
import lombok.*;
import org.springframework.boot.autoconfigure.web.WebProperties;

@Getter @Setter @ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class LoginUserResponseDTO {

    private String email;
    private String nickname;
    private String profile;
    private String auth;
    private String loginMethod;
    private String address;
    private String gender;
    private String regDate;
    private String password;
}
