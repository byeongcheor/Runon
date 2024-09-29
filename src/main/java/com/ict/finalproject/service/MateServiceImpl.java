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
    public List<MateVO> more(int more) {
        return dao.more(more);
    }

    @Override
    public List<MateVO> ranking() {
        return dao.ranking();
    }

    @Override
    public List<MateVO> room_select(int matching_room_code) {
        return dao.room_select(matching_room_code);
    }

    @Override
    public int matching_select(int marathonValue, String ageValue, String genderValue, String participationCountValue, int mateCountValue) {
    return dao.matching_select(marathonValue,ageValue,genderValue,participationCountValue,mateCountValue);
    }

    @Override
    public int matching_insert_room(int marathonValue, String ageValue, String genderValue, String participationCountValue, int mateCountValue) {
    return dao.matching_insert_room(marathonValue,ageValue,genderValue,participationCountValue,mateCountValue);
    }

    @Override
    public int applicant_insert(int applicant_insert, int user_code) {
        return dao.applicant_insert(applicant_insert, user_code);
    }

}
