package com.ohnal.chap.controller;

import com.ohnal.chap.dto.request.ModifyRequestDTO;
import com.ohnal.chap.dto.response.LoginUserResponseDTO;
import com.ohnal.chap.service.MemberService;
import com.ohnal.util.FileUtils;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import static com.ohnal.util.LoginUtils.getCurrentLoginMemberEmail;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MySectionController {
    private final MemberService memberService;

    @Value("${file.upload.root-path}")
    private String rootPath;

    @GetMapping("/members/my-info")
    public String myInfo(HttpSession session, Model model) {

        log.info("my-info 요청 들어옴!");
        String loginMemberEmail = getCurrentLoginMemberEmail(session);
        LoginUserResponseDTO memberInfo = memberService.getMemberInfo(loginMemberEmail);
        model.addAttribute("memberInfo", memberInfo);

        return "chap/my-info";
    }

    @GetMapping("/members/changePassword")
    private String changePassword() {
        return "chap/change-pw";
    }

    @PostMapping("/members/changePassword")
    private String pwChange(String email, String password) {
        log.info("비밀번호 변경 요청이 들어옴!!");
        memberService.changePassword(email, password);
        return "redirect:/members/my-info";
    }

    @PutMapping("/modify-profile")
    @ResponseBody
    private void modifyProfile(HttpSession session, @RequestBody MultipartFile profileImage) {
        log.info("프로필 사진 변경 요청이 들어옴!");
        if (!rootPath.contains("/profile")) {
            rootPath = rootPath + "/profile";
        }

        String loginMemberEmail = getCurrentLoginMemberEmail(session);
        String savePath = "/profile" + FileUtils.uploadFile(profileImage, rootPath);
        memberService.modifyProfileImage(loginMemberEmail, savePath);
        log.info("프로필 사진 변경 저장 완료!");
    }

    @PostMapping("/modify-info")
    public String modifyInfo(ModifyRequestDTO dto, HttpSession session) {
        log.info("modify info 요청 들어옴!");
        log.info(dto.toString());

        memberService.modifyInfo(dto);
        memberService.maintainLoginState(session, dto.getEmail()); // 바뀐 정보로 세션 업데이트


        return "redirect:/members/my-info";
    }
}
