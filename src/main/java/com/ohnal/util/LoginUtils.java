package com.ohnal.util;
import com.ohnal.chap.dto.response.LoginUserResponseDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.util.WebUtils;
public class LoginUtils {
    // 로그인 세션 키
    public static final String LOGIN_KEY = "login";
    // 자동 로그인 쿠키 이름
    public static final String AUTO_LOGIN_COOKIE = "auto";
    // 로그인 여부 확인
    public static boolean isLogin(HttpSession session) {
        return session.getAttribute(LOGIN_KEY) != null;
    }
    // 로그인 한 사람의 계정명을 반환해 주는 메서드
    public static String getCurrentLoginMemberEmail(HttpSession session) {
        // session.getAttribute의 리턴타입이 Object이기 때문에
        // 자식의 고유 기능과 속성을 사용하기 위해 자식 타입으로 형 변환.
        LoginUserResponseDTO loginUser = (LoginUserResponseDTO) session.getAttribute(LOGIN_KEY);

        if (loginUser == null) return new LoginUserResponseDTO().getEmail();
        return loginUser.getEmail();
    }
    // 내가 쓴 게시물인지 확인해 주는 메서드
    public static boolean isMine(HttpSession session, String targetEmail) {
        return targetEmail.equals(getCurrentLoginMemberEmail(session));
    }
    // 자동로그인 여부 확인
    public static boolean isAutoLogin(HttpServletRequest request) {
        // auto라는 이름의 쿠키가 존재한다면 true, 없다면 false
        return WebUtils.getCookie(request, AUTO_LOGIN_COOKIE) != null;
    }
}