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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.lang.reflect.Type;
import java.util.List;

import static com.ohnal.util.FileUtils.uploadFile;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardContoller {
    
    @Value("${file.upload.root-path}")
    String rootPath;
    
    private final BoardService boardService;
    
    // 게시판 이동
    @GetMapping("/list")
    public String boardList(Model model, @ModelAttribute("s") Search page) {
        log.info("/board/list: GET!");
        
        List<BoardListResponseDTO> dtoList = boardService.findAll(page);
        PageMaker pageMaker = new PageMaker(page, boardService.getCount());
        
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
        log.info("attached file name: {}", dto.getImage().getOriginalFilename());
        
        rootPath = rootPath + "/ootd";
        
        String savePath = "/ootd" + uploadFile(dto.getImage(), rootPath);
        
        log.info("save-path: {}", savePath);
        
        
        boardService.save(dto, session, savePath);
        
        return "redirect:/board/list";
    }
    
    // 게시글 자세히보기
    @GetMapping("/detail/{bno}")
    
    @ResponseBody
    public ResponseEntity<?> detail(@PathVariable int bno) {
        
        Board board = boardService.findOne(bno);
        BoardListResponseDTO dto = new BoardListResponseDTO(board);
        
        return ResponseEntity.ok().body(dto);
    }
    
    // 댓글 창 불러오기
    @GetMapping("/reply/{bno}")
    @ResponseBody
    public ResponseEntity<?> reply(@PathVariable int bno) {
        
        List<BoardReplyResponseDTO> replyList = boardService.getReplyList(bno);
        
        return ResponseEntity.ok().body(replyList);
    }
    
    // 댓글 쓰기
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
        
        log.info("/board/reply: POST");
        
        boardService.writeReply(dto, email, nickname);
        
        return ResponseEntity.ok().body("success");
    }

}
