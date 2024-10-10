package com.ict.finalproject.service;


import com.ict.finalproject.dao.AxiosApiDAO;
import com.ict.finalproject.vo.AxiosApiVO;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AxiosApiServiceImpl  implements AxiosApiService {
    @Autowired
    AxiosApiDAO dao;

    @Override
    public AxiosApiVO getTokenVO(String refreshToken) {
        return dao.getTokenVO(refreshToken);
    }

    @Override
    public MemberVO getUserVO(int usercode) {
        return dao.getUserVO(usercode);
    }
}
