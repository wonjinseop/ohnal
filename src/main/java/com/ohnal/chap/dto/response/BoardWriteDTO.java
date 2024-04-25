package com.ohnal.chap.dto.response;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardWriteDTO {

    private String nickname;
    private String content;
    private String image;
    private String locationTag;
    private String weatherTag;

}
