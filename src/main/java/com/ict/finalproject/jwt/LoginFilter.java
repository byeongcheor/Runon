package com.ict.finalproject.jwt;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.ict.finalproject.dto.CustomUserDetails;

import com.ict.finalproject.service.LoginService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class LoginFilter extends UsernamePasswordAuthenticationFilter {

    private  final LoginService service;
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


        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(username, password, null);
        return authenticationManager.authenticate(authToken);
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,Authentication authentication)throws IOException {

        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        String username = customUserDetails.getUsername();
        //System.out.println(username);
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
        GrantedAuthority auth = iterator.next();
        String ip = request.getRemoteAddr();
        String role = auth.getAuthority();


        String token = jwtUtil.createJwt(username, role, 60*60*24*30*1000L);
        String refreshToken = jwtUtil.createJwt(username, role, 60*60*1000L*24*30);
        service.loginHistory(username,ip);
        //System.out.println("확인"+JWTUtil.setTokengetUsername(token));
        Boolean istrue=service.checkToken(username);
        if (!istrue) {
            service.addToken(refreshToken,username);
            //System.out.println("추가히기");
        }else {
            service.updateToken(refreshToken,username);
            //System.out.println("업데이트하기");
        }

        response.addHeader("Authorization", "Bearer " + token);
        response.addHeader("refreshToken", "Bearer "+refreshToken);
        //System.out.println("헤더에 값넣은후");



    }


    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {

        response.setStatus(401);
    }



}

