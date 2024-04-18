package com.ohnal.chap.controller;

import com.ohnal.chap.entity.Reply;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyPostRequestDTO {
    
    @NotBlank
    @Size(min = 1, max =  300)
    private String text;
    
    @NotNull
    private int bno;
    
    // dto를 entity로 바꾸는 메서드
    public Reply toEntity(String nickname) {
        return Reply.builder()
                .content(this.text)
                .bno(this.bno)
                .nickname(nickname)
                .build();
    }
    
    
    
    
}
