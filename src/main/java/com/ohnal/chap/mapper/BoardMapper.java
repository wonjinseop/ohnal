package com.ohnal.chap.mapper;

import com.ohnal.chap.common.Search;
import com.ohnal.chap.dto.request.BoardWriteRequestDTO;
import com.ohnal.chap.entity.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    
    List<Board> findAll(Search page);
    
    void save(BoardWriteRequestDTO dto);
    
    int getCount(Search page);
}
