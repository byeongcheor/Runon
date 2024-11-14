package com.ict.finalproject.dao;

import com.ict.finalproject.vo.*;
import org.apache.ibatis.annotations.Param;

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
    /*public int setDisableUserTime(int usercode,int disableday);*/
    public int setDisableUserTime(@Param("usercode") int usercode, @Param("disableday") int disableday);

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
    public int insertAdmintbl(AdminsVO vo);
    public void updateAdmintbl(AdminsVO vo);
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
    //신고번호보내서 신고디테일받기
    public ReportVO getReportDetail(int report_code);

    //신고리플달기
    public void setReportReply(ReportVO vo);
    public void updateReport(ReportVO vo);
    //신고리플받기
    public ReportReplyVO getReportReply(int report_code);
    //기록인증
    public int getCertificaterecode(PagingVO pvo);
    //전체 레코드수
    public int getCertificateTotalRecord (PagingVO pvo);
    //검색된 기록인증리스트
    public List<CertificateVO> selectWithSearchCertificateList(PagingVO pvo);
    //전체 기록인증 리스트
    public List<CertificateVO> selectAllCertificateList(PagingVO pvo);
    //한코드의 기록디테일
    public CertificateVO getCertificateDetail(int certificate_code);
    //개인전적업데이트
    public int updateRecord(int record,int certificate_code);
    //포인트 업데이트
    public int updatePoint(int record,int certificate_code);
    //point_code가져오기
    public int getPointCode(int certificate_code);
    //point_change_tbl
    public int insertPointChangetbl(int record,int point_code);
    //거리인증마무리update
    public int updatecertificate(int certificate_code);
    //크루전적업데이트
    public int updateCrewRecord(@Param("record") int record,
                                @Param("certificate_code") int certificateCode,
                                @Param("crew_member_code") int crewMemberCode);

    //검색된 결제내역수
    public int getSearchPaymentRecord(PagingVO pvo);
    //검색된 결제내역리스트
    public List<PaymentVO> getPaymentSearchList(PagingVO pvo);
    //모든 결제내역수
    public int getPaymentRecord(PagingVO pvo);
    //모든 결제내역리스트
    public List<PaymentVO>getPaymentList(PagingVO pvo);
    //검색된 qna수
    public int getSearchQnaRecord(PagingVO pvo);
    //검색된 qnalist
    public List<QnAVO>getSearchQnaLists(PagingVO pvo);
    //모든 qna수
    public int getQnaRecord();
    //모든 qna리스트
    public List<QnAVO>getQnaLists(PagingVO pvo);
    //qna_code로 디테일받기
    public QnAVO getQnaDetail(int qna_code);
    //qna_code로 answer_tbl값 가져오기
    public AnswerVO getAnswer(int qna_code);
    //answer등록
    public int insertAnswer(int qna_code,int usercode,String content);
    //등록되면 업데이트
    public int updateqna(int qna_code);
    //답변수정
    public void updateAnswer(int qna_code,int usercode,String content);





    //검색된 마라톤게시물수
    public int getSearchBoardRecord(PagingVO pvo);
    //모든 마라톤게시물수
    public int getBoardTotalRecord();
    //검색된 마라톤게시물vo에 담기
    public List<MarathonListVO> selectBoardWithSearch(PagingVO pvo);
    //모든  마라톤 게시물 vo에 담기
    public List<MarathonListVO> selectAllBoard(PagingVO pvo);
    //마라톤 리스트 엑셀
    List<MarathonListVO> selectMarathons(); // 마라톤 리스트 조회 메서드
    // 검색된 게시물의 총 레코드 수를 가져오는 메서드
    int getSearchBoardRecordForStatus(PagingVO pvo);

    // 검색 조건에 따른 게시물 목록을 가져오는 메서드
    List<MarathonListVO> selectBoardWithSearchForStatus(PagingVO pvo);


    public String selectRole(int usercode);

    public AdminsVO selectAdmin(int usercode);
}
