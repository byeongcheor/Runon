package com.ict.finalproject.service;

import com.ict.finalproject.vo.CompleteVO;
import com.ict.finalproject.vo.PaymentVO;
import com.ict.finalproject.vo.PaymentdetailVO;
import com.ict.finalproject.vo.RefundVO;

import java.util.List;

public interface PaymentService {

    //결제테이블에 값넣기
    public int createPayment(PaymentVO pvo);

    public int setPayment(PaymentdetailVO PDvo, int usercode, List<Integer> cart_codes);
    public int orderSuccess(String method,int usercode,String orderId,int realAmount,String paymentKey);
    public List<CompleteVO> selectCvoList(String orderId);
    public void updatepoint( int usercode,String orderId);
    public List<CompleteVO> getPDVO(List<Integer>codes);
    public int refundpay(RefundVO rvo);

}
