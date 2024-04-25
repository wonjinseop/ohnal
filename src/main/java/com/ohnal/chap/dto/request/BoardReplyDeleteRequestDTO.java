package com.ohnal.chap.dto.request;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class BoardReplyDeleteRequestDTO {
    
    private int bno;
    private int rno;
    private String email;
    
}
