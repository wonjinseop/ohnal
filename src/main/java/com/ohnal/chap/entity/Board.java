package com.ohnal.chap.entity;

import com.ohnal.chap.dto.BoardWriteDTO;
import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {
    
    private int boardNo;
    private String nickname;
    private String email;
    private String content;
    private String image;
    private int viewCount;
    private int likeCount;
    private int replyCount;
    private String locationTag;
    private String weatherTag;
    private LocalDateTime regDate;
    private String profileImage;
    private int likeNo;
    private String likeEmail;
    
    public Board(BoardWriteDTO dto, String savePath) {
        this.content = dto.getContent();
        this.image = savePath;
        this.locationTag = dto.getLocationTag();
        this.weatherTag = dto.getWeatherTag();
    }
    
}
