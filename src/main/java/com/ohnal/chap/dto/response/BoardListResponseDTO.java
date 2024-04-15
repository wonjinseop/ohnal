package com.ohnal.chap.dto.response;

import com.ohnal.chap.entity.Board;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter @ToString
@EqualsAndHashCode
public class BoardListResponseDTO {
    
    private int boardNo;
    private String nickname;
    private String content;
    private String image;
    private String likeCount;
    private String replyCount;
    private String locationTag;
    private String weatherTag;
    private String regDate;
    
    public BoardListResponseDTO(Board board) {
        this.boardNo = board.getBoardNo();
        this.nickname = board.getNickname();
        this.content = board.getContent();
        this.image = board.getImage();
        this.locationTag = board.getLocationTag();
        this.weatherTag = board.getWeatherTag();
        this.regDate = makePrettierDateString(board.getRegDate());
        this.likeCount = makePrettierLikeCount(board.getLikeCount());
        this.replyCount = makePrettierReplyCount(board.getReplyCount());
    }
    
    public static String makePrettierDateString(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dtf.format(regDate);
    }
    
    public static String makePrettierLikeCount(int likeCount) {
        String result;
        if (likeCount >= 1000) {
            double count = likeCount * 0.001;
            result = String.valueOf(Math.floor(count * 10)/10);
        } else {
            result = String.valueOf(likeCount);
        }
        return result;
    }
    
    public static String makePrettierReplyCount(int likeCount) {
        String result;
        if (likeCount >= 1000) {
            double count = likeCount * 0.001;
            result = String.valueOf(Math.floor(count * 10)/10);
        } else {
            result = String.valueOf(likeCount);
        }
        return result;
    }
    
}
