package com.ict.finalproject.service;

import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MateVO;
import com.ict.finalproject.vo.OrderVO;

import java.util.List;

public interface CartService {
    int usercodeSelect(String user_name);
    List<CartVO> getCartItemsByUserCode(int usercode);
    public List<CartVO> userselect(int usercode);
    // -+버튼을 누를때 마다 업데이트 선택수량 업데이트
    public int updatecart(String action,int cart_code);
    // cart 삭제(안보이게 업데이트)
    public void deletedcart(List<Integer> items);

}
