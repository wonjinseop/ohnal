package com.ohnal.chap.controller;

import com.ohnal.chap.dto.response.BoardListResponseDTO;
import com.ohnal.chap.dto.response.LoginUserResponseDTO;
import com.ohnal.chap.dto.response.WeatherInfoResponseDTO;
import com.ohnal.chap.entity.Board;
import com.ohnal.chap.service.BoardService;
import com.ohnal.chap.service.MemberService;
import com.ohnal.chap.service.WeatherService;
import com.ohnal.util.LoginUtils;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class WeatherController {
    private final WeatherService weatherService;
    private final BoardService boardService;
    private final MemberService memberService;

    // 메인 홈페이지 접속 url 매핑
    @GetMapping ("/index")
    public String veiwIndex(Model model, HttpSession session) {
        log.info("/index 요청 들어옴");
        String area1 = "";
        String area2 = "";
        
        String email = LoginUtils.getCurrentLoginMemberEmail(session);
        log.info("email: {}", email);

        if (email == null) {
            area1 = "서울특별시";
            area2 = "중구";
        } else {
            LoginUserResponseDTO memberInfo = memberService.getMemberInfo(email);
            String address = memberInfo.getAddress();
            log.info("address: {}", address);
            if (address == null || address.isEmpty()) {
                area1 = "서울특별시";
                area2 = "중구";
            } else {
                String[] splitAddress = address.split(" ");
                area1 = splitAddress[0] = splitAddress[0].substring(0, 1);
                area2 = splitAddress[1];
            }
        }

        WeatherInfoResponseDTO dto = weatherService.getShortTermForecast(area1.trim(), area2.replaceAll(" ", ""));

        log.info("dto 내부 값 {}", dto);
        log.info("maxTemperature: {}", dto.getMaxTemperature());
        log.info("maxTemperature: {}", (int) dto.getMaxTemperature());

        int maxInt = (int)dto.getMaxTemperature();
        int minInt = (int)dto.getMinTemperature();

        // BEST OOTD
       List<BoardListResponseDTO> bList = boardService.findBestOOTD(email);

        model.addAttribute("bList", bList);
        model.addAttribute("dto", dto);
        model.addAttribute("maxInt", maxInt);
        model.addAttribute("minInt", minInt);

        return "chap/index";
    }


    @ResponseBody
    @GetMapping("/weather/{area1}/{area2}")
    public ResponseEntity<?> weather(@PathVariable String area1, @PathVariable String area2) {
        log.info("area1={}, area2={}", area1, area2);

        WeatherInfoResponseDTO dto = weatherService.getShortTermForecast(area1.trim(), area2.replaceAll(" ", ""));

        return ResponseEntity.ok().body(dto);
    }


}
