package com.ict.finalproject.service;

import com.ict.finalproject.dao.CartDAO;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Override
    public int updatecart(String action, int cart_code) {
        return dao.updatecart(action, cart_code);
    }

    @Override
    public void deletedcart(List<Integer> items) {
         dao.deletedcart(items);
    }


}
