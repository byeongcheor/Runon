package com.ict.finalproject.dao;

import com.ict.finalproject.vo.OrderVO;

import java.util.List;

public interface OrderDAO {
    void insertOrder(OrderVO order); // 주문 생성
    List<OrderVO> getOrderHistoryByUsername(String username);
}
