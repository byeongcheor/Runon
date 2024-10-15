package com.ict.finalproject.service;

import com.ict.finalproject.vo.CrewVO;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface CrewService {
    public List<CrewVO> crewSelectPaging(PagingVO pVO);
    public List<CrewVO> crew_page_select(int user_code);
    public List<CrewVO> crew_wait_select(int user_code);
    public List<CrewVO> crew_write_detail_select(int user_code, int crewCode);
    public List<CrewVO> crew_manage_member(int crewCode, int user_code);
    public List<CrewVO> crew_manage_overview(int crewCode, int user_code);
    public List<CrewVO> crew_manage_notice(int crewCode, int user_code);
    public List<CrewVO> vote_select(int user_code, int vote_num);
    public List<CrewVO> crew_wait_detail(int user_code, int crewCode,int request_code);
    public List<CrewVO> crew_page_write_detail(int crew_page_write_detail);
    public List<CrewVO> crew_write_detail_check(int crew_write_code);
    public List<CrewVO> crew_app_select(int crew_code);
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
    public int crew_member_insert2(int user_code, int crewCode);
    public int crew_manage_app(int user_code, int crewCode, int status, String reason, int request_code);
    public int crew_member_insert(int user_code, int crewCode, int crew_position);
    public int crew_member_check(int user_code, int crewCode);
    public int crew_member_upgrade(int user_code, int crewCode);
    public int crew_member_downgrade(int user_code, int crewCode);
    public int vote_create(int user_code, int crewCode, String endDate, String title, String opt1,String opt2,String opt3,String opt4,String opt5);
    public int crew_member_out(int user_code, int crewCode);
    public int crew_history_insert(int user_code, int crewCode, int flag);
    public int crew_member_report(int user_code, int my_user_code, String reason, String reason_text);
    public int vote_chek(int user_code, int vote_num);
    public int vote_insert(int user_code, int vote_num, String selectedOption);
}
