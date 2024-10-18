package com.ict.finalproject.dao;

import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MarathonListVO;
import com.ict.finalproject.vo.PagingVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MarathonDAO {
    List<MarathonListVO> marathonSelectPaging(PagingVO pvo);
    int totalRecord(PagingVO pvo);
    MarathonListVO getMarathonByCode(int marathonCode);
    MarathonListVO getMarathonById(int marathonId);
    void addToCart(CartVO cartVO); // 장바구니에 추가하는 메서드
    List<CartVO> getCartByUserCode(int usercode); // 사용자별 장바구니 항목 조회
    // 조회수 증가 메서드
    void increaseHit(int marathonCode);
    int getFilteredTotalRecord(String year, String month, String addr, String search);

    List<MarathonListVO> selectFilteredMarathons(PagingVO pvo);
    public int usercodeSelect(String user_name);
}
