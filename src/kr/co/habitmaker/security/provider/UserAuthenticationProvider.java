/**
 (AuthenticationProvider)UserAuthenticationProvider
	사용자 인증 (로그인) 처리를 위한 Provider
*/
package kr.co.habitmaker.security.provider;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import kr.co.habitmaker.dao.DoerDao;
import kr.co.habitmaker.vo.Authority;
import kr.co.habitmaker.vo.Doer;
/*
 * Spring Security 컨테이너가 사용자 인증 처리(로그인 처리) 할때 호출할 클래스
 * 			=> AuthenticationProvider
 * 구현 : AuthenticationProvider 를 implements. 메소드 오버라이딩(authenticate())
 */
@Component
public class UserAuthenticationProvider implements AuthenticationProvider{

	/*@Autowired
	private AuthorityDao authorityDao;
	@Autowired
	private AdminDao adminDao;
	*/
	@Autowired
	private DoerDao doerDao;
	@Autowired
	private PasswordEncoder encoder;
	//문자열을 암호화 - encode()
		//문자열과 암호화된 문자열을 비고 - matches(비교대상문자열, 암호화된문자열) : boolean
		
		/*Authentication : 인증/권한 정보를 가지는 객체 
				- 매개변수는 로그인 처리시 사용할 ID와 패스워드를 제공
				- 리턴 타입은 로그인처리 끝나고 로그인한 사용자의 정보를 담아 리턴할때 사용
			- 인증 실패 : Exception을 던지거나 return null 인 경우 스프링 시큐리티 컨테이너는 
																												인증실패로처리
		  GrantedAuthority - 권한정보 하나를 저장하는 객체.
		*/
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		//ID CHK
		String id =authentication.getName();//사용자가 입력한 ID
		Doer user= doerDao.selectDoerById(id);
		if(user==null){	//없는 id => 로그인실패
			throw new UsernameNotFoundException("id");
		}
		
		//PW CHK
		String password=(String)authentication.getCredentials();//사용자가 입력한 PW
		System.out.println("authentication.getCredentials():"+password);
		System.out.println("user.getPassword():"+user.getPassword());
		System.out.println("!encoder.matches(password, user.getPassword()) ? "+!encoder.matches(password, user.getPassword()));
		
		if(!encoder.matches(password, user.getPassword())){//틀린 패스워드 라면
			throw new BadCredentialsException("pw");
		}
		
		
		//여기까지 인증 성공 후
		
		//Authorities CHK
		// 1)해당 회원이 가진 권한리스트 받아오기
		List<Authority> list =  doerDao.selectAuthoritiesById(id);
		if(list.size() ==  0){
			//모든 인증된 사용자는 권한이 있어야 하는 경우는 권한 개수 체크후 권한이 없으면 
			//  예외 발생시킨다. (권한이 없는 사용자도 있을 경우 생략한다.)
			throw new UsernameNotFoundException("권한이 없는 사용자 입니다.");
		}
		//SimpleGrantedAuthority - 권한정보를 문자열로 저장.
		List<SimpleGrantedAuthority> authList = new ArrayList<>();
		for(Authority au : list){
			authList.add(new SimpleGrantedAuthority(au.getAuthority()));
		}
		
		//권한체크까지 완료
		//인증한 사용자 정보(Principal), 패스워드, 인증된사용자의 권한들 을 넣어 Authentication객체 생성해 리턴
		return new UsernamePasswordAuthenticationToken(user, null, authList);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.isAssignableFrom(UsernamePasswordAuthenticationToken.class);
	}
}
