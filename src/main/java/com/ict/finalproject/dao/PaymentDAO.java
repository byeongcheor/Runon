package com.ict.finalproject.dao;

import com.ict.finalproject.vo.*;

import java.util.List;

public interface PaymentDAO {

    //값이 있는지 확인
    public int selectPayment(PaymentVO pvo);
    //결제테이블에 값넣기
    public int createPayment(PaymentVO pvo);
    public int updatePayment(PaymentVO pvo);

    public List<OrderVO> selectOrdercode(List<Integer> cart_codes, int usercode);
    public int selectPaymentCode(int usercode);
    public List<PaymentdetailVO> selectDetails(List<PaymentdetailVO> paymentDetails);
    public int updateToDeleted (List<PaymentdetailVO> toDeleteDetails);
    public int insertPaymentDetails(List<PaymentdetailVO> newDetails);

    public int updateDetails(String orderId,int usercode);
    public int updatepayments(int realAmount,int usercode,String method,String paymentKey);
    public int updateOrder(int usercode);
    public List<Integer>selectCartCode(int usercode);
    public int deletedCart_code(List<Integer> cart_codes);
    public List<CompleteVO> selectCvoList(String orderId);
    public void updateMypoint(PaymentVO pvo);
    public PaymentVO selectdiscount(String orderId ,int usercode);
    public void updateChangePoint(PaymentVO pvo);
    public List<CompleteVO> getPDVO(List<Integer>codes);


    //환불시 실행할 class
    public int insertRefund(RefundVO rvo);
    public int updatepayDetail(RefundVO rvo);
    public int updatePay(RefundVO rvo);
    public List<Integer>selectorderCodes(RefundVO rvo);
    public int updateOrderstatus(List<Integer>order_codes);
    public int updatePoint(int point);
    public int insertPoint(RefundVO rvo);



}
