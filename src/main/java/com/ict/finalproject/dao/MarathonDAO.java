package com.ict.finalproject.dao;

import com.ict.finalproject.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MarathonDAO {
    List<MarathonListVO> marathonSelectPaging(PagingVO pvo);
    int totalRecord(PagingVO pvo);
    MarathonListVO getMarathonByCode(int marathonCode);
    MarathonListVO getMarathonById(int marathonId);
    int addToCart(CartVO cartVO); // 장바구니에 추가하는 메서드
    List<CartVO> getCartByUserCode(int usercode); // 사용자별 장바구니 항목 조회
    // 조회수 증가 메서드
    void increaseHit(int marathonCode);
    int getFilteredTotalRecord(String year, String month, String addr, String search);
    List<MarathonListVO> selectFilteredMarathons(PagingVO pvo);
    int usercodeSelect(String user_name);
    public List<MarathonListVO> userselect(int user_code);
    // 좋아요 추가 메서드
    void addLike(LikeVO likeVO);
    // 좋아요 여부 확인 메서드
    boolean checkLike(Map<String, Object> params);
    void incrementLikeCount(int marathonCode); // 좋아요 수 증가 메서드
    void removeLike(int usercode, int marathonCode);
    void decrementLikeCount(int marathonCode);
    void incrementViewCount(int marathonCode);
    MarathonListVO getMarathonDetail(int marathonCode);
    void updateMarathon(MarathonListVO marathon);
}
