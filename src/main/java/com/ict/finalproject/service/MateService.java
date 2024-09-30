package com.ict.finalproject.service;

import com.ict.finalproject.vo.MateVO;

import java.util.List;

public interface MateService {

    public List<MateVO> marathon_code_list(int user_code);
    public List<MateVO> more(int more);
    public List<MateVO> ranking();
    public List<MateVO> match_view(int matching_room_code);
    int matching_select(int marathonValue,String ageValue,String genderValue,String participationCountValue,int mateCountValue);
    int matching_insert_room(int marathonValue,String ageValue,String genderValue,String participationCountValue,int mateCountValue);
    int applicant_insert(int applicant_insert, int user_code);
    int match_yn(int user_code);
    int match_out(int matching_room_code, int user_code);
    int accept(int matching_room_code, int user_code);
    int matching_room_personnel_update_plus(int matching_room_code);
    int matching_room_personnel_update_minus(int matching_room_code);
    int matching_room_personnel_zero_delete();

}
