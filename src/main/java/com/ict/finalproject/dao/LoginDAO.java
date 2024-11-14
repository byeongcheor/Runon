package com.ict.finalproject.dao;

import com.ict.finalproject.vo.MemberVO;

import java.util.List;

public interface LoginDAO {
    public void addToken(String refreshToken,String username);
    public Boolean checkToken(String username);
    public void updateToken(String refreshToken,String username);

    //로그인했을때마다 방문자 추가
    public void loginHistory(String username,String ip);
    //아이디찾기
    public List<MemberVO> FindIds(String name, String tel);
    //비번바꾸기
    public int updatePassword(String username,String newPassword);
    //구글로그인시 아이디가 있는지 확인
    public int googleSelect(String username);

    //아이디와 이름으로 디비조회
    public MemberVO ChangePwd(String username,String name);

}
