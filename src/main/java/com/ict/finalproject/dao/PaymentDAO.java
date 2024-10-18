package com.ict.finalproject.dao;

import com.ict.finalproject.vo.OrderVO;
import com.ict.finalproject.vo.PaymentVO;
import com.ict.finalproject.vo.PaymentdetailVO;

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
    public int updatepayment(int realAmount,int usercode,String method);
    public int updateOrder(int usercode);
    public List<Integer>selectCartCode(int usercode);

}
