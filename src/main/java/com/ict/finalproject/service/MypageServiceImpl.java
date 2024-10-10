package com.ict.finalproject.service;

import com.ict.finalproject.dao.MypageDAO;
import com.ict.finalproject.vo.CertificateVO;
import com.ict.finalproject.vo.MarathonFormVO;
import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.QnAVO;
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
    public MarathonFormVO selectMarathonForm(int usercode) {
        return dao.selectMarathonForm(usercode);
    }

    @Override
    public void createMarathonForm(MarathonFormVO marathonVO) {
        dao.createMarathonForm(marathonVO);
    }

    @Override
    public List<CertificateVO> selectCertificateAll(String username) {
        return dao.selectCertificateAll(username);
    }

    @Override
    public void updateCertificate(CertificateVO certificate) {
        dao.updateCertificate(certificate);
    }

    @Override
    public int deleteCertificate(int certificate_code) {
        return dao.deleteCertificate(certificate_code);
    }

    @Override
    public CertificateVO selectCertificate(int certificate_code) {
        return dao.selectCertificate(certificate_code);
    }

    @Override
    public List<MemberVO> selectMemberAll(int usercode) {
        return dao.selectMemberAll(usercode);
    }

    @Override
    public List<QnAVO> selectQnAAll(int usercode) {
        return dao.selectQnAAll(usercode);
    }

    @Override
    public void updateQnA(QnAVO qna) {
        dao.updateQnA(qna);
    }

    @Override
    public QnAVO selectQnA(int qna_code) {
        return dao.selectQnA(qna_code);
    }

    @Override
    public int deleteQnA(int qna_code) {
        return dao.deleteQnA(qna_code);
    }

    @Override
    public void updateQnAStatus(int qna_status, int qna_code) {
        dao.updateQnAStatus(qna_status, qna_code);
    }


}
