package com.ohnal.config;

import com.ohnal.interceptor.AfterLoginInterceptor;
import com.ohnal.interceptor.BoardInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 내가 만든 인터셉터들을 스프링 컨텍스트에 등록하는 설정 파일
@Configuration
@RequiredArgsConstructor
public class InterceptorConfig implements WebMvcConfigurer {

    private final AfterLoginInterceptor afterLoginInterceptor;
    private final BoardInterceptor boardInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 로그인 후 비회원 전용 페이지 접근 차단 인터셉터 등록
        registry
                .addInterceptor(afterLoginInterceptor) // 어떤 인터셉터를 등록할 것인지
                .addPathPatterns("/members/sign-up", "/members/sign-in"); // 어떤 요청에서 인터셉터를 동작하게 할 것인지

        // 비회원은 /board/* 이하로 들어오는 요청을 모두 막고,

        // /board/list(게시판 조회), /board/detail/{bno}(게시글 자세히 보기), /reply/{bno} (댓글 창 불러오기)는
        // 비회원도 볼 수 있게 설정
        registry
                .addInterceptor(boardInterceptor)
                .addPathPatterns("/board/*", "/members/my-history")
                .excludePathPatterns("/board/list", "/board/detail/{bno}", "/reply/{bno}");


    }
}
