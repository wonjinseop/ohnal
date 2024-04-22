package com.ohnal.interceptor;
import com.ohnal.chap.entity.Member;
import com.ohnal.chap.mapper.MemberMapper;
import com.ohnal.chap.service.MemberService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import java.time.LocalDateTime;

import static com.ohnal.util.LoginUtils.AUTO_LOGIN_COOKIE;


@Configuration
@Slf4j
@RequiredArgsConstructor
public class AutoLoginInterceptor implements HandlerInterceptor {

    private final MemberMapper memberMapper;
    private final MemberService memberService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 1. 사이트에 들어오면 자동 로그인 쿠키를 가진 클라이언트인지를 체크
        Cookie autoLoginCookie = WebUtils.getCookie(request, AUTO_LOGIN_COOKIE);

        // 2. 자동 로그인 쿠키가 있다면!
        if (autoLoginCookie != null) {

            // 3. 지금 읽어들인 쿠키가 가지고 있는 session_id를 꺼내자.
            String sessionId = autoLoginCookie.getValue();

            // 4. DB에서 쿠키가 가지고 있던 session_id와 동일한 값을 가진 회원을 조회해 오자.
            Member member = memberMapper.findMemberByCookie(sessionId);

            // 5. 회원이 정상적으로 조회가 됐다면 and 자동로그인 만료시간 이전이면 로그인을 수행한다.
            if (member != null && LocalDateTime.now().isBefore(member.getLimitTime())) {
                memberService.maintainLoginState(request.getSession(), member.getEmail());
            }

        }

        // 자동로그인을 신청했던 사람이든, 아니든간에
        // 요청은 무조건 컨트롤러로 전달되어야 하니까 return값은 true가 고정입니다.
        return true;
    }
}