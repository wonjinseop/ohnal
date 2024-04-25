package com.ohnal.chap.dto.response;

import com.ohnal.chap.entity.Reply;
import lombok.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class BoardReplyResponseDTO {
    
    private int replyNo;
    private String email, content, profileImage, nickname;
    private String time;
    
    public BoardReplyResponseDTO(Reply reply) {
        
        this.replyNo = reply.getReplyNo();
        this.email = reply.getEmail();
        this.content = reply.getContent();
        this.profileImage = reply.getProfileImage();
        this.nickname = reply.getNickname();
        this.time = makePrettierDateString(reply.getRegDate());

        if(reply.getProfileImage() == null) { // 설정된 이미지 정보가 없으면
            this.profileImage = "/assets/img/anonymous-image.png"; // 기본 프로필 사진
        } else if(reply.getProfileImage().contains("/profile")) { // 설정한 이미지 정보가 있고, profile 경로로 시작하면
            this.profileImage = "/display" + reply.getProfileImage();
        } else { // profile 경로로 시작하지 않음(예: 카카오 로그인)
            this.profileImage = reply.getProfileImage();
        }
        
    }
    
    public static String makePrettierDateString(LocalDateTime regDate) {
        
        // 현재 시간
        LocalDateTime currentTime = LocalDateTime.now();
        
        // 두 시간 사이의 차이 계산
        Duration duration = Duration.between(regDate, currentTime);
        long seconds = duration.toSeconds(); // 초
        long minutes = duration.toMinutes(); // 분
        long hoursDifference = duration.toHours(); // 시간 단위로 차이 계산
        
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
    
}
