package com.ict.finalproject.service;

import com.ict.finalproject.dao.AdminPagesDAO;
import com.ict.finalproject.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
    public List<MemberVO> selectMembers() {
        return dao.selectMembers();
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


//    @Override
//    public List<MemberVO> searchUser(String type, String value) {
//        return dao.searchUser(type, value);
//    }


}
