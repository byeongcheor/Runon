package com.ict.finalproject.service;

import com.ict.finalproject.dao.MarathonDAO;
import com.ict.finalproject.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class MarathonServiceImpl implements MarathonService {

    @Autowired
    private MarathonDAO dao;

    @Override
    public List<MarathonListVO> marathonSelectPaging(PagingVO pvo) {
        return dao.marathonSelectPaging(pvo);
    }

    @Override
    public int totalRecord(PagingVO pvo) {
        return dao.totalRecord(pvo);
    }

    @Override
    public MarathonListVO getMarathonByCode(int marathonCode) {
        return dao.getMarathonByCode(marathonCode);
    }

    @Override
    public MarathonListVO getMarathonById(int marathonId) {
        return dao.getMarathonById(marathonId);
    }

    @Override
    public int addToCart(CartVO cartVO) {
        return dao.addToCart(cartVO);
    }

    @Override
    public List<CartVO> getCartByUserCode(int usercode) {
        return dao.getCartByUserCode(usercode);
    }

    @Override
    public void increaseHit(int marathonCode) {
        dao.increaseHit(marathonCode);
    }

    @Override
    public int getFilteredTotalRecord(String year, String month, String addr, String search) {
        return dao.getFilteredTotalRecord(year, month, addr, search);
    }

    @Override
    public List<MarathonListVO> filterMarathons(String year, String month, String addr, String search, PagingVO pvo, Integer  sort1) {
        pvo.calculateOffset(); // offset 계산
        pvo.setSort1(sort1); // sort 값을 PagingVO에 설정
        return dao.selectFilteredMarathons(pvo); // PagingVO를 매개변수로 넘김
    }
    @Override
    public int usercodeSelect(String user_name) {
        return dao.usercodeSelect(user_name);
    }

    @Override
    public List<MarathonListVO> userselect(int user_code) {
        return dao.userselect(user_code);
    }

    @Override
    public void addLike(LikeVO likeVO) {
        dao.addLike(likeVO);
    }

    @Override
    public boolean checkLike(int usercode, int marathonCode) {
        Map<String, Object> params = new HashMap<>();
        params.put("usercode", usercode);
        params.put("marathonCode", marathonCode);
        return dao.checkLike(params); // DAO 호출
    }
    @Override
    public void incrementLikeCount(int marathonCode) {
        dao.incrementLikeCount(marathonCode);
    }

    @Override
    public void removeLike(int  usercode, int marathonCode) {
        dao.removeLike(usercode, marathonCode);
    }

    @Override
    public void decrementLikeCount(int marathonCode) {
        dao.decrementLikeCount(marathonCode);
    }

    @Override
    public void incrementViewCount(int marathonCode) {
        dao.incrementViewCount(marathonCode);
    }

}
