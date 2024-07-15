package kr.spring.challenge.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.category.vo.DonationCategoryVO;
import kr.spring.challenge.dao.ChallengeMapper;
import kr.spring.challenge.vo.ChallengeJoinVO;
import kr.spring.challenge.vo.ChallengePaymentVO;
import kr.spring.challenge.vo.ChallengeVO;
import kr.spring.challenge.vo.ChallengeVerifyVO;

@Service
@Transactional
public class ChallengeServiceImpl implements ChallengeService{
	
	@Autowired
	ChallengeMapper challengeMapper;

	//챌린지 개설//
	@Override
	public void insertChallenge(ChallengeVO chalVO,ChallengeJoinVO joinVO,ChallengePaymentVO payVO) {
		chalVO.setChal_num(challengeMapper.selectChal_num());
		challengeMapper.insertChallenge(chalVO);
		joinVO.setChal_joi_num(challengeMapper.selectChal_joi_num());
		challengeMapper.insertChallengeJoin(joinVO);
		payVO.setChal_joi_num(joinVO.getChal_joi_num());
		challengeMapper.insertChallengePayment(payVO);
	}	

	@Override
	public List<ChallengeVO> selectList(Map<String, Object> map) {
		return challengeMapper.selectList(map);
	}
	
	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return challengeMapper.selectRowCount(map);
	}

	@Override
	public ChallengeVO selectChallenge(Long chal_num) {
		return challengeMapper.selectChallenge(chal_num);
	}

	@Override
	public void updateChallenge(Long chal_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteChallenge(Long chal_num) {
		challengeMapper.deleteChallenge(chal_num);
	}

	@Override
	public void deleteChalPhoto(Long chal_num) {
		// TODO Auto-generated method stub
		
	}

	//챌린지 참가//
    @Override
    public void insertChallengeJoin(ChallengeJoinVO chalJoinVO) {
        challengeMapper.insertChallengeJoin(chalJoinVO);
    }

    @Override
    public List<ChallengeJoinVO> selectChallengeJoinList(Map<String,Object> map) {
        return challengeMapper.selectChallengeJoinList(map);
    }

	@Override public ChallengeJoinVO selectChallengeJoin(Long chal_joi_num) {
		return challengeMapper.selectChallengeJoin(chal_joi_num); 
	}
    
	@Override public void deleteChallengeJoin(Long chal_joi_num) {
		challengeMapper.deleteChallengeJoin(chal_joi_num); 
	}
	
    //기부 카테고리 목록 가져오기
    @Override
    public List<DonationCategoryVO> selectDonaCategories() {
        return challengeMapper.selectDonaCategories();
    }
    
    //챌린지 ID로 챌린지 참가 데이터 삭제
    @Override
    public void deleteChallengeJoinsByChallengeId(Long chal_num) {
        challengeMapper.deleteChallengeJoinsByChallengeId(chal_num);
    }
    
    //리더 여부 확인
    @Override
    public boolean isChallengeLeader(Long chal_num, Long mem_num) {
        ChallengeVO challenge = challengeMapper.selectChallenge(chal_num);
        return challenge != null && challenge.getMem_num() == mem_num;
    }
    
    //챌린지 결제//
    @Override
    public void insertChallengePayment(ChallengePaymentVO chalPayVO) {
        challengeMapper.insertChallengePayment(chalPayVO);
    }
    
    //챌린지 인증//
    @Override
    public void insertChallengeVerify(ChallengeVerifyVO chalVerifyVO) {
        challengeMapper.insertChallengeVerify(chalVerifyVO);
    }

    @Override
    public List<ChallengeVerifyVO> selectChallengeVerifyList(Map<String, Object> map) {
        return challengeMapper.selectChallengeVerifyList(map);
    }

	/*
	 * @Override public ChallengeVerifyVO selectChallengeVerify(Long chal_ver_num) {
	 * return challengeMapper.selectChallengeVerify(chal_ver_num); }
	 */
    
}
