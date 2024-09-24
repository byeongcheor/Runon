package com.ict.finalproject.service;

import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.dto.JoinDTO;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class JoinServiceImpl implements JoinService {

    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final MemberDAO memberDAO;  // 변수명 통일

    public JoinServiceImpl(MemberDAO memberDAO, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.memberDAO = memberDAO;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public void joinProcess(JoinDTO joinDTO) {
        // 사용자 이름이 존재하는지 확인
        if (memberDAO.existsByUsername(joinDTO.getUsername())) {
            System.out.println("User already exists!");
            return;  // 이미 사용자가 있으면 저장하지 않음
        }

        MemberVO memberVO = new MemberVO();
        memberVO.setUsername(joinDTO.getUsername());

        // 비밀번호 암호화
        String encodedPassword = bCryptPasswordEncoder.encode(joinDTO.getPassword());
        memberVO.setPassword(encodedPassword);  // 암호화된 비밀번호 저장

        memberVO.setRole("ROLE_USER");

        // DAO를 통해 데이터베이스에 저장
        memberDAO.saveUser(memberVO);
    }

    @Override
    public MemberVO findByUsername(String username) {
        return memberDAO.findByUsername(username);
    }

    @Override
    public Boolean existsByUsername(String username) {
        return memberDAO.existsByUsername(username);
    }

    @Override
    public void saveUser(MemberVO user) {
        memberDAO.saveUser(user);
    }
}
