package com.ohnal.interceptor;

import com.ohnal.chap.mapper.BoardMapper;
import com.ohnal.util.LoginUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.PrintWriter;

import static com.ohnal.util.LoginUtils.*;

@Configuration
@RequiredArgsConstructor
@Slf4j
public class BoardInterceptor implements HandlerInterceptor {

    //여기 인터셉터에서 Board쪽 DB조회가 필요해서 주입 받겠다.
    private final BoardMapper boardMapper;

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

        // 삭제 요청이 들어올 때 서버에서 다시 한 번 내가 쓴 글인이지 확인한다.
        // 현재 요청이 삭제 요청인지 확인한다
        String uri = request.getRequestURI();
        if(uri.contains("delete")) {
            // 삭제 요청이 들어온 글 번호를 확인 -> 쿼리 파라미터로 글 번호가 전달되었다.
            String bno = request.getParameter("bno");

            // 글 번호(bno)를 통해 해당 글을 누가 작성했는지 알아내기
            // 누가 작성했는지의 기준을 email로 우선 작성했다.
            String email = boardMapper.findOne(Integer.valueOf(bno)).getEmail();

            // 만약 내가 쓴 글이 아니라면 접근 권한이 없다는 피드백을 주어야 한다.
            if(!isMine(session, email)) {
                response.setContentType("text/html; charset=UTF-8");
                PrintWriter w = response.getWriter();
                String htmlCode = "<script>\n" +
                        "    alert('본인이 작성한 게시글만 삭제가 가능합니다.');\n" +
                        "    location.href='/board/list';\n" +
                        "</script>";
                w.write(htmlCode);
                w.flush();
                return false;
            }



        }

        return true;
    }
}
