package com.ict.finalproject.service;

import com.ict.finalproject.dao.MateDAO;
import com.ict.finalproject.vo.MateVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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
    public List<MateVO> userselect(int user_code) {
        return dao.userselect(user_code);
    }

    @Override
    public List<MateVO> more(int more) {
        return dao.more(more);
    }

    @Override
    public List<MateVO> ranking() {
        return dao.ranking();
    }

    @Override
    public List<MateVO> match_view(int matching_room_code) {
        return dao.match_view(matching_room_code);
    }

    @Override
    public int matching_select(int marathonValue, String participationCountValue, int mateCountValue) {
    return dao.matching_select(marathonValue,participationCountValue,mateCountValue);
    }

    @Override
    public int matching_insert_room(int marathonValue, String participationCountValue, int mateCountValue) {
    return dao.matching_insert_room(marathonValue,participationCountValue,mateCountValue);
    }

    @Override
    public int applicant_insert(int applicant_insert, int user_code) {

        return dao.applicant_insert(applicant_insert, user_code);
    }

    @Override
    public int match_yn( int user_code) {
        return dao.match_yn(user_code);
    }

    @Override
    public int match_out( int matching_room_code, int user_code) {
        return dao.match_out(matching_room_code, user_code);
    }

    @Override
    public int accept( int matching_room_code, int user_code) {
        return dao.accept(matching_room_code, user_code);
    }

    @Override
    public int accept_n( int matching_room_code, int user_code) {
        return dao.accept_n(matching_room_code, user_code);
    }

    @Override
    public int profile_click( int profileValue, int usercode) {
        return dao.profile_click(profileValue, usercode);
    }

    @Override
    public int mate_complite( int matching_room_code, int user_code) {
        dao.matching_complite(matching_room_code);
        return dao.mate_complite(matching_room_code, user_code);
    }

    @Override
    public int matching_room_personnel_update_plus( int matching_room_code) {
        return dao.matching_room_personnel_update_plus(matching_room_code);
    }

    @Override
    public int matching_room_personnel_update_minus( int matching_room_code) {
        return dao.matching_room_personnel_update_minus(matching_room_code);
    }

    @Override
    public int usercodeSelect(String user_name) {
        return dao.usercodeSelect(user_name);
    }

    @Override
    public int hide7daysAdd(int user_code,int num) {
        return dao.hide7daysAdd(user_code,num);
    }

    @Override
    public int neverShow(int user_code,int num) {
        return dao.neverShow(user_code,num);
    }

    @Override
    public Date mate_popup_date_select(int user_code) {
        return dao.mate_popup_date_select(user_code);
    }

    @Override
    public int matching_room_personnel_zero_delete() {
        return dao.matching_room_personnel_zero_delete();
    }



}
