package com.ict.finalproject.service;

import com.ict.finalproject.dao.MypageDAO;
import com.ict.finalproject.vo.CertificateVO;
import com.ict.finalproject.vo.MarathonFormVO;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageServiceImpl implements MypageService{
    @Autowired
    private MypageDAO dao;

    @Override
    public int selectUsercode(String username) {
        return dao.selectUsercode(username);
    }

    @Override
    public MemberVO selectMember(String username) {
        return dao.selectMember(username);
    }

    @Override
    public void updateProfile(String username, String profile_img) {
        dao.updateProfile(username, profile_img);
    }

    @Override
    public String getProfileImg(String username) {
        return dao.getProfileImg(username);
    }

    @Override
    public int editProfile(MemberVO member) {
        return dao.editProfile(member);
    }

    @Override
    public int deactiveProfile(String username, int is_deleted) {
        return dao.deactiveProfile(username, 1);
    }

    @Override
    public MarathonFormVO selectMarathonForm(String username) {
        return dao.selectMarathonForm(username);
    }

    @Override
    public void createMarathonForm(MarathonFormVO marathonVO) {
        dao.createMarathonForm(marathonVO);
    }

    @Override
    public List<CertificateVO> selectCertificateAll(String username) {
        return dao.selectCertificateAll(username);
    }


}
