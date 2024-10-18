package com.ict.finalproject.service;

import com.ict.finalproject.vo.*;

import java.util.List;

public interface MypageService {
    public MemberVO selectOne(String username);
    public int selectUsercode(String username);
    public MemberVO selectMember(String username);
    public void updateProfile(String username, String profile_img);
    public String getProfileImg(String username);
    public int editProfile(MemberVO member);
    public int deactiveProfile(String username, int is_deleted);

    //회원탈퇴 한번에 처리
    public MemberVO getMember(int usercode);
    public int insertDelUser(int usercode);
    public int delFromUser(int usercode);
    public int delFromPoint(int usercode);

    public boolean checkPassword(int usercode, String curerntPassword);
    public boolean checkPassword2(String username, String curerntPassword);

    public MemberVO passwordChk(String username);
    //주문목록
    public List<OrderVO> selectOrderAll(int usercode);
    //마라톤신청서있는지조회
    public MarathonFormVO selectMarathonForm(int usercode);
    //마라톤신청서작성
    public void createMarathonForm(MarathonFormVO marathonVO);
    public void deleteMarathonForm(int usercode);
    public int updateMarathonForm(MarathonFormVO marathonVO);
    public int getOrderCode(int marathon_code, int usercode);
    public List<OrderVO> getOrderInfo(int usercode);
    public List<CertificateVO> selectCertificateAll(String username);
    public void updateCertificate(CertificateVO certificate);
    public int deleteCertificate(int certificate_code);
    public CertificateVO selectCertificate(int certificate_code);
    public List<MemberVO> selectMemberAll(int usercode);
    public int reportMate(ReportVO report);
    public ReportVO selectReportForm(int usercode, int matching_room_code);
    public List<QnAVO> selectQnAAll(int usercode);
    public void updateQnA(QnAVO qna);
    public QnAVO selectQnA(int qna_code);
    public int deleteQnA(int qna_code);
    public void updateQnAStatus(int qna_status, int qna_code);
}
