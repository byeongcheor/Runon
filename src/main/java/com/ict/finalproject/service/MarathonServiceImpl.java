package com.ict.finalproject.service;

import com.ict.finalproject.dao.MarathonDAO;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MarathonListVO;
import com.ict.finalproject.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public void addToCart(CartVO cartVO) {
        dao.addToCart(cartVO);
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
    public List<MarathonListVO> filterMarathons(String year, String month, String addr, String search, PagingVO pvo, Integer  sort) {
        pvo.calculateOffset(); // offset 계산
        pvo.setSort1(sort); // sort 값을 PagingVO에 설정
        return dao.selectFilteredMarathons(pvo); // PagingVO를 매개변수로 넘김
    }
    @Override
    public int usercodeSelect(String user_name) {
        return dao.usercodeSelect(user_name);
    }

}
