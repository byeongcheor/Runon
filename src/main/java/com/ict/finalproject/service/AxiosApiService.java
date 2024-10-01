package com.ict.finalproject.service;

import com.ict.finalproject.vo.AxiosApiVO;
import com.ict.finalproject.vo.MemberVO;

public interface AxiosApiService {


    public AxiosApiVO getTokenVO(String refreshToken);
    public MemberVO getUserVO(int usercode);
}
