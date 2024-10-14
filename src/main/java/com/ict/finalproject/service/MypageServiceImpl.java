package com.ict.finalproject.service;

import com.ict.finalproject.dao.MypageDAO;
import com.ict.finalproject.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MypageServiceImpl implements MypageService{
    @Autowired
    private MypageDAO dao;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public MemberVO selectOne(String username) {
        return dao.selectOne(username);
    }

    @Transactional(rollbackFor = Exception.class)

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
    public MemberVO getMember(int usercode) {
        return dao.getMember(usercode);
    }

    @Override
    public int insertDelUser(int usercode) {
        return dao.insertDelUser(usercode);
    }

    @Override
    public int delFromUser(int usercode) {
        return dao.delFromUser(usercode);
    }

    @Override
    public int delFromPoint(int usercode) {
        return dao.delFromPoint(usercode);
    }

    @Override
    public boolean checkPassword(int usercode, String curerntPassword) {
        MemberVO member = dao.getMember(usercode);

        if(member != null && passwordEncoder.matches(curerntPassword, member.getPassword())) {
            dao.insertDelUser(usercode);
            dao.delFromUser(usercode);
            dao.delFromPoint(usercode);
            return true;
        }
        return false;
    }

    @Override
    public boolean checkPassword2(String username, String curerntPassword) {
        MemberVO member = dao.selectMember(username);
        if(member==null){
            return false;
        }
        boolean isMaTch = passwordEncoder.matches(curerntPassword, member.getPassword());
        return isMaTch;
    }


    @Override
    public MemberVO passwordChk(String username) {
        return dao.passwordChk(username);
    }

    @Override
    public List<OrderVO> selectOrderAll(int usercode) {
        return dao.selectOrderAll(usercode);
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
    public void deleteMarathonForm(int usercode) {
        dao.deleteMarathonForm(usercode);
    }

    @Override
    public int updateMarathonForm(MarathonFormVO marathonVO) {
        return dao.updateMarathonForm(marathonVO);
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
