package com.ict.finalproject.service;

import com.ict.finalproject.dao.OrderDAO;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MarathonFormVO;
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

    /*   // 기존에 주문이 없는 항목만 조회
        List<Integer> existingOrders = dao.selectExistingOrders(items);
        System.out.println(existingOrders);
        // 1. 기존 주문 삭제
        if (existingOrders.size() > 0) {*/
            System.out.println("확인1");
            dao.deleteOrder(items);  // 기존 주문 비활성화
       /* }*/
// 2. INSERT 처리: 새로운 주문 추가
        List<Integer> selectOvo = dao.selectOvo(items);
        if (selectOvo.size() > 0) {
            List<CartVO> cvoToInsert = dao.selectCvo(selectOvo);  // INSERT할 항목들 조회
            dao.SetOrder(cvoToInsert);  // 새로운 주문 추가
        }


        List<CartVO> existingCvo = dao.selectCvo(items);
     /*   for (CartVO cart : existingCvo) {
            dao.updateOrder(cart);  // 기존 주문 항목 업데이트
        }
*/
        return existingCvo;  // 모든 주문된 항목 반환
    }



    @Override
    public PointVO getMyPoint(int usercode) {
        return dao.getMyPoint(usercode);
    }

    @Override
    public MarathonFormVO selectMyForm(int usercode) {
        return dao.selectMyForm(usercode);
    }
}
