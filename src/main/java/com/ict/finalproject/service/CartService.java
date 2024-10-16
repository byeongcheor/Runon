package com.ict.finalproject.service;

import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MateVO;
import com.ict.finalproject.vo.ReportVO;

import java.util.List;

public interface CartService {
    int usercodeSelect(String user_name);
    List<CartVO> getCartItemsByUserCode(int usercode);
    public List<CartVO> userselect(int usercode);
}
