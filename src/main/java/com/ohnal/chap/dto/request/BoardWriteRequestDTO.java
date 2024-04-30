package com.ohnal.chap.dto.request;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class BoardWriteRequestDTO {

    private String content;
    private MultipartFile image;
    private String valueArea1;
    private String valueArea2;

}
