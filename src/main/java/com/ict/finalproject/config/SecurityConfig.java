package com.ict.finalproject.config;

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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


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
                        .requestMatchers("/login", "/", "/join", "/home","/WEB-INF/views/home.jsp").permitAll()
                        .requestMatchers("/adminPages/adminHome").hasRole("ADMIN")
                        //.requestMatchers("/mate/mate").authenticated()
//                        .requestMatchers("링크명").authenticated()
                        .anyRequest().permitAll());

                        //.requestMatchers("/").hasRole("USER")

                        //.requestMatchers("/login", "/", "/join", "/home","/WEB-INF/views/home.jsp","/login&join/loginForm","/WEB-INF/views/login&join/loginForm.jsp").authenticated()
                        //.requestMatchers("/admin").hasRole("ADMIN")
                        //.anyRequest().authenticated());

//        http
//                //.oauth2Login(Customizer.withDefaults());
//                .oauth2Login((oauth2) -> oauth2.userInfoEndpoint((userInfoEndpointConfig -> userInfoEndpointConfig.userService(coustomOAuth2UserService))));
//        http
//                .oauth2Login((oauth2) -> oauth2
//                        // 커스텀 OAuth2 사용자 서비스 설정
//                        .userInfoEndpoint((userInfoEndpointConfig ->
//                                userInfoEndpointConfig.userService(coustomOAuth2UserService)))
//
//                        // 로그인 성공 후 리다이렉트 경로 설정
//                        .successHandler((request, response, authentication) -> {
//                            response.sendRedirect("/");  // 성공 시 /home으로 리다이렉트
//                        })
//
//                        // 로그인 실패 시 처리
//                        .failureHandler((request, response, exception) -> {
//                            response.sendRedirect("/login");  // 실패 시 /login?error로 리다이렉트
//                        })
//                );



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
