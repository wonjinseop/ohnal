package com.ohnal.chap.controller;

import com.ohnal.chap.common.PageMaker;
import com.ohnal.chap.common.Search;
import com.ohnal.chap.dto.request.BoardWriteRequestDTO;
import com.ohnal.chap.dto.response.BoardListResponseDTO;
import com.ohnal.chap.dto.response.BoardReplyResponseDTO;
import com.ohnal.chap.entity.Board;
import com.ohnal.chap.service.BoardService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardContoller {
    
    private final BoardService boardService;
    
    // 게시판 이동
    @GetMapping("/list")
    public String boardList(Model model, @ModelAttribute("s") Search page) {
        log.info("/board/list: GET!");
        
        List<BoardListResponseDTO> dtoList = boardService.findAll(page);
        PageMaker pageMaker = new PageMaker(page, boardService.getCount(page));
        
        model.addAttribute("bList", dtoList);
        model.addAttribute("maker", pageMaker);
        
        return "chap/board-list";
    }
    
    // 게시글 작성 페이지 이동
    @GetMapping("/write")
    public String write() {
        log.info("/board/write: GET");
        return "chap/new-writing";
    }
    
    // 게시글 등록
    @PostMapping("/write")
    public String write(BoardWriteRequestDTO dto, HttpSession session) {
        log.info("/board/write: POST, dto: {}", dto);
        
        boardService.save(dto, session);
        
        return "redirect:/board/list";
    }
    
    @GetMapping("/detail/{bno}")
    @ResponseBody
    public ResponseEntity<?> detail(@PathVariable int bno) {
        
        Board board = boardService.findOne(bno);
        BoardListResponseDTO dto = new BoardListResponseDTO(board);
        
        return ResponseEntity.ok().body(dto);
    }
    
    @GetMapping("/reply/{bno}")
    @ResponseBody
    public ResponseEntity<?> reply(@PathVariable int bno) {
        
        List<BoardReplyResponseDTO> replyList = boardService.getReplyList(bno);
        
        return ResponseEntity.ok().body(replyList);
    }
    
    @PostMapping("/reply")
    public ResponseEntity<?> writeReply(@Validated @RequestBody ReplyPostRequestDTO dto,
                                        BindingResult result) {
        
        String email = "user123@naver.com";
        String nickname = "user";
        
        if (result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString());
        }
        
        log.info("/board/reply/write: POST");
        
        boardService.writeReply(dto, email, nickname);
        
        return ResponseEntity.ok().body("success");
    }
    
    
    
}
