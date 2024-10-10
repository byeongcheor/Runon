package com.ict.finalproject.service;

import com.ict.finalproject.vo.MateVO;
import com.ict.finalproject.vo.MemberVO;

import java.util.List;
import java.util.Map;

public interface MemberService {
    public MemberVO disableCheck(String username);
    public int enableUser(String username);

}
