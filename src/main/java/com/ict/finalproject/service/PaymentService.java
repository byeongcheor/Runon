package com.ict.finalproject.service;

import com.ict.finalproject.vo.PaymentVO;
import com.ict.finalproject.vo.PaymentdetailVO;

import java.util.List;

public interface PaymentService {

    //결제테이블에 값넣기
    public int createPayment(PaymentVO pvo);

    public int setPayment(PaymentdetailVO PDvo, int usercode, List<Integer> cart_codes);

}
