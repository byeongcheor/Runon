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

    int selectUserCode(String username);

    int addPointCode(int usercode);

    MemberVO getUsers(String username);
}
