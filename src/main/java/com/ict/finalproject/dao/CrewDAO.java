package com.ict.finalproject.dao;

import com.ict.finalproject.vo.CreateCrew;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface CrewDAO {
    public List<CreateCrew> crewSelectPaging(PagingVO pvo);
    public int totalRecord(PagingVO pvo);
}
