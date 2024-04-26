package com.ohnal.chap.dto.request;

import lombok.*;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class BoardReplyModifyRequestDTO {
    
    private int rno;
    private String content;
    
}
