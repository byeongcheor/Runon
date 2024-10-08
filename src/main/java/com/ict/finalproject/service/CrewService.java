package com.ict.finalproject.service;

import com.ict.finalproject.vo.CrewVO;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface CrewService {
    public List<CrewVO> crewSelectPaging(PagingVO pVO);
    public List<CrewVO> crew_page_select(int user_code);
    public List<CrewVO> search_crewList(int page, String orderby, String gender , String age, String addr_gu, String searchWord);
    public int totalRecord(PagingVO pVO);
    public int usercodeSelect(String user_name);
    public int crew_insert(String crew_name, String fileName, String addr, String addr_gu, String gender, String content, String age, int user_code);
}
