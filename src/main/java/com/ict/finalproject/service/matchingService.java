package com.ict.finalproject.service;

import com.ict.finalproject.vo.MatchingVO;

import java.util.List;

public interface matchingService {

    public List<MatchingVO> marathon_code_list(int user_code);
    public List<MatchingVO> ranking();
}
