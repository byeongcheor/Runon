package com.ict.finalproject.service;

import com.ict.finalproject.dao.CartDAO;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private CartDAO dao;



    @Override
    public int usercodeSelect(String user_name) {
        return dao.usercodeSelect(user_name);
    }

    @Override
    public List<CartVO> getCartItemsByUserCode(int usercode) {
        return dao.getCartItemsByUserCode(usercode);
    }

    @Override
    public List<CartVO> userselect(int usercode) {
        return dao.userselect(usercode);
    }

}
