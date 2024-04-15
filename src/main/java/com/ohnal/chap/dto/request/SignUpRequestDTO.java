package com.ohnal.chap.dto.request;

import com.ohnal.chap.entity.Member;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.*;
import org.springframework.context.annotation.Primary;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

@Setter @Getter @ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class SignUpRequestDTO {

    @NotBlank
    @Email
    private String email;
    @NotBlank
    private  String password;
    @NotBlank
    private  String name;

    private MultipartFile profileImage;
    private Member.LoginMethod loginMethod;

    public Member toEntity(PasswordEncoder encoder, String savePath) {
        return Member.builder()
                .email(email)
                .password(encoder.encode(password))
                .name(name)
                .profileImage(savePath)
                .loginMethod(loginMethod)
                .build();
    }


}
