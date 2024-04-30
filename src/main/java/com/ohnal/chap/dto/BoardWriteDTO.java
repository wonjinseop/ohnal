package com.ohnal.chap.dto;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardWriteDTO {
    
    private String content;
    private String image;
    private String locationTag;
    private String weatherTag;

}
