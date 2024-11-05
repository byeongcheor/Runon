package com.ict.finalproject.service;

import com.ict.finalproject.dao.ExcelDAO;
import com.ict.finalproject.dto.ExcelDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ExcelServiceImpl implements ExcelService {
    @Autowired
    ExcelDAO dao;

    @Override
    public int insertExcel(ExcelDTO excel) {
        return dao.insertExcel(excel);
    }
}
