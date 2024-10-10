package com.ict.finalproject.service;

import com.ict.finalproject.vo.CertificateVO;
import com.ict.finalproject.vo.MarathonFormVO;
import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.QnAVO;

import java.util.List;

public interface MypageService {
    public int selectUsercode(String username);
    public MemberVO selectMember(String username);
    public void updateProfile(String username, String profile_img);
    public String getProfileImg(String username);
    public int editProfile(MemberVO member);
    public int deactiveProfile(String username, int is_deleted);
    //마라톤신청서있는지조회
    public MarathonFormVO selectMarathonForm(int usercode);
    //마라톤신청서작성
    public void createMarathonForm(MarathonFormVO marathonVO);
    public void deleteMarathonForm(int usercode);
    public int updateMarathonForm(MarathonFormVO marathonVO);

    public List<CertificateVO> selectCertificateAll(String username);
    public void updateCertificate(CertificateVO certificate);
    public int deleteCertificate(int certificate_code);
    public CertificateVO selectCertificate(int certificate_code);
    public List<MemberVO> selectMemberAll(int usercode);

    public List<QnAVO> selectQnAAll(int usercode);
    public void updateQnA(QnAVO qna);
    public QnAVO selectQnA(int qna_code);
    public int deleteQnA(int qna_code);
    public void updateQnAStatus(int qna_status, int qna_code);
}
