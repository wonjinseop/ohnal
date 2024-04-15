package com.ohnal.chap.mapper;

import org.apache.ibatis.annotations.Param;

public interface MemberMapper {

    //중복체크
    boolean inDuplicate(@Param("type") String type , @Param("keyword") String keyword);



}
