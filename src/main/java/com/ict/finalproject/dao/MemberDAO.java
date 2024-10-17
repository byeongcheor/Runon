package com.ict.finalproject.dao;

import com.ict.finalproject.vo.MemberVO;

import java.util.List;
import java.util.Map;

public interface MemberDAO {

    MemberVO findByUsername(String username);

    Boolean existsByUsername(String username);

    int saveUser(MemberVO vo);

    int idDoubleCheck(String username);

    int nickCheck(String nickname);

    int addPoint(String username);
    void addpoint_change_code(int usercode);
    int selectUserCode(String username);

    int addPointCode(int usercode);

    MemberVO getUsers(String username);

    //정지여부확인
    public MemberVO disableCheck(String username);
    //정지 시간을 확인후 풀렸으면 업데이트
    public int enableUser(String username);

}
