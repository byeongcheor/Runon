package com.ict.finalproject.dao;


import com.ict.finalproject.vo.MateVO;

import java.util.List;

public interface MateDAO {

    public List<MateVO> marathon_code_list(int user_code);
    public List<MateVO> more(int more);
    public List<MateVO> ranking();
    public List<MateVO> room_select(int matching_room_code);
    int matching_select(int marathonValue, String ageValue, String genderValue, String participationCountValue, int mateCountValue);
    int matching_insert_room(int marathonValue, String ageValue, String genderValue, String participationCountValue, int mateCountValue);
    int applicant_insert(int applicant_insert, int user_code);
}
