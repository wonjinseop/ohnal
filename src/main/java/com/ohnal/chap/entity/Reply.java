package com.ohnal.chap.entity;

import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reply {
    
    private int replyNo;
    private int bno;
    private String email;
    private String content;
    private String profileImage;
    private String nickname;
    private LocalDateTime regDate;
    
}
