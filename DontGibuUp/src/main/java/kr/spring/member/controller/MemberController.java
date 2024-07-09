package kr.spring.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.config.validation.ValidationSequence;
import kr.spring.member.service.MemberOAuthService;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.KakaoInfo;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.vo.PointVO;
import kr.spring.util.AuthCheckException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberOAuthService memberOAuthService;


	//카카오 로그인 API 정보
	@Value("${kakao.client_id}")
	private String client_id;
	@Value("${kakao.redirect_uri}")
	private String redirect_uri;
	@Value("${kakao.client_secret}")
	private String client_secret;

	//자바빈 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	/*===================================
	 * 			회원가입
	 *==================================*/
	//회원가입 폼
	@GetMapping("/member/signup")
	public String signupForm() {
		return "memberSignup";
	}
	
	//일반 회원가입
	@PostMapping("/member/signup")
	public String signup(@Validated(ValidationSequence.class) MemberVO memberVO, BindingResult result, Model model, HttpServletRequest request) {
		log.debug("<<회원가입>> : " + memberVO);
		
		if (result.hasErrors()) {
			return signupForm();
		}
		//회원가입 타입 지정(1:일반 회원가입)
		memberVO.setMem_reg_type(1);
		
		//포인트 정보 지정
		PointVO pointVO = new PointVO();
		pointVO.setPevent_type(12); //포인트타입 12:회원가입
		pointVO.setPoint_amount(1000);
		
		log.debug("<<회원가입 - 포인트>> : " + pointVO);
		
		//회원가입
		memberService.insertMember(memberVO, pointVO);
		
		model.addAttribute("accessTitle", "회원가입 완료");
		model.addAttribute("accessMsg", "회원가입이 완료되었습니다");
		model.addAttribute("accessBtn", "로그인하기");
		model.addAttribute("accessUrl", request.getContextPath() + "/member/login");
		
		return "resultPage";
	}
	
	//카카오 로그인/회원가입 폼
	@GetMapping("/member/oauth/kakao")
	public String getKakaoLogin() {
		String url = String.format(
				"https://kauth.kakao.com/oauth/authorize?client_id=%s&response_type=code&redirect_uri=%s", client_id,
				redirect_uri);
		return "redirect:" + url;
	}

	//카카오 로그인/회원가입
	@GetMapping("/member/callback/kakao")
	public ResponseEntity<?> kakaoCallback(@RequestParam("code") String code, Model model, HttpSession session) {
	    try {
	        // Access Token 획득
	        String accessToken = memberOAuthService.getKakaoAccessToken(code);
	        KakaoInfo kakaoMember = memberOAuthService.getKakaoInfo(accessToken);

	        log.debug("<<카카오 로그인 정보>> : " + kakaoMember);

	        // 이메일을 통해 기존 회원 정보 조회
	        MemberVO existingMember = memberService.selectMemberByEmail(kakaoMember.getEmail());

	        String redirectUrl;
	        
	        if (existingMember != null) { // 기존 회원이 존재하는 경우
	            if (existingMember.getMem_status() == 1) { // 정지 회원인 경우
	                model.addAttribute("result", "suspendedMember");
	                redirectUrl = "redirect:/member/login";
	            } else { // 정상 회원인 경우
	                // TODO: 자동 로그인 체크 로직 추가

	                // 로그인 처리
	                session.setAttribute("user", existingMember);
	                session.setMaxInactiveInterval(60 * 30); //30분
	                session.setAttribute("kakaoToken", accessToken);

	                log.debug("<<인증 성공>>");
	                log.debug("<<email>> : {}", existingMember.getMem_email());
	                log.debug("<<status>> : {}", existingMember.getMem_status());
	                log.debug("<<reg_type>> : {}", existingMember.getMem_reg_type());
	                
	                if (existingMember.getMem_status() == 9) { // 관리자
	                    redirectUrl = "/main/admin";
	                } else { // 일반 회원
	                    redirectUrl = "/main/main";
	                }
	            }

	        } else { // 기존 회원이 없는 경우 회원가입 처리
	            MemberVO memberVO = new MemberVO();
	            memberVO.setMem_email(kakaoMember.getEmail());
	            memberVO.setMem_social_id(kakaoMember.getId());
	            memberVO.setMem_reg_type(3); // 회원가입 타입 지정
	            memberVO.setMem_nick(String.valueOf(kakaoMember.getId())); // 랜덤 닉네임 지정
	            memberVO.setMem_pw("N"); // 비밀번호 임의 지정
	            
	            memberVO.setMem_rcode(memberService.generateUniqueRCode());
	            memberVO.setRecommend_status(0); //TODO 추천인 이벤트 참여 일단 안했다고 해둠
	            
	    		//포인트 정보 지정
	    		PointVO pointVO = new PointVO();
	    		pointVO.setPevent_type(12); //포인트타입 12:회원가입
	    		pointVO.setPoint_amount(1000);

	            // 회원가입 처리
	            memberService.insertMember(memberVO, pointVO);

	            // 로그인 처리
	            session.setAttribute("user", existingMember);
	            session.setMaxInactiveInterval(60 * 30); //30분
	            session.setAttribute("kakaoToken", accessToken);
	            redirectUrl = "/main/main";
	        }

	        // 리다이렉트 URL을 반환
	        return ResponseEntity.status(HttpStatus.FOUND).header(HttpHeaders.LOCATION, redirectUrl).body(null);

	    } catch (Exception e) {
	        // 예외 처리 로직: 에러 페이지로 리다이렉트
	        return new ResponseEntity<>("Exception occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	
	/*===================================
	 * 			로그인
	 *==================================*/
	//로그인폼
	@GetMapping("/member/login")
	public String loginForm() {
		return "memberLogin";
	}
	
	//일반 로그인
	@PostMapping("/member/login")
	public String login(@Valid MemberVO memberVO, BindingResult result, HttpSession session) {
	    log.debug("<<회원 로그인>> : {}", memberVO);
	    
	    // 유효성 체크 결과 오류가 있으면 폼 호출
	    if (result.hasFieldErrors("mem_email") || result.hasFieldErrors("mem_pw")) {
	        return loginForm();
	    }
	    
	    try {
	        MemberVO member = memberService.selectMemberByEmail(memberVO.getMem_email());
	        
	     // =====TODO 로그인타입 체크 ====//
	        if (member != null) {
	            // 멤버 email이 존재할 시 status가 정지회원, 탈퇴회원인지 체크
	            if (member.getMem_status() == 1) { // 정지회원
	                result.reject("suspendedMember");
	            }
	            
	            // 비밀번호 일치여부 체크
	            if (member.isCheckedPassword(memberVO.getMem_pw())) {
	                // 인증 성공
	        		// =====TODO 자동로그인 체크 시작====//
	        		// =====TODO 자동로그인 체크 끝====//
	            	
	            	// 로그인 처리
	                session.setAttribute("user", member);
	                
	                log.debug("<<인증 성공>>");
	                log.debug("<<email>> : {}", member.getMem_email());
	                log.debug("<<status>> : {}", member.getMem_status());
	                log.debug("<<reg_type>> : {}", member.getMem_reg_type());
	                
	                if (member.getMem_status() == 9) { // 관리자
	                    return "redirect:/main/admin";
	                } else {
	                    return "redirect:/main/main";
	                }
	            }
	        }
	        
	        // 인증 실패 시 예외 던지기
	        throw new AuthCheckException();
	    } catch (AuthCheckException e) {
	        result.reject("invalidEmailOrPassword");
	        log.debug("<<인증 실패>>");
	        return loginForm();
	    }
	}
	
	//로그아웃
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		String accessToken = (String)session.getAttribute("kakaoToken");
		if (accessToken != null && !"".equals(accessToken)) { //소셜(카카오) 로그인 
            try {
            	// =====TODO 자동로그인 체크 시작====//
            	// =====TODO 자동로그인 체크 끝====//
                memberOAuthService.kakaoDisconnect(accessToken);
            } catch (Exception e) {
    	        // 예외 처리
    	        return "Exception occurred: " + e.getMessage();
            }
		}
		
		//로그아웃
		session.invalidate();
		
		return "redirect:/main/main";
	}
}
