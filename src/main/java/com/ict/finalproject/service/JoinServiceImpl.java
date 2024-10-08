package com.ict.finalproject.service;

import com.ict.finalproject.dao.MemberDAO;
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
    public int joinProcess(MemberVO vo) {
        // 사용자 이름이 존재하는지 확인

        if (memberDAO.existsByUsername(vo.getUsername())) {
            System.out.println("User already exists!");
            return  0;  // 이미 사용자가 있으면 저장하지 않음
        }
        // 비밀번호 암호화
        String encodedPassword = bCryptPasswordEncoder.encode(vo.getPassword());
        vo.setPassword(encodedPassword);  // 암호화된 비밀번호 저장

        vo.setRole("ROLE_USER");

        // DAO를 통해 데이터베이스에 저장
       return memberDAO.saveUser(vo);
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

    @Override
    public int idDoubleCheck(String username) {
        return memberDAO.idDoubleCheck(username);
    }

    @Override
    public int nickCheck(String nickname) {

        return memberDAO.nickCheck(nickname);
    }

    @Override
    public int addPoint(String username) {
        return memberDAO.addPoint(username);
    }

    @Override
    public MemberVO getUsers(String username) {
        return memberDAO.getUsers(username);
    }
}
