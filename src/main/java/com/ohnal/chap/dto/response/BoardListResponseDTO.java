package com.ohnal.chap.dto.response;

import com.ohnal.chap.entity.Board;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

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
    private String profileImage;
    private String email;
    private int likeNo;
    private String likeEmail;

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
        this.profileImage = board.getProfileImage();
        this.email = board.getEmail();
        this.likeNo = board.getLikeNo();
        this.likeEmail = board.getLikeEmail();
    }

    // 뷰카운트 표시방식 변경
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

    // 시간 표기
    public static String makePrettierDateString(LocalDateTime regDate) {

        // 현재 시간
        LocalDateTime currentTime = LocalDateTime.now();

        // 두 시간 사이의 차이 계산
        Duration duration = Duration.between(regDate, currentTime);
        long seconds = duration.toSeconds();
        long minutes = duration.toMinutes();
        long hoursDifference = duration.toHours();

        String time = "";
        if (seconds < 60) {
            time = seconds + "초 전";
        } else if (minutes < 60) {
            time = minutes + "분 전";
        } else if (hoursDifference < 24) {
            time = hoursDifference + "시간 전";
        } else if (hoursDifference < 168) {
            time = duration.toDays() + "일 전";
        } else {
            time = ChronoUnit.WEEKS.between(regDate, currentTime) + "주 전";
        }

        return time;
    }

    // 좋아요수 표기
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

    // 댓글 수 표기
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