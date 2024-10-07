package com.ict.finalproject.service;

import com.ict.finalproject.vo.MemberVO;

public interface JoinService {
   public int joinProcess(MemberVO vo);
   // 사용자 이름으로 사용자 정보 찾기
   MemberVO findByUsername(String username);

   // 사용자 이름이 존재하는지 확인
   Boolean existsByUsername(String username);

   // 새로운 사용자 저장
   void saveUser(MemberVO user);

   // 아이디 중복검사
   int idDoubleCheck(String username);

   //닉네임 중복검사
   int nickCheck(String nickname);
   //포인트테이블 아이디추가
   int addPoint(String username);
   //유저코드찾기
   int selectUserCode(String username);
   //유저 테이블 포인트코드추가
   int addPointCode(int usercode);
}
