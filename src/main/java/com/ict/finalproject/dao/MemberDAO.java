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
    //구글로그인시 일반회원이랑 같은 아이디가 있는지 확인
    public int is_googleSelect(String username);
    //구글로그인시 기존가입자인지 확인
    public int googleSelect(String username);
    //구글로그인시 회원가입
    public int googleJoins(String username,String name,String nickname);
}
