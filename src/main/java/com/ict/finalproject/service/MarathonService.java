package com.ict.finalproject.service;

import com.ict.finalproject.vo.*;

import java.util.List;
import java.util.Map;

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
    // 좋아요 추가 메서드
    void addLike(LikeVO likeVO);
    // 좋아요 여부 확인 메서드
    boolean checkLike(int usercode, int marathonCode);
    void incrementLikeCount(int marathonCode); // 좋아요 수 증가 메서드
    void removeLike(int usercode, int marathonCode);
    void decrementLikeCount(int marathonCode);
    void incrementViewCount(int marathonCode);
    MarathonListVO getMarathonDetail(int marathonCode);
    void updateMarathon(MarathonListVO marathon);
    boolean deleteMarathon(int marathonCode);
    void saveMarathon(MarathonListVO marathonListVO);
}
