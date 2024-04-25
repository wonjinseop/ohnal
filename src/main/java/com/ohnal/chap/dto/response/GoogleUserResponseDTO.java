package com.ohnal.chap.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.LocalDateTime;


@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class GoogleUserResponseDTO {

    @JsonProperty("given_name")
    private String nickname;

    private String email;

}
