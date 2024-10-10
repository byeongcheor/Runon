package com.ict.finalproject.dao;

import com.ict.finalproject.vo.CertificateVO;
import com.ict.finalproject.vo.MarathonFormVO;
import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.QnAVO;

import java.util.List;

public interface MypageDAO {
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

    //인증서리스트불러오기
    public List<CertificateVO> selectCertificateAll(String username);
    //인증서업로드
    public void updateCertificate(CertificateVO certificate);
    //인증서삭제
    public int deleteCertificate(int certificate_code);
    //인증서 하나만
    public CertificateVO selectCertificate(int certificate_code);

    //메이트이력리스트
    public List<MemberVO> selectMemberAll(int usercode);

    //qna리스트
    public List<QnAVO> selectQnAAll(int usercode);
    //qna작성
    public void updateQnA(QnAVO qna);
    //qna선택
    public QnAVO selectQnA(int qna_code);
    //qna삭제
    public int deleteQnA(int qna_code);
    //qna 답변등록되면 상태변경
    public void updateQnAStatus(int qna_status, int qna_code);
}