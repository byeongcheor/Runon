package com.ict.finalproject.dao;

import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.PagingVO;
import com.ict.finalproject.vo.RecordVO;
import com.ict.finalproject.vo.ReportVO;

import java.util.List;

public interface AdminPagesDAO {
    //총 유저수 구하기
    public int getTotalRecord();
    // 관리자 제외 모든 유저값 List에 담기
    public List<MemberVO> selectAllUser(PagingVO pvo);
    //페이징 없이 관리자 제외 모든 유저값
    public List<MemberVO> selectMembers();
    //신고당한 횟수 카운터 &리스트 받기
    public List<ReportVO> getUserReport(int usercode);
    //한유저의 인적사항
    public MemberVO selectOneUser(int usercode);
    //유저의 전적가져오기
    public List<RecordVO> getRecord(int usercode);

}
