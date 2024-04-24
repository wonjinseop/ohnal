package com.ohnal.chap.dto.request;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class BoardLikeRequestDTO {

    private String email;
    private int bno;

}