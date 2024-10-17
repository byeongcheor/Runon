package com.ict.finalproject.service;

import com.ict.finalproject.dao.OrderDAO;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.OrderVO;
import com.ict.finalproject.vo.PointVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderDAO dao;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<CartVO> SetOrder(List<Integer> items) {
        List<Integer> selectOvo=dao.selectOvo(items);
        if(selectOvo.size()>0){
        List<CartVO> Cvo=dao.selectCvo(selectOvo);

        System.out.println("반환값 확인"+selectOvo);
        dao.SetOrder(Cvo);
        System.out.println(Cvo);
            return Cvo;}
        else{
            List<CartVO> Cvo=dao.selectCvo(items);
            System.out.println(Cvo);
            return Cvo;
        }

    }

    @Override
    public PointVO getMyPoint(int usercode) {
        return dao.getMyPoint(usercode);
    }
}
