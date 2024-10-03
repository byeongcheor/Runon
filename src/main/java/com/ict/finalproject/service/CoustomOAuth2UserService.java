package com.ict.finalproject.service;

import com.ict.finalproject.dto.CoustomOAuth2User;
import com.ict.finalproject.dto.GoogleResponse;
import com.ict.finalproject.dto.NaverResponse;
import com.ict.finalproject.dto.OAuth2Response;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
public class CoustomOAuth2UserService extends DefaultOAuth2UserService {
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException{

        OAuth2User oAuthe2User = super.loadUser(userRequest);

        System.out.println("123456");
        System.out.println(oAuthe2User.getAttributes());
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        OAuth2Response oAuth2Response = null;
        if (registrationId.equals("naver")){

            oAuth2Response = new NaverResponse(oAuthe2User.getAttributes());
        }else if (registrationId.equals("google")){
            oAuth2Response = new GoogleResponse(oAuthe2User.getAttributes());

        }
        else {
            return null;
        }
        String role ="USER";
        return new CoustomOAuth2User(oAuth2Response,role);
    }
}
