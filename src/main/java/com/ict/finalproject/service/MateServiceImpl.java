package com.ict.finalproject.service;

import com.ict.finalproject.dao.MateDAO;
import com.ict.finalproject.vo.MateVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MateServiceImpl implements MateService {

    @Autowired
    private MateDAO dao;


    @Override
    public List<MateVO> marathon_code_list(int user_code) {
        return dao.marathon_code_list(user_code);
    }

    @Override
    public List<MateVO> ranking() {
        return dao.ranking();
    }
}
