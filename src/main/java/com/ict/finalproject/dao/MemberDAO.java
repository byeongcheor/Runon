package com.ict.finalproject.dao;

import com.ict.finalproject.dto.JoinDTO;
import com.ict.finalproject.vo.MemberVO;

public interface MemberDAO {

    MemberVO findByUsername(String username);

    Boolean existsByUsername(String username);

    void saveUser(MemberVO user);



}
