package com.ict.finalproject.jwt;


import com.ict.finalproject.dto.CustomUserDetails;
import com.ict.finalproject.service.LoginService;
import com.ict.finalproject.vo.MemberVO;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

public class JWTFilter extends OncePerRequestFilter {

    private final JWTUtil jwtUtil;
    private final LoginService service;
    public JWTFilter(JWTUtil jwtUtil, LoginService service) {
        this.service = service;
        this.jwtUtil = jwtUtil;
    }


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        System.out.println("수신확인" + request.getParameter("username"));
        //request에서 Authorization 헤더를 찾음
        String authorization= request.getHeader("Authorization");

        //Authorization 헤더 검증
        if (authorization == null || !authorization.startsWith("Bearer ")) {




            filterChain.doFilter(request, response);

            //조건이 해당되면 메소드 종료 (필수)
            return;
        }

        String token = authorization.split(" ")[1];

        //토큰 소멸 시간 검증
        try {
            // 토큰 소멸 시간 검증
            if (jwtUtil.isExpired(token)) {

                    filterChain.doFilter(request, response);

                return; // 메서드 종료
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println("다시 로그인해주세요");
            return;
        }


        String username = jwtUtil.getUsername(token);
        String role = jwtUtil.getRole(token);
        System.out.println("username:" + username + " role:" + role);
        MemberVO memberVO = new MemberVO();
        memberVO.setUsername(username);
        memberVO.setPassword("temppassword");
        memberVO.setRole(role);

        CustomUserDetails customUserDetails = new CustomUserDetails(memberVO);

        Authentication authToken = new UsernamePasswordAuthenticationToken(customUserDetails, null, customUserDetails.getAuthorities());

        SecurityContextHolder.getContext().setAuthentication(authToken);

        filterChain.doFilter(request, response);
    }
}
