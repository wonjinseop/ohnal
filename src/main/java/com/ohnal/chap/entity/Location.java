package com.ohnal.chap.entity;

import lombok.*;

@Getter @Setter @ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Location {
    private String area1;
    private String area2;
    private int nx;
    private int ny;
}
