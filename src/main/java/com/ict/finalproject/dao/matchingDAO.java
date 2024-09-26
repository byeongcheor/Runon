package com.ict.finalproject.dao;


import com.ict.finalproject.vo.MatchingVO;

import java.util.List;

public interface matchingDAO {

    public List<MatchingVO> marathon_code_list(int user_code);
    public List<MatchingVO> ranking();
}
