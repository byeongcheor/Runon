package com.ict.finalproject.dao;

import com.ict.finalproject.vo.MessageVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


@Mapper
public interface ChatDAO {
        // 메시지 저장 메서드
        void insertMessage(MessageVO vo);

        // 매칭 방 코드에 따른 메시지 조회
        List<MessageVO> selectMessagesByRoomCode(int matchYn);

}
