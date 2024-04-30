package com.ohnal.chap.service;

import com.ohnal.chap.common.Page;
import com.ohnal.chap.common.Search;
import com.ohnal.chap.controller.ReplyPostRequestDTO;
import com.ohnal.chap.dto.request.BoardLikeRequestDTO;
import com.ohnal.chap.dto.request.BoardReplyDeleteRequestDTO;
import com.ohnal.chap.dto.request.BoardReplyModifyRequestDTO;
import com.ohnal.chap.dto.response.BoardListResponseDTO;
import com.ohnal.chap.dto.response.BoardReplyResponseDTO;
import com.ohnal.chap.dto.BoardWriteDTO;
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
    public List<BoardListResponseDTO> findAll(Search page, String email) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = mapper.findAll(page, email);
        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            dtoList.add(dto);
        }

        return dtoList;
    }

    // 게시글 등록
    public void save(BoardWriteDTO dto, HttpSession session, String savePath) {
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

    // 게시글 하나 조회
    public Board findOne(int bno) {
        mapper.updateCount(bno, "view");
        return mapper.findOne(bno);
    }

    // 댓글 목록 불러오기
    public List<BoardReplyResponseDTO> getReplyList(int bno) {
        List<BoardReplyResponseDTO> dtoList = new ArrayList<>();
        List<Reply> replyList = mapper.replyList(bno);

        for (Reply reply : replyList) {
            BoardReplyResponseDTO dto = new BoardReplyResponseDTO(reply);
            dtoList.add(dto);
        }

        return dtoList;
    }

    // 댓글 작성 기능
    public void writeReply(ReplyPostRequestDTO dto) {

        Reply reply = dto.toEntity();

        mapper.replySave(reply);

        mapper.updateCount(dto.getBno(), "replies");
    }

    // 글 삭제
    public void delete(int bno) {

        mapper.delete(bno);
        mapper.deleteReplyToBno(bno);
        mapper.deleteLikeToBno(bno);

    }

    // 게시글에 이용자가 좋아요를 누른적이 있는지 확인하는 기능
    public boolean findLike(BoardLikeRequestDTO dto) {
        return mapper.findLike(dto);
    }

    // 좋아요 기능
    public void insertLike(BoardLikeRequestDTO dto) {
        mapper.insertLike(dto);
        mapper.updateCount(dto.getBno(), "likePlus");
    }

    // 좋아요 취소 기능
    public void deleteLike(BoardLikeRequestDTO dto) {
        mapper.deleteLike(dto);
        mapper.updateCount(dto.getBno(), "likeMinus");
    }

    //  findBestOOTD
    public List<BoardListResponseDTO> findBestOOTD(String email) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = mapper.findBestOOTD(email);
        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            dtoList.add(dto);
        }

        return dtoList;
    }

    public List<BoardListResponseDTO> findMyLikePosts(String email, Page page) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();

        List<Board> boardList = mapper.findMyLikePosts(email, page);

        log.info("boardList: {}", boardList);

        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            dtoList.add(dto);
        }

        log.info("내가 좋아요한 글이 작성된 게시글 목록: {}", dtoList);
        return dtoList;
    }


    public void deleteReply(int rno, int bno) {
        mapper.deleteReply(rno);
        mapper.updateCount(bno, "replyDelete");
    }

    // 내가 작성한 댓글이 작성되어 있는 게시글을 찾아오는 메서드 (작성 댓글 버튼 눌렀을 때)
    public List<BoardListResponseDTO> findMyComments(String email, Page page) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();

        List<Board> boardList = mapper.findMyComments(email, page);

        log.info("boardList: {}", boardList);

        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            dtoList.add(dto);
        }

        log.info("내가 좋아요한 글이 작성된 게시글 목록: {}", dtoList);
        return dtoList;
    }


    public boolean findReply(BoardReplyDeleteRequestDTO dto) {
        return mapper.findReply(dto);
    }

    public List<BoardListResponseDTO> findAllByEmail(String email, Page page) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();

        List<Board> boardList = mapper.findAllByEmail(email, page);

        log.info("boardList: {}", boardList);

        for (Board board : boardList) {
            BoardListResponseDTO dto = new BoardListResponseDTO(board);
            dtoList.add(dto);
        }

        log.info("내가 작성한 글이 작성된 게시글 목록: {}", dtoList);
        return dtoList;
    }

    public void modifyReply(BoardReplyModifyRequestDTO dto) {
        mapper.modifyReply(dto);
    }

    public int findAllMyPostsCount(String email) {
        return mapper.findAllMyPostsCount(email);
    }

    public int findAllMyComments(String email) { return mapper.findAllMyComments(email); }

    public int findMyLikeCount(String email) { return mapper.findMyLikeCount(email); }
}

//----------------- 컬렉션 size() 로 게시물 총 갯수 구하기로 정함 -----------------

// public int getMyLikeCount(String email) { return mapper.getMyLikeCount(email); }

// my-history에서 내가 작성한 게시물 총 갯수를 가져오는 메서드
//public int getMyPostsCount(String email) { return mapper.getMyPostsCount(email); }


// 내가 작성한 댓글이 작성되어 있는 게시글을 찾아오는 메서드에 사용되는
// 내가 작성한 댓글을 가진 게시판에 올라간 게시물의 총 개수를 가져오는 메서드
// 내가 작성한 댓글 수와 내가 작성한 댓글 수를 가지고 있는 게시물의 수가 다른 이슈로
// 내가 작성한 댓글 수를 가진 게시물을 불러오는 쪽으로 택함.
// public int getMyCommentsCount(String email) { return mapper.getMyCommentsCount(email); }
