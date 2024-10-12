package com.ict.finalproject.service;

import com.ict.finalproject.vo.CrewVO;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface CrewService {
    public List<CrewVO> crewSelectPaging(PagingVO pVO);
    public List<CrewVO> crew_page_select(int user_code);
    public List<CrewVO> crew_wait_select(int user_code);
    public List<CrewVO> crew_write_detail_select(int user_code, int crewCode);
    public List<CrewVO> crew_manage_member(int crewCode);
    public List<CrewVO> crew_wait_detail(int user_code, int crewCode);
    public List<CrewVO> crew_page_write_detail(int crew_page_write_detail);
    public List<CrewVO> crew_write_detail_check(int crew_write_code);
    public List<CrewVO> search_crewList(int page, String orderby, String gender , String age, String addr, String addr_gu, String searchWord);
    public int totalRecord(PagingVO pVO);
    public int update14();
    public int usercodeSelect(String user_name);
    public int crew_code_select(int user_code);
    public int crew_write_hit_update(int writeCrewCode);
    public int crew_name_check(String crew_name_check);
    public int crew_insert(String crew_name, String fileName, String addr, String addr_gu, String gender, String content, String age, int user_code);
    public int crew_write_add(int third_crew_code, int user_code, String teamPhotoInput, String age, String gender, String content);
    public int crew_write_update(int third_crew_code, int user_code, String teamPhotoInput, String age, String gender, String content);
    public int crew_join_write(int user_code, int crewCode, String join_content);
    public int crew_join_select(int user_code, int crewCode);
    public int join_before_select(int user_code, int crewWriteCode);
    public int crew_write_delete(int user_code, int crewWriteCode);
    public int crew_join_delete(int user_code, int crewCode);
    public int crew_member_insert(int user_code, int crewCode, int crew_position);

}
