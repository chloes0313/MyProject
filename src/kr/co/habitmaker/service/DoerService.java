package kr.co.habitmaker.service;

import java.util.List;
import java.util.Map;

import kr.co.habitmaker.vo.Doer;

/**
 * 사용자 관련 서비스
 * @author Chloe
 *
 */
public interface DoerService {

	/**
	 * 사용자 등록
	 * @param doer
	 * @return
	 * @throws Exception 
	 */
	int insertDoer(Doer doer, String authority) throws Exception;
	
	/**
	 * 사용자 업데이트
	 * @param doer
	 * @return
	 * @throws Exception 
	 */
	int updateDoer(Doer doer) throws Exception;
	
	/**
	 * 사용자 삭제
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	int deleteDoer(String id) throws Exception;
	
	/**
	 * 모든 사용자 찾기
	 * @return
	 * @throws Exception 
	 */
	List<Doer> selectAllDoers() throws Exception;
	
	/**
	 * 사용자 id로 찾기
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	Doer selectDoerById(String id) throws Exception;
	
	/**
	 * 사용자 이름으로 찾기
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	Doer selectDoerByName(String name) throws Exception;
	
	
	
	
	/**
	 * 전체 회원중 한페이지씩 가져오기
	 * @param startIdx
	 * @param endIdx
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> selectAllDoersPaging(int page) throws Exception;

}
