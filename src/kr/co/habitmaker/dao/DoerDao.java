package kr.co.habitmaker.dao;

import java.util.List;

import kr.co.habitmaker.vo.Authority;
import kr.co.habitmaker.vo.Doer;

public interface DoerDao {

	/**
	 * 사용자 등록
	 * @param doer
	 * @return
	 */
	int insertDoer(Doer doer);
	
	/**
	 * 사용자의 권한 등록
	 * @param authority
	 * @return
	 */
	int insertAuthority(Authority authority);
	
	/**
	 * 사용자 업데이트
	 * @param doer
	 * @return
	 */
	int updateDoer(Doer doer);
	
	/**
	 * 사용자 삭제
	 * @param id
	 * @return
	 */
	int deleteDoer(String id);
	
	/**
	 * 모든 사용자 찾기
	 * @return
	 */
	List<Doer> selectAllDoers();
	
	/**
	 * 사용자 id로 찾기
	 * @param id
	 * @return
	 */
	Doer selectDoerById(String id);
	
	/**
	 * 사용자 이름으로 찾기
	 * @param id
	 * @return
	 */
	Doer selectDoerByName(String name);
	
	
	/**
	 * userId의 사용자의 권한들 조회
	 * @param userId
	 * @return
	 */
	List<Authority> selectAuthoritiesById(String userId);
	
	
	/*************************PAGING*************************/
	
	/**
	 * 전체 회원수
	 * @return
	 */
	int selectCountDoer();
	
	/**
	 * 전체 회원중 한페이지씩 가져오기
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	List<Doer> selectAllDoersPaging(int startIdx, int endIdx);
}
