package com.ohnal.chap.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;


@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class KakaoUserResponseDTO {
    private long id;

    @JsonProperty("connected_at")
    private LocalDateTime connectedAt;

    private Properties properties;

    @JsonProperty("kakao_account")
    private KakaoAccount account;


 @Setter @Getter @ToString
public static class Properties {
     private String nickname;
     @JsonProperty("profile_image")
     private String profileImage;
     @JsonProperty("thumnail_image")
     private String thumnailImage;
}

@Getter @Setter @ToString
public static class KakaoAccount {
     private String email;
}

}
