package com.ict.finalproject.service;

import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MarathonListVO;
import com.ict.finalproject.vo.MateVO;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface MarathonService {
    List<MarathonListVO> marathonSelectPaging(PagingVO pvo);
    int totalRecord(PagingVO pvo);
    MarathonListVO getMarathonByCode(int marathonCode);
    MarathonListVO getMarathonById(int marathonId);
    int addToCart(CartVO cartVO); // 장바구니에 추가하는 메서드
    List<CartVO> getCartByUserCode(int usercode); // 사용자별 장바구니 항목 조회
    // 조회수 증가 메서드
    void increaseHit(int marathonCode);
    int getFilteredTotalRecord(String year, String month, String addr, String search);
    List<MarathonListVO> filterMarathons(String year, String month, String addr, String search, PagingVO pvo, Integer sort1);
    public int usercodeSelect(String username);
    public List<MarathonListVO> userselect(int user_code);
}
