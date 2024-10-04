package com.ict.finalproject.service;

import com.ict.finalproject.dao.CartDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private CartDAO dao;
}
