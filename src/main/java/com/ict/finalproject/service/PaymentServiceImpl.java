package com.ict.finalproject.service;

import com.ict.finalproject.dao.PaymentDAO;
import com.ict.finalproject.vo.OrderVO;
import com.ict.finalproject.vo.PaymentVO;
import com.ict.finalproject.vo.PaymentdetailVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class PaymentServiceImpl implements PaymentService {
    @Autowired
    PaymentDAO dao;


    @Override

    public int createPayment(PaymentVO pvo) {
        int result=dao.selectPayment(pvo);
        System.out.println(result);
        if (result==0){
            dao.createPayment(pvo);
            return result;
        }else{
            dao.updatePayment(pvo);

        }
        return 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int setPayment(PaymentdetailVO PDvo, int usercode,List<Integer> cart_codes) {
        List<OrderVO> Ovos=dao.selectOrdercode(cart_codes,usercode);
        int paymentCode= dao.selectPaymentCode(usercode);
        String orderId= PDvo.getOrderId();
        List<PaymentdetailVO> paymentDetails = new ArrayList<>();
        for (OrderVO ovo : Ovos) {
            PaymentdetailVO paymentDetail = new PaymentdetailVO();

            // 동일한 orderId와 paymentCode 설정
            paymentDetail.setOrderId(orderId);
            paymentDetail.setPayment_code(paymentCode);

            // OrderVO에서 개별 값을 설정
            paymentDetail.setOrder_code(ovo.getOrder_code());
            paymentDetail.setTotal_amount(ovo.getTotal_amount());

            // PaymentdetailVO 리스트에 추가
            paymentDetails.add(paymentDetail);
        }
        // DB에서 이미 존재하는 PaymentdetailVO 조회
        List<PaymentdetailVO> existingDetails = dao.selectDetails(paymentDetails);

// 중복되지 않은 PaymentdetailVO를 담을 리스트
        List<PaymentdetailVO> newDetails = new ArrayList<>();

// 삭제 표시할 PaymentdetailVO를 담을 리스트
        List<PaymentdetailVO> toDeleteDetails = new ArrayList<>();

// 1. 기존에 존재하는 항목을 확인하고, 중복되지 않는 항목을 처리
        for (PaymentdetailVO detail : paymentDetails) {
            boolean exists = false;
            for (PaymentdetailVO existingDetail : existingDetails) {
                if (detail.getOrder_code() == existingDetail.getOrder_code() &&
                        detail.getPayment_code() == existingDetail.getPayment_code() &&
                        detail.getOrderId().equals(existingDetail.getOrderId())) {
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                newDetails.add(detail);  // 중복되지 않는 경우에만 추가
            }
        }

// 2. 기존에 있는 데이터 중에 paymentDetails에 없는 항목을 찾아 is_deleted 처리
        for (PaymentdetailVO existingDetail : existingDetails) {
            boolean stillExists = false;
            for (PaymentdetailVO detail : paymentDetails) {
                if (existingDetail.getOrder_code() == detail.getOrder_code() &&
                        existingDetail.getPayment_code() == detail.getPayment_code() &&
                        existingDetail.getOrderId().equals(detail.getOrderId())) {
                    stillExists = true;
                    break;
                }
            }
            if (!stillExists) {
                toDeleteDetails.add(existingDetail);  // paymentDetails에 없는 항목 추가 (삭제될 항목)
            }
        }

// 3. 중복되지 않은 데이터가 있을 때만 DB에 삽입
        if (!newDetails.isEmpty()) {
            dao.insertPaymentDetails(newDetails);  // 중복되지 않은 데이터만 삽입
        }

// 4. DB에 더 많았던 항목들을 삭제 표시(is_deleted = 1)
        if (!toDeleteDetails.isEmpty()) {
            dao.updateToDeleted(toDeleteDetails);  // DB에서 더 많았던 항목은 삭제 표시
        }
        return 1;
    }
}
