package com.ohnal.chap.mapper;

import com.ohnal.chap.common.Search;
import com.ohnal.chap.entity.Board;
import com.ohnal.chap.entity.Reply;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {
    
    List<Board> findAll(Search page);

    // my-history 에서 내가 쓴 글을 조회하는 sql문과 연결되어 있음
    List<Board> findAllMyPosts(@Param("email") String email,@Param("page") Search page);
    
    void save(Board board);
    
    int getCount();
    
    Board findOne(int bno);
    
    void updateCount(@Param("bno") int bno, @Param("count") String count);
    
    List<Reply> replyList(int bno);
    
    void replySave(Reply reply);
}
