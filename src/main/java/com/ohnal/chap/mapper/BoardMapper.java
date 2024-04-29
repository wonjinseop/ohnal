package com.ohnal.chap.mapper;

import com.ohnal.chap.common.Page;
import com.ohnal.chap.common.Search;
import com.ohnal.chap.dto.request.BoardLikeRequestDTO;
import com.ohnal.chap.dto.request.BoardReplyDeleteRequestDTO;
import com.ohnal.chap.dto.request.BoardReplyModifyRequestDTO;
import com.ohnal.chap.entity.Board;
import com.ohnal.chap.entity.Reply;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {

    List<Board> findAll(@Param("search") Search page, @Param("email") String email);

    void save(Board board);

    int getCount();

    Board findOne(int bno);

    void updateCount(@Param("bno") int bno, @Param("count") String count);

    List<Reply> replyList(int bno);

    void replySave(Reply reply);




    // 글 삭제
    void delete(int bno);

    // 좋아요 내역 확인
    boolean findLike(BoardLikeRequestDTO dto);

    // 좋아요
    void insertLike(BoardLikeRequestDTO dto);

    // 좋아요 취소
    void deleteLike(BoardLikeRequestDTO dto);


    void deleteReply(int rno);

    boolean findReply(BoardReplyDeleteRequestDTO dto);
    
    void deleteReplyToBno(int bno);
    
    void deleteLikeToBno(int bno);
    
    void modifyReply(BoardReplyModifyRequestDTO dto);


    List<Board> findBestOOTD(String email);


    // ------------my-history--------------
    // my-history 에서 내가 쓴 글을 조회하는 sql문과 연결되어 있음
    List<Board> findAllByEmail(@Param("email")String email,@Param("page")Page page);
    List<Board> findMyComments(@Param("email")String email,@Param("page")Page page);

    List<Board> findMyLikePosts(@Param("email")String email,@Param("page")Page page);

    int findAllMyPostsCount(String email);

    int findAllMyComments(String email);

    int findMyLikeCount(String email);
}