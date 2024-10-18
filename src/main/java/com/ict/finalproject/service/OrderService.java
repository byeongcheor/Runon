package com.ict.finalproject.service;

import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MarathonFormVO;
import com.ict.finalproject.vo.OrderVO;
import com.ict.finalproject.vo.PointVO;

import java.util.List;

public interface OrderService {
    //오더폼에 불러오고 테이블에 넣기
    public List<CartVO>SetOrder(List<Integer>items);
    //포인트VO불러오기
    public PointVO getMyPoint(int usercode);

    //마라톤신청폼있는지 확인겸 vo받아오기
    public MarathonFormVO selectMyForm(int usercode);
}
