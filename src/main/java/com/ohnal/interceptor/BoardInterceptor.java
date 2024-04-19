package com.ohnal.interceptor;

import com.ohnal.util.LoginUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import static com.ohnal.util.LoginUtils.*;

@Configuration
@Slf4j
public class BoardInterceptor implements HandlerInterceptor {
    // 로그인을 한 회원이 아니라면, 즉 비회원이라면 회원이 사용하는 페이지를 막을 것이다.
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        // 로그인을 안 했다면 글쓰기, 글 수정, 글 삭제 요청을 모두 받지 않을 것이다.
        if(!isLogin(session)) {
            log.info("권한 없음! 요청 거부! - {}", request.getRequestURI());
            response.sendRedirect("/members/sign-in");
            return false;
        }

        return true;
    }
}
