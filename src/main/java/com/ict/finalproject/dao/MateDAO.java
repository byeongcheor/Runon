package com.ict.finalproject.dao;


import com.ict.finalproject.vo.MateVO;

import java.util.Date;
import java.util.List;

public interface MateDAO {

    public List<MateVO> marathon_code_list(int user_code);
    public List<MateVO> userselect(int user_code);
    public List<MateVO> more(int more);
    public List<MateVO> ranking();
    public List<MateVO> match_view(int matching_room_code);
    int matching_select(int marathonValue, String participationCountValue, int mateCountValue);
    int matching_insert_room(int marathonValue, String participationCountValue, int mateCountValue);
    int applicant_insert(int applicant_insert, int user_code);
    int accept(int applicant_insert, int user_code);
    int accept_n(int matching_room_code, int user_code);
    int mate_complite(int matching_room_code, int user_code);
    int profile_click(int profileValue, int usercode);
    int match_yn(int user_code);
    int match_out(int matching_room_code, int user_code);
    int matching_room_personnel_update_plus(int matching_room_code);
    int matching_room_personnel_update_minus(int matching_room_code);
    int matching_complite(int matching_room_code);
    int matching_room_personnel_zero_delete();
    int usercodeSelect(String user_name);
    int hide7daysAdd(int user_code,int num);
    int neverShow(int user_code,int num);
    Date mate_popup_date_select(int user_code);

}
