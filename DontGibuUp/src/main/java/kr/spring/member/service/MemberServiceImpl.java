package kr.spring.member.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.dao.PointMapper;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.util.RCodeGenerator;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberMapper memberMapper;
	@Autowired
	PointMapper pointMapper;
	@Autowired
	PointService pointService;

	//회원가입
	@Override
	public void insertMember(MemberVO memberVO) {
		//mem_num 지정
		long mem_num = memberMapper.selectMemNum();
		memberVO.setMem_num(mem_num);
		//추천인 코드지정
		memberVO.setMem_rcode(generateUniqueRCode());
		
		//member 추가
		memberMapper.insertMember(memberVO);
		//member_detail 추가(default point = 1000)
		memberMapper.insertMemberDetail(memberVO);
		
		//회원가입 포인트 로그
		PointVO point_signup = new PointVO(12, 1000); //포인트타입 12:회원가입
		log.debug("<<회원가입 - 포인트>> : " + point_signup);
		point_signup.setMem_num(mem_num);
		
		//회원가입 포인트 로그 추가
		pointMapper.insertPointLog(point_signup);
		
		//추천인 이벤트 참여
		if (memberVO.getRecommend_status() == 1) {
			long recipientMemNum = memberMapper.selectMemNumByRCode(memberVO.getFriend_rcode());
			
			PointVO point_revent1 = new PointVO(10, 3000, mem_num);
			PointVO point_revent2 = new PointVO(10, 3000, recipientMemNum);
			
			//포인트 로그 추가
			pointMapper.insertPointLog(point_revent1);
			pointMapper.insertPointLog(point_revent2);
			
			//member_detail 업데이트
			memberMapper.updateMemPoint(point_revent1);
			memberMapper.updateMemPoint(point_revent2);
		}
		
	}

	//이메일로 회원 찾기(기존회원 체크)
	@Override
	public MemberVO selectMemberByEmail(String mem_email) {
		return memberMapper.selectMemberByEmail(mem_email);
	}
	
	//추천인코드 만들기
	@Override
    public String generateUniqueRCode() {
        String rcode;
        boolean isUnique;
        do {
            rcode = RCodeGenerator.generateRCode();
            isUnique = checkIfRCodeIsUnique(rcode);
        } while (!isUnique);
        return rcode;
    }
    
	//추천인코드 중복확인
	@Override
	public boolean checkIfRCodeIsUnique(String rcode) {
		//mapper에서 중복 체크
		if (memberMapper.checkRCodeExists(rcode) == 0) {
			//중복아님 = unique
			return true;
		} else {
			//중복 = not unique
			return false;
		}
	}

	@Override
	public void updateMemPhoto(MemberVO memberVO) {
		memberMapper.updateMemPhoto(memberVO);
	}

	@Override
	public void updateMember(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}
	
	
}
