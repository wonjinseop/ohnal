package com.ohnal.chap.mapper;

import com.ohnal.chap.dto.request.AutoLoginDTO;
import com.ohnal.chap.entity.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    void save(Member member);

    Member findMember(String email);

    boolean isDuplicate(@Param("type")String type,@Param("keyword")String keyword);
    void saveAutoLogin(AutoLoginDTO build);

    Member findMemberByCookie(String sessionId);

    void modify(Member member);
}
