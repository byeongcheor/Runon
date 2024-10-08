package com.ict.finalproject.service;

import com.ict.finalproject.dao.AdminPagesDAO;
import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.PagingVO;
import com.ict.finalproject.vo.RecordVO;
import com.ict.finalproject.vo.ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
