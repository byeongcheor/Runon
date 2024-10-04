package com.ict.finalproject.service;

import com.ict.finalproject.vo.CreateCrew;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface CrewService {
    public List<CreateCrew> crewSelectPaging(PagingVO pvo);
    public int totalRecord(PagingVO pvo);
}
