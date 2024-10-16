package com.ict.finalproject.dao;

import com.ict.finalproject.vo.MessageVO;
import com.ict.finalproject.vo.ReportVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


@Mapper
public interface ChatDAO {
        // 메시지 저장 메서드
        void insertMessage(MessageVO vo);

        // 매칭 방 코드에 따른 메시지 조회
        List<MessageVO> selectMessagesByRoomCode(int matchYn);

        // 신고 데이터를 삽입하는 메서드
        void insertReport(ReportVO reportVO);

        // 유저코드 존재 확인
        int getUserCountByCode(int userCode);
}
