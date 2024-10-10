package com.ict.finalproject.dao;

import com.ict.finalproject.vo.CartVO;

import java.util.List;

public interface CartDAO {
    int usercodeSelect(String user_name);
    List<CartVO> getCartItemsByUserCode(int usercode);
    public List<CartVO> userselect(int usercode);
}
