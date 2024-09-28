package com.ict.finalproject.service;

import com.ict.finalproject.vo.MateVO;

import java.util.List;

public interface MateService {

    public List<MateVO> marathon_code_list(int user_code);
    public List<MateVO> more(int more);
    public List<MateVO> ranking();
    int matching_select(int marathonValue,String ageValue,String genderValue,String participationCountValue,int mateCountValue);
    int matching_insert_room(int marathonValue,String ageValue,String genderValue,String participationCountValue,int mateCountValue);

}
