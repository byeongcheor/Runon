package com.ict.finalproject.service;

import com.ict.finalproject.vo.CartVO;

import java.util.List;

public interface CartService {
    List<CartVO> getCartItemsByUsername(String username); // 사용자 이름으로 장바구니 아이템 조회

}
