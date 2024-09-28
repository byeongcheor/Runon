package com.ict.finalproject.dao;


import com.ict.finalproject.vo.MateVO;

import java.util.List;

public interface MateDAO {

    public List<MateVO> marathon_code_list(int user_code);
    public List<MateVO> ranking();
}
