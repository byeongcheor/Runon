package com.ict.finalproject.dao;

import com.ict.finalproject.vo.AxiosApiVO;
import com.ict.finalproject.vo.MemberVO;

public interface AxiosApiDAO {

    public AxiosApiVO getTokenVO(String refreshToken);
    public MemberVO getUserVO(int usercode);
}
