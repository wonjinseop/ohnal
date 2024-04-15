package com.ohnal.chap.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardContoller {
    
    // 게시판 이동
    @GetMapping("/list")
    public String boardList() {
        log.info("/board/list 요청 들어옴: GET!");
        
        return "chap/board-list";
    }
    
}
