package com.ict.finalproject.service;

import com.ict.finalproject.dao.CartDAO;
import com.ict.finalproject.vo.CartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private CartDAO dao;


    @Override
    public List<CartVO> getCartItemsByUsername(String username) {
        return dao.getCartItemsByUsername(username);
    }
}
