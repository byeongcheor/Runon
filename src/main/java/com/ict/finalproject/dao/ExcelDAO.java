package com.ict.finalproject.dao;

import com.ict.finalproject.dto.ExcelDTO;

public interface ExcelDAO {
    //엑셀값 받아서 저장하기
    public int insertExcel(ExcelDTO excel);
}
