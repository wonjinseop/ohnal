package com.ohnal.chap.dto.request;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class BoardWriteRequestDTO {
    
    private String nickname;
    private String content;
    private MultipartFile image;
    private String locationTag;
    private String weatherTag;

}
