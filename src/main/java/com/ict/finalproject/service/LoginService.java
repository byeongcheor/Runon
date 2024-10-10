package com.ict.finalproject.service;

public interface LoginService {

    public void addToken(String refreshToken,String username);
    public Boolean checkToken(String username);
    public void updateToken(String refreshToken,String username);
}
