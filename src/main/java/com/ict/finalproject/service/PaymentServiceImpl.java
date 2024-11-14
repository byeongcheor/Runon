package com.ict.finalproject.service;

import com.ict.finalproject.dao.PaymentDAO;
import com.ict.finalproject.vo.*;
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
        System.out.println(cart_codes);
        System.out.println("카트에 있는 값 구하기"+cart_codes.size());
        List<OrderVO> Ovos=dao.selectOrdercode(cart_codes,usercode);
        System.out.println("ovos현재리스트"+Ovos);
        System.out.println("ovos현재갯수"+Ovos.size());
        int paymentCode= dao.selectPaymentCode(usercode);
        System.out.println("paymentCode코드"+paymentCode);
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
        System.out.println("지금현재3개"+paymentDetails);
        System.out.println("실제갯수"+paymentDetails.size());
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

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int orderSuccess(String method, int usercode, String orderId, int realAmount,String paymentKey) {
        int details=dao.updateDetails(orderId,usercode);
        System.out.println(details);
        if (details>0){
            //int updatepoint=dao.updateMypoint(realAmount,usercode,orderId);
            int payment=dao.updatepayments(realAmount,usercode,method,paymentKey);
            System.out.println("1번째확인");
            if (payment!=0) {
                System.out.println("2번째확인");
                List<Integer> cart_codes = dao.selectCartCode(usercode);
                System.out.println(cart_codes);
                int cart_deleted = dao.deletedCart_code(cart_codes);
                if (cart_deleted!=0){
                    int order=dao.updateOrder(usercode);
                    System.out.println("마지막확인");
                    return 1;
                }
            }

        }
        return 0;
    }

    @Override
    public List<CompleteVO> selectCvoList(String orderId) {
        return dao.selectCvoList(orderId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updatepoint(int usercode, String orderId) {
        PaymentVO pvo =dao.selectdiscount(orderId,usercode);
        System.out.println(pvo);
        dao.updateMypoint(pvo);
        dao.updateChangePoint(pvo);
        System.out.println("포인트체인지");
    }

    @Override
    public List<CompleteVO> getPDVO(List<Integer> codes) {
        return dao.getPDVO(codes);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int refundpay(RefundVO rvo){
        System.out.println(rvo);
        int insertR=dao.insertRefund(rvo);
        int updateDetail=dao.updatepayDetail(rvo);
        int updatePay=dao.updatePay(rvo);
        List<Integer> order_codes=dao.selectorderCodes(rvo);
        int updateOrder=dao.updateOrderstatus(order_codes);
        if (rvo.getReturn_discount()!=0){
            int updatePoint=dao.updatePoint(rvo.getReturn_discount());
            int insertPointc=dao.insertPoint(rvo);
        }
        System.out.println("오는것 확인");
        return 0;
    }
}
