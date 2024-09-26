package com.ict.finalproject.service;

import com.ict.finalproject.dao.matchingDAO;
import com.ict.finalproject.vo.MatchingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class matchingServiceImpl implements matchingService {

    @Autowired
    private matchingDAO dao;


    @Override
    public List<MatchingVO> marathon_code_list(int user_code) {
        return dao.marathon_code_list(user_code);
    }

    @Override
    public List<MatchingVO> ranking() {
        return dao.ranking();
    }
}
