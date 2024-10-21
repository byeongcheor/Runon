package com.ict.finalproject.service;

import com.ict.finalproject.dao.AdminPagesDAO;
import com.ict.finalproject.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AdminPagesServiceImpl implements AdminPagesService {
    @Autowired
    AdminPagesDAO dao;

    @Override
    public int getTotalRecord() {
        return dao.getTotalRecord();
    }

    @Override
    public List<MemberVO> selectAllUser(PagingVO pvo) {
        return dao.selectAllUser(pvo);
    }

    @Override
    public List<MemberVO> selectMembers(String role) {
        return dao.selectMembers(role);
    }

    @Override
    public List<ReportVO> getUserReport(int usercode) {
        return dao.getUserReport(usercode);
    }

    @Override
    public MemberVO selectOneUser(int usercode) {
        return dao.selectOneUser(usercode);
    }

    @Override
    public List<RecordVO> getRecord(int usercode) {
        return dao.getRecord(usercode);
    }

    @Override
    public List<AdminPaymentVO> selectInPay(int usercode) {
        return dao.selectInPay(usercode);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertAndDel(int usercode) {
        // 탈퇴한 목록에 추가
        int a=dao.insert(usercode);
        // 포인트 테이블에서 해당유저 삭제
        int b=dao.delpoint(usercode);
        //
        int c=dao.deluser(usercode);
        if (a !=1 || b!=1 || c!=1){
            return 0;
        }
        return 1;
    }

    @Override
    public int setDisableUserTime(int usercode, int disableday) {
        return dao.setDisableUserTime(usercode, disableday);
    }

    @Override
    public int setEnableUser(int usercode) {
        return dao.setEnableUser(usercode);
    }

    @Override
    public int getTotalRecordWithSearch(PagingVO pvo) {
        return dao.getTotalRecordWithSearch(pvo);
    }

    @Override
    public List<MemberVO> selectUserWithSearch(PagingVO pvo) {
        return dao.selectUserWithSearch(pvo);
    }

    @Override
    public List<MemberVO> selectedMembers(List<String> usercodes) {
        return dao.selectedMembers(usercodes);
    }

    @Override
    public int getSearchAdminTotalRecord(PagingVO pvo) {
        return dao.getSearchAdminTotalRecord(pvo);
    }

    @Override
    public int getAdminTotalRecord() {
        return dao.getAdminTotalRecord();
    }

    @Override
    public List<AdminsVO> selectAllAdmin(PagingVO pvo) {
        return dao.selectAllAdmin(pvo);
    }
    @Override
    public List<AdminsVO> selectAdminWithSearch(PagingVO pvo) {
        return dao.selectAdminWithSearch(pvo);
    }

    @Override
    public AdminsVO selectAdminRole(int usercode) {
        return dao.selectAdminRole(usercode);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateRole(AdminsVO vo) {
        int a=dao.updateRole(vo);
        int b =dao.updateUserRole(vo);
        if (a!=1&& b!=1){
            return 0;
        }
        return 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int UpdateUser(AdminsVO Avo, MemberVO mvo) {
        int a= dao.UpdateUsertbl(mvo);
        int b= dao.UpdateAdmintbl(Avo);
        if (a !=1 || b!=1){
            return 0;
        }
        return 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int roleDown(MemberVO mvo, AdminsVO Avo) {
        int a = dao.userroleDown(mvo);
        int b = dao.adminroleDown(Avo);
        if (a !=1 || b!=1){
            return 0;
        }
        return 1;
    }

    @Override
    public int getSearchReportRecord(PagingVO pvo) {
        return dao.getSearchReportRecord(pvo);
    }

    @Override
    public int getReportTotalRecord() {
        return dao.getReportTotalRecord();
    }

    @Override
    public List<ReportVO> selectReportWithSearch(PagingVO pvo) {
        return dao.selectReportWithSearch(pvo);
    }

    @Override
    public List<ReportVO> selectAllReport(PagingVO pvo) {
        return dao.selectAllReport(pvo);
    }

    /*@Override
    public List<VisitorCountVO> getVisitorsByDateRange(String period) {
        List<VisitorCountVO> visitorCounts=dao.getVisitorsByDateRange();
        LocalDate today = LocalDate.now();
        List<VisitorCountVO> completeData = new ArrayList<>();

        for (int i = 6; i >= 0; i--) { // 최근 7일을 반복
            LocalDate date = today.minusDays(i);
            String formattedDate = date.toString(); // YYYY-MM-DD 형식
            Optional<VisitorCountVO> visitorCount = visitorCounts.stream()
                    .filter(v -> v.getVisit_date().equals(formattedDate))
                    .findFirst();

            if (visitorCount.isPresent()) {
                completeData.add(visitorCount.get()); // 방문자 수가 존재하는 경우 추가
            } else {
                completeData.add(new VisitorCountVO(formattedDate, 0)); // 방문자 수가 없는 경우 0 추가
            }
        }

        return completeData;
    }
*/
/*

    @Override
    public List<VisitorCountVO> getVisitorsByDateRange(String period) {
       // 기간에 따라 방문자 수 조회
        LocalDate today = LocalDate.now();
        List<VisitorCountVO> completeData = new ArrayList<>();

        // 기간에 따라 날짜를 설정합니다.
        int daysToCheck = 0;
        switch (period) {
            case "7days":
                daysToCheck = 6; // 오늘 포함하여 7일
                break;
            case "weekly":
                daysToCheck = 29; // 오늘 포함하여 30일
                break;
            case "monthly":
                daysToCheck = 364; // 오늘 포함하여 1년
                break;
            case "yearly":
                // 연도별 처리는 따로 로직이 필요함 (예: 특정 연도만 가져오기)
                // 예를 들어, 연도별로 각 연도에 대한 방문자 수를 가져오면 별도의 처리 필요
                return  dao.getYearlyVisitorCounts(); // 연도별 방문자 수 조회
            default:
                return new ArrayList<>(); // 기본값 처리
        }
        // 기간에 따라 방문자 수를 가져옵니다.
        List<VisitorCountVO> visitorCounts = dao.getVisitorsByPeriod(daysToCheck);

        // 지정된 기간 동안 날짜를 반복하여 방문자 수를 확인
        for (int i = daysToCheck; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            String formattedDate = date.toString(); // YYYY-MM-DD 형식
            Optional<VisitorCountVO> visitorCount = visitorCounts.stream()
                    .filter(v -> v.getVisit_date().equals(formattedDate))
                    .findFirst();

            if (visitorCount.isPresent()) {
                // 존재하는 경우 추가
                completeData.add(new VisitorCountVO(visitorCount.get().getVisit_date(), visitorCount.get().getVisitor_count()));
            } else {
                // 없는 경우 0으로 추가
                completeData.add(new VisitorCountVO(formattedDate, 0));
            }
        }

        return completeData; // 결과 반환
    }
*/

    @Override
    public List<AllCountVO> getVisitorsByDateRange(String period) {
        // 기간에 따라 방문자 수 조회
        LocalDate today = LocalDate.now();
        List<AllCountVO> completeData = new ArrayList<>();

        // 기간에 따라 방문자 수를 가져옵니다.
        List<AllCountVO> visitorCounts;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        switch (period) {
            case "7days":
                // 최근 7일 동안의 데이터 조회
                visitorCounts = dao.getVisitorsByPeriod(7); // 7일간의 방문자 수
                for (int i = 6; i >= 0; i--) {
                    LocalDate date = today.minusDays(i);
                    String formattedDate = date.toString(); // YYYY-MM-DD 형식
                    Optional<AllCountVO> visitorCount = visitorCounts.stream()
                            .filter(v -> v.getVisit_date().equals(formattedDate))
                            .findFirst();
                    completeData.add(visitorCount.orElse(new AllCountVO(formattedDate, 0))); // 방문자 수가 없으면 0
                }
                break;

            case "weekly":
                visitorCounts = dao.getVisitorsByPeriod(30); // 30일간의 방문자 수
                for (int i = 0; i < 4; i++) { // 4주
                    LocalDate startOfWeek = today.minusDays(i * 7);
                    LocalDate endOfWeek = startOfWeek.plusDays(6);
                    String formattedDate = startOfWeek.toString(); // 주의 시작 날짜

                    long visitorCount = visitorCounts.stream()
                            .filter(v -> {
                                LocalDate visitDate = LocalDate.parse(v.getVisit_date(), formatter); // 문자열을 LocalDate로 변환
                                return !visitDate.isBefore(startOfWeek) && !visitDate.isAfter(endOfWeek);
                            })
                            .mapToLong(AllCountVO::getVisitor_count)
                            .sum(); // 해당 주의 총 방문자 수

                    completeData.add(new AllCountVO(formattedDate,(int) visitorCount)); // 주별 방문자 수
                }
                break;

            case "monthly":
                // 지난 1년 동안의 월별 데이터 조회
                visitorCounts = dao.getVisitorsByPeriod(365); // 1년간의 방문자 수
                for (int month = 0; month < 12; month++) { // 12개월
                    LocalDate date = today.minusMonths(month);
                    String formattedDate = date.toString().substring(0, 7); // YYYY-MM 형식
                    long visitorCount = visitorCounts.stream()
                            .filter(v -> v.getVisit_date().startsWith(formattedDate)) // 월별로 필터링
                            .mapToLong(AllCountVO::getVisitor_count)
                            .sum(); // 해당 월의 총 방문자 수

                    completeData.add(new AllCountVO(formattedDate, (int)visitorCount)); // 월별 방문자 수
                }
                break;

            case "yearly":
                // 오픈일부터 현재까지의 연도별 데이터 조회
                visitorCounts = dao.getYearlyVisitorCounts(); // 연도별 방문자 수
                int currentYear = today.getYear();
                for (int year = 2021; year < currentYear; year++) {
                    String formattedDate = String.valueOf(year + 1); // YYYY 형식
                    long visitorCount = visitorCounts.stream()
                            .filter(v -> v.getVisit_date().equals(formattedDate))
                            .mapToLong(AllCountVO::getVisitor_count)
                            .findFirst()
                            .orElse(0); // 해당 연도의 총 방문자 수

                    completeData.add(new AllCountVO(formattedDate, (int)visitorCount)); // 연도별 방문자 수
                }
                break;

            default:
                return new ArrayList<>(); // 기본값 처리
        }

        return completeData; // 결과 반환
    }

    @Override
    public List<MarathonCountVO> getCountregistration() {

        return dao.getCountregistration();
    }

    @Override
    public List<AdminPaymentVO> getCountAPlist() {
        return dao.getCountAPlist();
    }

    @Override
    public List<MemCountVO> getCountMemlist() {
        return dao.getCountMemlist();
    }

    @Override
    public List<AgeCountVO> GenderAgeCount(String gender) {
        return dao.GenderAgeCount(gender);
    }

    @Override
    public List<JoinsCountVO> JClist() {
        return dao.JClist();
    }

    @Override
    public List<AdminPaymentVO> getNewPayment() {
        return dao.getNewPayment();
    }

    @Override
    public List<QnAVO> getQnaList() {
        return dao.getQnaList();
    }

    @Override
    public List<YearsTop5MarathonVO> getYearsTop5list(int year) {
        return dao.getYearsTop5list(year);
    }

    @Override
    public ReportVO getReportDetail(int report_code) {
        return dao.getReportDetail(report_code);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ReportReplyVO updateReport(ReportVO vo,int LoginUserCode) {
        AdminsVO loginAdmin=dao.selectAdminRole(LoginUserCode);
        vo.setAdmin_code(loginAdmin.getAdmin_code());
        System.out.println("신고코드"+vo.getReport_code());
        int disableday=vo.getIs_disabled();
        if (disableday!=0) {

            if (disableday==1){
                disableday=7;
                vo.setReport_result("7일 정지조치");
            }else if (disableday==2){
                disableday=14;
                vo.setReport_result("14일 정지조치");
            }else if (disableday==3){
                disableday=30;
                vo.setReport_result("30일 정지조치");
            }else if(disableday==4){
                disableday=999;
                vo.setReport_result("영구 정지조치");
            }
            //정지 실행
            dao.setDisableUserTime(vo.getOffender_code(),disableday);
            System.out.println("정지성공");
        }else{

            vo.setReport_result("경고 조치");
        }
            dao.setReportReply(vo);
        System.out.println("신고리플달기");
            dao.updateReport(vo);
        System.out.println("신고업데이트");
            //업데이한것 가져오기


        return dao.getReportReply(vo.getReport_code());
    }

    @Override
    public ReportReplyVO getReportReplys(int report_code) {
        return dao.getReportReply(report_code);
    }
}
