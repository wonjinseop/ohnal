package com.ohnal.chap.mapper;

import com.ohnal.chap.entity.Member;
import org.apache.ibatis.annotations.Param;

public interface MemberMapper {

    Member findMember(String account);


    //중복체크
    boolean inDuplicate(@Param("type") String type , @Param("keyword") String keyword);




}
