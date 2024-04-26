package com.ohnal.chap.mapper;

import com.ohnal.chap.common.Page;
import com.ohnal.chap.common.Search;
import com.ohnal.chap.dto.request.BoardLikeRequestDTO;
import com.ohnal.chap.dto.request.BoardReplyDeleteRequestDTO;
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


    // ------------my-history--------------
    // my-history 에서 내가 쓴 글을 조회하는 sql문과 연결되어 있음
    List<Board> findAllByEmail(@Param("email")String email,@Param("page")Page page);
    List<Board> findMyComments(String email);


    // my-history 에서 작성한 글 버튼 누를 때, 작동하는 sql문
    List<Board> myPosts(String email);
    int getMyPostsCount(String email);



    // my-history 에서 작성 댓글 버튼 누를 때, 작동하는 sql문
    // --> 페이지네이션을 위해 내가 작성한 댓글을 보유한 게시물 개수를 조회하는 sql문
    int getMyCommentsCount(String email);
    // my-history 에서 작성 댓글 버튼 누를 때, 작동하는 sql문
    List<Board> myWriteReply(String email);


    // my-history 에서 좋아요한 글 버튼 누를 때, 작동하는 sql문
    List<Board> findMyLikePosts(String email);
    int getMyLikeCount(String email);

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


    List<Board> findBestOOTD(String email);
}