package com.ohnal.chap.mapper;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public enum Auth {

    COMMON("일반사용자", 1),
    ADMIN("관리자", 2);

    private String description;
    private int authNumber;
}
