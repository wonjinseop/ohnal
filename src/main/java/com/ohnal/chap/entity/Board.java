package com.ohnal.chap.entity;

import com.ohnal.chap.dto.request.BoardWriteRequestDTO;
import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {
    
    private int boardNo;
    private String email;
    private String nickname;
    private String content;
    private String image;
    private int viewCount;
    private int likeCount;
    private int replyCount;
    private String locationTag;
    private String weatherTag;
    private LocalDateTime regDate;
    
    public Board(BoardWriteRequestDTO dto, String savePath) {
        this.nickname = dto.getNickname();
        this.content = dto.getContent();
        this.image = savePath;
        this.locationTag = dto.getLocationTag();
        this.weatherTag = dto.getWeatherTag();
    }
    
}
