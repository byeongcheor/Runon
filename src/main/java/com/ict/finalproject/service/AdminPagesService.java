package com.ict.finalproject.service;

import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.PagingVO;
import com.ict.finalproject.vo.RecordVO;
import com.ict.finalproject.vo.ReportVO;

import java.util.List;

public interface AdminPagesService {
    //총 유저수 구하기
    public int getTotalRecord();
    // 관리자 제외 모든 유저값 페이징해서 List에 담기
    public List<MemberVO> selectAllUser(PagingVO pvo);

    //페이징 없이
    public List<MemberVO> selectMembers();
    // 신고당한 리스트
    public List<ReportVO> getUserReport(int usercode);
    //한유저의 인적사항
    public MemberVO selectOneUser(int usercode);

    public List<RecordVO> getRecord(int usercode);
}
