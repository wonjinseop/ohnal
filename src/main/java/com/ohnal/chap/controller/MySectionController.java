package com.ohnal.chap.controller;

import com.ohnal.chap.dto.request.SignUpRequestDTO;
import com.ohnal.chap.service.MemberService;
import com.ohnal.util.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MySectionController {
    private final MemberService memberService;

    @Value("${file.upload.root-path}")
    private String rootPath;

    @GetMapping("/members/my-info")
    public String myPage() {
        return "chap/my-info";
    }

    @PostMapping("/modify-info")
    public String modifyInfo(SignUpRequestDTO dto) {
        log.info("modify info 요청 들어옴!");

        if (!rootPath.contains("/profile")) {
            rootPath = rootPath + "/profile";
        }

        String savePath = "/profile" + FileUtils.uploadFile(dto.getProfileImage(), rootPath);
        log.info("save-path: {}", savePath);

        memberService.modify(dto, savePath);

        return "redirect:/members/sign-out";
    }
}
