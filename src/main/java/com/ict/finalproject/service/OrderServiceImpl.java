package com.ict.finalproject.service;

import com.ict.finalproject.dao.OrderDAO;
import com.ict.finalproject.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderDAO dao;

    @Override
    public void createOrder(OrderVO order) {
        dao.insertOrder(order); //주문추가
    }

    @Override
    public List<OrderVO> getOrderHistoryByUsername(String username) {
        return dao.getOrderHistoryByUsername(username);
    }


}
