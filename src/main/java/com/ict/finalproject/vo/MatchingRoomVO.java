package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class MatchingRoomVO {
    private int matching_roomCode;
    private int now_personnel;       // 현재 방에 있는 인원의 수
    private int max_personnel;       // 방에 들어갈 수 있는 최대 인원의 수
    private String room_status;      // 방의 상태
    private String entry_time;       // 방에 들어간 시간
    private int marathon_no;         // 특정 마라톤 번호
    private String marathon_count;   // 참가한 마라톤 횟수
}
