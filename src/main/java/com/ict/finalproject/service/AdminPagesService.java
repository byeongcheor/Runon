package com.ict.finalproject.service;

import com.ict.finalproject.vo.*;

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
    //한유저의 전적가져오기
    public List<RecordVO> getRecord(int usercode);
    //유저가 결제한 목록
    public List<AdminPaymentVO> selectInPay(int usercode);
    //탈퇴하면 일단 user를 탈퇴한user테이블에 추가후 point_tbl&유저테이블에서
    public int insertAndDel(int usercode);
    //유저정지
    public int setDisableUserTime(int usercode,int disableday);
    //정지풀기
    public int setEnableUser(int usercode);
    //유저검색
    //public List<MemberVO> searchUser(String type,String value);
    //검색된 유저수
    public int getTotalRecordWithSearch(PagingVO pvo);
    //검색된 유저값
    public List<MemberVO> selectUserWithSearch(PagingVO pvo);
    //선택된 유저담기
    public List<MemberVO> selectedMembers(List<String> usercodes);



}
