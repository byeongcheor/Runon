package com.ict.finalproject.service;

import com.ict.finalproject.vo.MemberVO;

public interface JoinService {
   public void joinProcess(MemberVO vo);
   // 사용자 이름으로 사용자 정보 찾기
   MemberVO findByUsername(String username);

   // 사용자 이름이 존재하는지 확인
   Boolean existsByUsername(String username);

   // 새로운 사용자 저장
   void saveUser(MemberVO user);
}
