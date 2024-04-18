package com.ohnal.chap.dto.response;

import com.ohnal.chap.entity.Reply;
import lombok.*;

import java.time.Duration;
import java.time.LocalDateTime;

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
        
    }
    
    public static String makePrettierDateString(LocalDateTime regDate) {
        
        // 현재 시간
        LocalDateTime currentTime = LocalDateTime.now();
        
        // 두 시간 사이의 차이 계산
        Duration duration = Duration.between(regDate, currentTime);
        long hoursDifference = duration.toHours(); // 시간 단위로 차이 계산
        
        String time = String.valueOf(hoursDifference);
        
        return time + "시간 전";
    }
    
}
