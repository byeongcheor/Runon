package com.ict.finalproject.service;

import com.ict.finalproject.dao.CrewDAO;
import com.ict.finalproject.vo.CrewVO;
import com.ict.finalproject.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CrewServiceImpl implements CrewService{
    @Autowired
    private CrewDAO dao;

    @Override
    public List<CrewVO> crewSelectPaging(PagingVO pVO)
    {
        return dao.crewSelectPaging(pVO);
    }

    @Override
    public List<CrewVO> crew_page_select(int user_code)
    {
        return dao.crew_page_select(user_code);
    }

    @Override
    public List<CrewVO> search_crewList(int page, String orderby, String gender , String age, String addr_gu, String searchWord)
    {
        return dao.search_crewList(page, orderby, gender, age, addr_gu, searchWord);
    }

    @Override
    public int totalRecord(PagingVO pVO)
    {
        return dao.totalRecord(pVO);
    }

    @Override
    public int usercodeSelect(String user_name) {
        return dao.usercodeSelect(user_name);
    }

    @Override
    public int crew_insert(String crew_name, String fileName, String addr, String addr_gu, String gender, String content,String age, int user_code) {
        return dao.crew_insert(crew_name,fileName,addr,addr_gu,gender,content,age,user_code);
    }


}
