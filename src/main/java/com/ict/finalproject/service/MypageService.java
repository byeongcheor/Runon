package com.ict.finalproject.service;

import com.ict.finalproject.vo.CertificateVO;
import com.ict.finalproject.vo.MarathonFormVO;
import com.ict.finalproject.vo.MemberVO;

import java.util.List;

public interface MypageService {
    public int selectUsercode(String username);
    public MemberVO selectMember(String username);
    public void updateProfile(String username, String profile_img);
    public String getProfileImg(String username);
    public int editProfile(MemberVO member);
    public int deactiveProfile(String username, int is_deleted);
    //마라톤신청서있는지조회
    public MarathonFormVO selectMarathonForm(String username);
    //마라톤신청서작성
    public void createMarathonForm(MarathonFormVO marathonVO);
    public List<CertificateVO> selectCertificateAll(String username);
}
