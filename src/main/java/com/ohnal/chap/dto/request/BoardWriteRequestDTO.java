package com.ohnal.chap.dto.request;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class BoardWriteRequestDTO {
    
    private String nickname;
    private String content;
    private String image;
    private String locationTag;
    private String weatherTag;

}
