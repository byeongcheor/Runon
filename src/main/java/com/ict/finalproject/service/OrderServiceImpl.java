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
        List<Integer> selectOvo = dao.selectOvo(items);  // 기존에 주문이 없는 항목만 조회

        // 2. INSERT 처리: 기존에 주문이 없는 항목만 선택해서 새로 주문 추가
        if (selectOvo.size() > 0) {
            List<CartVO> cvoToInsert = dao.selectCvo(selectOvo);  // INSERT할 항목들 조회
            System.out.println("INSERT 처리할 항목 확인: " + selectOvo);
            dao.SetOrder(cvoToInsert);  // INSERT 처리
            System.out.println("INSERT된 항목: " + cvoToInsert);
        }

        // 3. UPDATE 처리: 기존에 이미 주문된 항목들에 대해 업데이트
        List<CartVO> existingCvo = dao.selectCvo(items);  // 모든 항목 조회 (기존에 있는 항목 포함)
        System.out.println("UPDATE 처리할 항목 확인: " + existingCvo);
        for (CartVO cart : existingCvo) {
            dao.updateOrder(cart);  // 개별 항목 업데이트
            System.out.println("UPDATE된 항목: " + cart);
        }

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
