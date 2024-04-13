package com.ohnal.chap.controller;

import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ControllerExample {



    @GetMapping("/index")
    private String veiwIndex() {

        return "chap/index";
    }

    @GetMapping("/board/list")
    public String showBoard() {

        return "chap/board-list";
    }

}
