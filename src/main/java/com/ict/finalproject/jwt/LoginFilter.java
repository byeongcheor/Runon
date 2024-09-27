package com.ict.finalproject.jwt;


import com.ict.finalproject.dto.CustomUserDetails;
import com.ict.finalproject.service.LoginService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.util.Collection;
import java.util.Iterator;

public class LoginFilter extends UsernamePasswordAuthenticationFilter {

    private final LoginService service;
    private final AuthenticationManager authenticationManager;
    private final JWTUtil jwtUtil;

    public LoginFilter(AuthenticationManager authenticationManager, JWTUtil jwtUtil,LoginService service) {
        this.service = service;
        this.authenticationManager = authenticationManager;
        this.jwtUtil = jwtUtil;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        String username = obtainUsername(request);
        String password = obtainPassword(request);

        System.out.println(username);

        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(username, password, null);

        return authenticationManager.authenticate(authToken);
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) {

        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();

        String username = customUserDetails.getUsername();

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
        GrantedAuthority auth = iterator.next();

        String role = auth.getAuthority();


        String token = jwtUtil.createJwt(username, role, 60*60*1000L);
        String refreshToken = jwtUtil.createJwt(username, role, 60*60*1000L*24*30);
        service.addToken(refreshToken,username);
        response.addHeader("Authorization", "Bearer " + token);
        response.addHeader("refreshToken", "Bearer "+refreshToken);
        addTokenToCookie(response,token, "Authorization");
    }

    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {

        response.setStatus(401);
    }
    // JWT 토큰을 쿠키에 추가하는 메서드
    public void addTokenToCookie(HttpServletResponse response, String token, String cookieName) {
        Cookie cookie = new Cookie(cookieName, token);
        cookie.setHttpOnly(true);  // XSS 공격 방지를 위해 JavaScript에서 쿠키 접근 불가 설정
        cookie.setSecure(true);  // HTTPS 통신에서만 쿠키 전송
        cookie.setPath("/");  // 애플리케이션 전체에서 쿠키 사용 가능
        if (cookieName.equals("Authorization")) {
            cookie.setMaxAge(60 * 60);  // 1시간 동안 유효 (JWT 토큰)
        }
        response.addCookie(cookie);  // 응답에 쿠키 추가
    }

}

