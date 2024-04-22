package com.ohnal.chap.service;
import com.ohnal.chap.common.Page;
import com.ohnal.chap.common.Search;
import com.ohnal.chap.controller.ReplyPostRequestDTO;
import com.ohnal.chap.dto.request.BoardWriteRequestDTO;
import com.ohnal.chap.dto.response.BoardListResponseDTO;
import com.ohnal.chap.dto.response.BoardReplyResponseDTO;
import com.ohnal.chap.entity.Board;
import com.ohnal.chap.entity.Reply;
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
    public void save(BoardWriteRequestDTO dto, HttpSession session, String savePath) {
        Board board = new Board(dto, savePath);
        log.info(dto.toString());
        
//        board.setEmail("user123@naver.com");
        board.setEmail(LoginUtils.getCurrentLoginMemberEmail(session));
        
        mapper.save(board);
    }
    
    // 페이징
    public int getCount() {
        return mapper.getCount();
    }
    
    public Board findOne(int bno) {
        mapper.updateCount(bno, "view");
        return mapper.findOne(bno);
    }
    
    public List<BoardReplyResponseDTO> getReplyList(int bno) {
        List<BoardReplyResponseDTO> dtoList = new ArrayList<>();
        List<Reply> replyList = mapper.replyList(bno);
        
        for (Reply reply : replyList) {
            BoardReplyResponseDTO dto = new BoardReplyResponseDTO(reply);
            dtoList.add(dto);
        }
        
        return dtoList;
    }
    
    public void writeReply(ReplyPostRequestDTO dto) {
        
        Reply reply = dto.toEntity();
        
        mapper.replySave(reply);
        
        mapper.updateCount(dto.getBno(), "replies");
    }


    //------------------my history------------------
    public List<BoardListResponseDTO> findAllByEmail(String loginUserEmail, Page page) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = mapper.findAllByEmail(loginUserEmail, page);
        log.info("boardList: {}", boardList);

        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            log.info("new BoardListResponseDTO(board): {}", dto);
            dtoList.add(dto);
        }
        log.info("dtoList: {}", dtoList);
        return dtoList;
    }

    public int getMyPostsCount(String loginUserEmail) {
        return mapper.getMyPostsCount(loginUserEmail);
    }

    public void delete(int bno) {

        mapper.delete(bno);

    }

    // ----------------- my-history에서 작성한 글(버튼) 누름 -----------------
    public List<BoardListResponseDTO> myPosts(String email) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = mapper.myPosts(email);

        log.info("boardList: {}", boardList);

        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            log.info("new BoardListResponseDTO(board): {}", dto);
            dtoList.add(dto);
        }
        log.info("dtoList: {}", dtoList);
        return dtoList;
    }

    public List<BoardListResponseDTO> myWriteReply(String email) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = mapper.myWriteReply(email);

        log.info("boardList: {}", boardList);

        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            log.info("new BoardListResponseDTO(board): {}", dto);
            dtoList.add(dto);
        }
        log.info("dtoList: {}", dtoList);
        return dtoList;

    }
}
