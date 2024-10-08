package com.ict.finalproject.service;

import com.ict.finalproject.vo.OrderVO;

import java.util.List;

public interface OrderService {
    void createOrder(OrderVO order); // 주문 생성
    List<OrderVO> getOrderHistoryByUsername(String username);

}
