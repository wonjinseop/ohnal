package com.ohnal.chap.entity;

import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {
    
    private int board_no;
    private String nickname;
    private String content;
    private String image;
    private int likeCount;
    private int replyCount;
    private String locationTag;
    private String weatherTag;
    private LocalDateTime regDate;
    
    
}
