package com.ohnal.chap.service;
import com.ohnal.chap.common.Search;
import com.ohnal.chap.dto.request.BoardWriteRequestDTO;
import com.ohnal.chap.dto.response.BoardListResponseDTO;
import com.ohnal.chap.entity.Board;
import com.ohnal.chap.mapper.BoardMapper;
import com.ohnal.util.LoginUtils;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class BoardService {
    
    private final BoardMapper mapper;
    
    // 게시글 전체 조회
    public List<BoardListResponseDTO> findAll(Search page) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = mapper.findAll(page);
        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            dtoList.add(dto);
        }
        
        return dtoList;
    }
    
    // 게시글 등록
    public void save(BoardWriteRequestDTO dto, HttpSession session) {
        Board board = new Board(dto);
        
        board.setEmail(LoginUtils.getLoginUserEmail(session));
        
        mapper.save(board);
        
    }
    
    // 페이징
    public int getCount(Search page) {
        return mapper.getCount(page);
    }
    
    public Board findOne(int bno) {
        return mapper.findOne(bno);
    }
}
