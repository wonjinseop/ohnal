package com.ohnal.chap.controller;

import com.ohnal.chap.dto.response.WeatherInfoResponseDTO;
import com.ohnal.chap.service.WeatherService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j // 2024. 04. 12 오전 추가
@RequiredArgsConstructor
public class WeatherController {
    private final WeatherService weatherService;

    // 메인 홈페이지 접속 url 매핑
    @GetMapping ("/index")
    public String veiwIndex() {
        log.info("/index 요청 들어옴"); // 2024. 04. 12 오전 추가
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
