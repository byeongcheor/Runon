package com.ict.finalproject.service;

import com.ict.finalproject.dao.PointDAO;
import com.ict.finalproject.dao.ReportDAO;
import com.ict.finalproject.vo.ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReportServiceImpl implements ReportService{
    @Autowired
    private ReportDAO dao;


    @Override
    public List<ReportVO> getReportsByUserCode(int usercode) {
        return dao.getReportsByUserCode(usercode);
    }

    @Override
    public void updateReportStatus(ReportVO reportVO) {
        dao.updateReportStatus(reportVO);
    }
}
