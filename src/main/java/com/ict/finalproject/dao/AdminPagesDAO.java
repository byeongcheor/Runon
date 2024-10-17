package com.ict.finalproject.dao;

import com.ict.finalproject.vo.*;

import java.util.List;

public interface AdminPagesDAO {
    //총 유저수 구하기
    public int getTotalRecord();
    // 관리자 제외 모든 유저값 List에 담기
    public List<MemberVO> selectAllUser(PagingVO pvo);
    //페이징 없이 관리자 제외 모든 유저값
    public List<MemberVO> selectMembers(String role);
    //신고당한 횟수 카운터 &리스트 받기
    public List<ReportVO> getUserReport(int usercode);
    //한유저의 인적사항
    public MemberVO selectOneUser(int usercode);
    //한유저의 전적가져오기
    public List<RecordVO> getRecord(int usercode);

    //유저가 결제한 목록
    public List<AdminPaymentVO> selectInPay(int usercode);

    //탈퇴하면 일단 user를 탈퇴한user테이블에 추가후 point_tbl&유저테이블에서 삭제
    public int insert(int usercode);
    public int deluser(int usercode);
    public int delpoint(int usercode);
    //여기까지 한serviceImpl에서 실행

    //유저정지
    public int setDisableUserTime(int usercode,int disableday);

    //정지풀기
    public int setEnableUser(int usercode);

    //public List<MemberVO> searchUser(String type,String value);
    //검색된 유저수
    public int getTotalRecordWithSearch(PagingVO pvo);
    //검색된 유저값
    public List<MemberVO> selectUserWithSearch(PagingVO pvo);
    //선택된 유저담기
    public List<MemberVO> selectedMembers(List<String> usercodes);
    //검색된 관리자수
    public int getSearchAdminTotalRecord(PagingVO pvo);
    //검색된 관리자값
    public List<AdminsVO> selectAdminWithSearch(PagingVO pvo);
    //모든 관리자수
    public int getAdminTotalRecord();
    //모든 관리자값
    public List<AdminsVO> selectAllAdmin(PagingVO pvo);
    //로그인한 사람의 관리자 등급받기
    public AdminsVO selectAdminRole(int usercode);
    //등급&권한업데이트
    public int updateRole(AdminsVO vo);
    public int updateUserRole(AdminsVO vo);
    //여기까지
    //유저&관리자테이블에서 등급변환
    public int UpdateUsertbl(MemberVO mvo);
    public int UpdateAdmintbl(AdminsVO vo);
    //여기까지 세트

    //관리자 강등
    public int userroleDown(MemberVO mvo);
    public int adminroleDown(AdminsVO Avo);
    //여기까지


    //검색된 신고게시물수
    public int getSearchReportRecord(PagingVO pvo);
    //모든 신고게시물 수
    public int getReportTotalRecord();
    //검색된 신고게시물vo에 담기
    public List<ReportVO> selectReportWithSearch(PagingVO pvo);
    //모든 신고 게시물 vo에 담기
    public List<ReportVO> selectAllReport(PagingVO pvo);
    //방문자 2개
    public List<AllCountVO> getVisitorsByPeriod(int period);
    public List<AllCountVO> getYearlyVisitorCounts();
    //마라톤차트
    public List<MarathonCountVO>getCountregistration();
    //연간매출차트
    public List<AdminPaymentVO> getCountAPlist();
    //멤버 총인원 남여별 인원
    public List<MemCountVO> getCountMemlist();
    //남여별 나이대차트
    public List<AgeCountVO> GenderAgeCount(String gender);
    //일,월별가입자수
    public List<JoinsCountVO> JClist();
    //최신결제내역 가져오기
    public List<AdminPaymentVO> getNewPayment();
    //최신 Qna
    public List<QnAVO> getQnaList();
    //연간 매출top5
    public List<YearsTop5MarathonVO>getYearsTop5list(int year);
}
