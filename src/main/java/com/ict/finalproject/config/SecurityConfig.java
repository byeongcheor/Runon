package com.ict.finalproject.config;

import com.ict.finalproject.dto.CoustomOAuth2User;
import com.ict.finalproject.dto.CustomUserDetails;
import com.ict.finalproject.jwt.JWTFilter;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.jwt.LoginFilter;
import com.ict.finalproject.service.CoustomOAuth2UserService;
import com.ict.finalproject.service.LoginService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.util.Collection;
import java.util.Iterator;


@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final AuthenticationConfiguration authenticationConfiguration;
    private final JWTUtil jwtUtil;
    private final LoginService service;
    private final CoustomOAuth2UserService coustomOAuth2UserService;

    public SecurityConfig(AuthenticationConfiguration authenticationConfiguration, JWTUtil jwtUtil, LoginService service,CoustomOAuth2UserService coustomOAuth2UserService) {
        this.service=service;
        this.authenticationConfiguration = authenticationConfiguration;
        this.jwtUtil = jwtUtil;
        this.coustomOAuth2UserService = coustomOAuth2UserService;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {

        return configuration.getAuthenticationManager();
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {

        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        //csrf disable
        http
                .csrf((auth) -> auth.disable());

        //From 로그인 방식 disable
        http
                .formLogin((auth) -> auth.disable());

        //http basic 인증 방식 disable
        http
                .httpBasic((auth) -> auth.disable());


        http
                .authorizeHttpRequests((auth) -> auth
                        .requestMatchers("/css/**", "/js/**","/img/**").permitAll()
                        .requestMatchers("/login", "/", "/join", "/home","/WEB-INF/views/home.jsp","/WEB-INF/views/adminPages/adminHome.jsp").permitAll()
                        //.requestMatchers("/adminPages/adminHome").hasRole("ADMIN")
                      /*  .requestMatchers("/mate/mate").authenticated()*/
//                        .requestMatchers("링크명").authenticated()
                        .anyRequest().permitAll());

                        //.requestMatchers("/").hasRole("USER")

                        //.requestMatchers("/login", "/", "/join", "/home","/WEB-INF/views/home.jsp","/login&join/loginForm","/WEB-INF/views/login&join/loginForm.jsp").authenticated()
                        //.requestMatchers("/admin").hasRole("ADMIN")
                        //.anyRequest().authenticated());

        http
               /* .oauth2Login(Customizer.withDefaults());*/
                .oauth2Login((oauth2) -> oauth2.userInfoEndpoint((userInfoEndpointConfig -> userInfoEndpointConfig.userService(coustomOAuth2UserService))));
        http
                .oauth2Login((oauth2) -> oauth2
                        // 커스텀 OAuth2 사용자 서비스 설정
                        .userInfoEndpoint((userInfoEndpointConfig ->
                                userInfoEndpointConfig.userService(coustomOAuth2UserService)))

                        // 로그인 성공 후 리다이렉트 경로 설정
                        .successHandler((request, response, authentication) -> {
                            String username;
                            String role;

                            // Principal이 CustomUserDetails 또는 CoustomOAuth2User인지 확인
                            if (authentication.getPrincipal() instanceof CustomUserDetails) {
                                CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
                                username = customUserDetails.getUsername();
                                System.out.println("아이디확인1"+customUserDetails.getUsername());
                                System.out.println("아이디확인2"+customUserDetails);
                            } else if (authentication.getPrincipal() instanceof CoustomOAuth2User) {
                                CoustomOAuth2User oAuth2User = (CoustomOAuth2User) authentication.getPrincipal();
                                username = oAuth2User.getUsername(); // CoustomOAuth2User에서 적절한 필드로 변경
                                System.out.println("아이디확인3"+oAuth2User.toString());
                            } else {
                                throw new IllegalStateException("Unknown principal type");
                            }

                            // 권한 처리
                            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
                            Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
                            GrantedAuthority auth = iterator.next();
                            role = auth.getAuthority();

                            // JWT 토큰 생성
                            String token = jwtUtil.createJwt(username, role, 60 * 60 * 24 * 30 * 1000L);
                            String refreshToken = jwtUtil.createJwt(username, role, 60 * 60 * 1000L * 24 * 30);
                            System.out.println("아이디"+username);
                            // 로그인 히스토리 기록
                            String ip = request.getRemoteAddr();
                            service.loginHistory(username, ip);

                            // 리프레시 토큰 DB 처리
                            Boolean isTrue = service.checkToken(username);
                            if (!isTrue) {
                                service.addToken(refreshToken, username);
                            } else {
                                service.updateToken(refreshToken, username);
                            }

                            response.addHeader("Authorization", "Bearer " + token);
                            response.addHeader("refreshToken", "Bearer " + refreshToken);
                            response.sendRedirect("/callback");
                            response.setContentType("text/html");
                            response.getWriter().write(
                                    "<html>" +
                                            "<body>" +
                                            "<script>" +
                                            "localStorage.setItem('Authorization', 'Bearer " + token + "');" +
                                            "localStorage.setItem('refresh', 'Bearer " + refreshToken + "');" +
                                            "opener.window.location.reload();" +
                                            "window.close();" +
                                            "</script>" +
                                            "</body>" +
                                            "</html>"
                            );
                            response.getWriter().flush();

                            // 성공 시 리다이렉트
                            // 성공 시 /home으로 리다이렉트
                        })

                        .failureHandler((request, response, exception) -> {
                            if (exception instanceof OAuth2AuthenticationException) {
                                OAuth2AuthenticationException oauthException = (OAuth2AuthenticationException) exception;
                                System.out.println("OAuth2 인증 실패 코드: " + oauthException.getError().getErrorCode());
                            }
                        })

                );


        http
                .addFilterBefore(new JWTFilter(jwtUtil,service), LoginFilter.class);
        http
                .addFilterAt(new LoginFilter(authenticationManager(authenticationConfiguration), jwtUtil,service), UsernamePasswordAuthenticationFilter.class);
        //세션 설정
        http
                .sessionManagement((session) -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        return http.build();
    }
}
