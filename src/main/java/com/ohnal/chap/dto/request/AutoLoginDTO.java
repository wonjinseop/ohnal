package com.ohnal.chap.dto.request;

import lombok.*;

import java.time.LocalDateTime;

@Setter @Getter @ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AutoLoginDTO {
    public  String sessionId;
    private LocalDateTime limitTime;
    private String email;
}
