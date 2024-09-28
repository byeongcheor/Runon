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
    public int matching_select(int marathonValue, String ageValue, String genderValue, String participationCountValue, int mateCountValue) {
    return dao.matching_select(marathonValue,ageValue,genderValue,participationCountValue,mateCountValue);
    }
    @Override
    public int matching_insert_room(int marathonValue, String ageValue, String genderValue, String participationCountValue, int mateCountValue) {
    return dao.matching_insert_room(marathonValue,ageValue,genderValue,participationCountValue,mateCountValue);
    }
}
