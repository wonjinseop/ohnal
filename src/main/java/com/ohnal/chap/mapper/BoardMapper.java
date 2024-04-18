package com.ohnal.chap.mapper;

import com.ohnal.chap.common.Search;
import com.ohnal.chap.entity.Board;
import com.ohnal.chap.entity.Reply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    
    List<Board> findAll(Search page);
    
    void save(Board dto);
    
    int getCount(Search page);
    
    Board findOne(int bno);
    
    void updateViewCount(int bno);
    
    List<Reply> replyList(int bno);
    
    void replySave(Reply reply);
}
