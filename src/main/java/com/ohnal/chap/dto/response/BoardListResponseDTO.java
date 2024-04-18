package com.ohnal.chap.dto.response;

import com.ohnal.chap.entity.Board;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

import java.time.Duration;
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
    private String viewCount;
    
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
        this.viewCount = makePrettierViewCount(board.getViewCount());
    }
    
    private String makePrettierViewCount(int viewCount) {
        String result;
        if (viewCount > 1000) {
            double num = viewCount / 1000.0;
            result = String.format("%.1f천", num);
        } else if (viewCount == 1000) {
            int num = viewCount / 1000;
            result = String.format("%d천", num);
        } else {
            result = String.valueOf(viewCount);
        }
        return result;
    }
    
    public static String makePrettierDateString(LocalDateTime regDate) {
        
        // 현재 시간
        LocalDateTime currentTime = LocalDateTime.now();
        
        // 두 시간 사이의 차이 계산
        Duration duration = Duration.between(regDate, currentTime);
        String hoursDifference = String.valueOf(duration.toHours()); // 시간 단위로 차이 계산
        
        String time = hoursDifference;
        
        return time + "시간 전";
    }
    
    public static String makePrettierLikeCount(int likeCount) {
        String result;
        if (likeCount == 1000) {
            int num = likeCount / 1000;
            result = String.format("%d천", num);
        } else if (likeCount > 1000) {
            double num = likeCount / 1000.0;
            result = String.format("%.1f천", num);
        } else {
            result = String.valueOf(likeCount);
        }
        return result;
    }
    
    public static String makePrettierReplyCount(int replyCount) {
        String result;
        if (replyCount > 1000) {
            double num = replyCount / 1000.0;
            result = String.format("%.1f천", num);
        } else if (replyCount == 1000) {
            int num = replyCount / 1000;
            result = String.format("%d천", num);
        } else {
            result = String.valueOf(replyCount);
        }
        return result;
    }
    
}
