package com.ict.finalproject.dao;

import com.ict.finalproject.vo.MemberVO;

public interface LoginDAO {
    public void addToken(String refreshToken,String username);
    public Boolean checkToken(String username);
    public void updateToken(String refreshToken,String username);



}
