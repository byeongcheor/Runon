package com.ict.finalproject.service;

import com.ict.finalproject.dao.LoginDAO;
import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.dto.CoustomOAuth2User;
import com.ict.finalproject.dto.GoogleResponse;
import com.ict.finalproject.dto.NaverResponse;
import com.ict.finalproject.dto.OAuth2Response;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
public class CoustomOAuth2UserService extends DefaultOAuth2UserService {
    @Autowired
    LoginDAO dao;
    @Autowired
    MemberDAO memberDAO;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException{
        System.out.println("오는것 확인");
        OAuth2User oAuthe2User = super.loadUser(userRequest);


        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        OAuth2Response oAuth2Response = null;
        String username=(String)oAuthe2User.getAttributes().get("email");
        String name=(String)oAuthe2User.getAttributes().get("name");
        String nickname=(String) oAuthe2User.getAttributes().get("sub");

        //구글로그인하려는 아이디가 가입되어있는지 확인
        int count=memberDAO.is_googleSelect((String)oAuthe2User.getAttributes().get("email"));
        if (count==0){
            if (registrationId.equals("naver")){
                System.out.println("확인용");
                oAuth2Response = new NaverResponse(oAuthe2User.getAttributes());
            }else if (registrationId.equals("google")){
                oAuth2Response = new GoogleResponse(oAuthe2User.getAttributes());
                System.out.println(oAuthe2User.getAttributes().get("name"));
                System.out.println(username);
                int result= memberDAO.googleSelect(username);
                if (result==0){
                    memberDAO.googleJoins(username,name,nickname);
                }

            }

        }
        else {
            return null;
        }
        String role ="USER";
        return new CoustomOAuth2User(oAuth2Response,role);
    }
}
