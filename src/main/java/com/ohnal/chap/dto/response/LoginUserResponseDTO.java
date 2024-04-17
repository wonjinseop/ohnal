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
    private  String name;
    private String profile;
    private String loginMethod;

}

