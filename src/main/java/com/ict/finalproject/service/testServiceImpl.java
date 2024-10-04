package com.ict.finalproject.service;

import com.ict.finalproject.dao.testDAO;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;

@Service
public class testServiceImpl implements testService {

    @Autowired
    private testDAO dao;

    @Value("${spring.jwt.secret}")
    private String secretKey;


    @Override
    public String selectAll() {
        return dao.selectAll();
    }

//    @Override
//    public Claims extractAllClaims(String token) {
//        SecretKey key = Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8)); // 비밀키 생성
//
//        // JWT 파싱 및 클레임 추출
//        return Jwts.parserBuilder()
//                .setSigningKey(key)   // 비밀키를 이용해 서명 검증
//                .build()              // 파서 빌드
//                .parseClaimsJws(token) // JWT 토큰 파싱
//                .getBody();           // 클레임 반환
//    }
//
//    @Override
//    public String extractUserid(String token) {
//        return extractAllClaims(token).get("userid", String.class);
//    }
}
