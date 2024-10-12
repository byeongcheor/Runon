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
    public List<CrewVO> crew_wait_select(int user_code)
    {
        return dao.crew_wait_select(user_code);
    }

    @Override
    public List<CrewVO> crew_page_write_detail(int crew_page_write_detail)
    {
        return dao.crew_page_write_detail(crew_page_write_detail);
    }

    @Override
    public List<CrewVO> crew_write_detail_check(int crew_write_code)
    {
        return dao.crew_write_detail_check(crew_write_code);
    }

    @Override
    public List<CrewVO> search_crewList(int page, String orderby, String gender , String age, String addr, String addr_gu, String searchWord)
    {
        return dao.search_crewList(page, orderby, gender, age, addr, addr_gu, searchWord);
    }

    @Override
    public List<CrewVO> crew_write_detail_select(int user_code, int crewCode)
    {
        return dao.crew_write_detail_select(user_code, crewCode);
    }

    @Override
    public List<CrewVO> crew_wait_detail(int user_code, int crewCode)
    {
        return dao.crew_wait_detail(user_code, crewCode);
    }

    @Override
    public List<CrewVO> crew_manage_member( int crewCode)
    {
        return dao.crew_manage_member(crewCode);
    }

    @Override
    public int crew_join_select(int user_code, int crewCode)
    {
        return dao.crew_join_select(user_code, crewCode);
    }

    @Override
    public int crew_code_select(int user_code)
    {
        return dao.crew_code_select(user_code);
    }

    @Override
    public int join_before_select(int user_code, int crewWriteCode)
    {
        return dao.join_before_select(user_code, crewWriteCode);
    }

    @Override
    public int crew_write_delete(int user_code, int crewWriteCode)
    {
        return dao.crew_write_delete(user_code, crewWriteCode);
    }

    @Override
    public int update14()
    {
        return dao.update14();
    }

    @Override
    public int crew_join_delete(int user_code, int crewCode)
    {
        return dao.crew_join_delete(user_code, crewCode);
    }

    @Override
    public int crew_member_insert(int user_code, int crewCode, int crew_position)
    {
        return dao.crew_member_insert(user_code, crewCode, crew_position);
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
    public int crew_write_hit_update(int writeCrewCode) {
        return dao.crew_write_hit_update(writeCrewCode);
    }

    @Override
    public int crew_join_write(int user_code, int crewCode, String join_content) {
        return dao.crew_join_write(user_code,crewCode,join_content);
    }

    @Override
    public int crew_name_check(String crew_name_check) {
        return dao.crew_name_check(crew_name_check);
    }

    @Override
    public int crew_insert(String crew_name, String fileName, String addr, String addr_gu, String gender, String content,String age, int user_code) {
        return dao.crew_insert(crew_name,fileName,addr,addr_gu,gender,content,age,user_code);
    }

    @Override
    public int crew_write_add(int third_crew_code, int user_code, String teamPhotoInput, String age, String gender, String content) {
        return dao.crew_write_add(third_crew_code, user_code, teamPhotoInput,age,gender,content);
    }

    @Override
    public int crew_write_update(int third_crew_code, int user_code, String teamPhotoInput, String age, String gender, String content) {
        return dao.crew_write_update(third_crew_code, user_code, teamPhotoInput,age,gender,content);
    }


}
