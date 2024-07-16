package kr.spring.subscription.service;

import kr.spring.subscription.vo.SubscriptionVO;

public interface SubscriptionService {
	//정기기부 번호 생성	
	public long getSub_num();
	//정기기부 등록
	public void insertSubscription(SubscriptionVO subscriptionVO);
	//정기기부 종료
	public void endSubscription(long sub_num);
	
	public SubscriptionVO getSubscription(long sub_num);
	//정기기부 삭제
	public void deleteSubscription(long sub_num);
		
}
