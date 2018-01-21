package kr.co.habitmaker.service;

import java.util.List;
import java.util.Map;

import kr.co.habitmaker.vo.Doer;
import kr.co.habitmaker.vo.Habit;
import kr.co.habitmaker.vo.HabitCheck;

/**
 * 습관 관련 서비스
 * @author Chloe
 *
 */
public interface HabitService {
	
	/**
	 * 습관등록
	 * @param habit
	 * @return
	 * @throws Exception 
	 */
	void insertHabit(Habit habit) throws Exception;
	
	/**
	 * 습관 업데이트
	 * @param habit
	 * @return
	 * @throws Exception 
	 */
	void updateHabit(Habit habit) throws Exception;
	
	void updateHabitCheck(HabitCheck habitCheck) throws Exception;
	
	/**
	 * 해당 번호(들) 습관 삭제 (동적쿼리)
	 * @param habitNo
	 * @return
	 * @throws Exception 
	 */
	void deleteHabitByHabitNo(List<Integer> habitNo) throws Exception;
	
	/**
	 * 해당 사용자의 습관 삭제
	 * @param doerId
	 * @return
	 * @throws Exception 
	 */
	void deleteHabitByDoer(String doerId) throws Exception;
	
	

	/**
	 * 수행완료된 습관들 삭제(완료유무판단)
	 * 
	 * @return
	 */
	void deleteHabtisDone();
	void deleteHabtisDoneByDoer(String doerId) throws Exception;
	
	/**
	 * 모든 습관 선택
	 * @return
	 * @throws Exception 
	 */
	List<Habit> selectHabits() throws Exception;

	/**
	 * 특정 수행자의 습관 찾기
	 * @param doerId
	 * @return
	 * @throws Exception 
	 */
	List<Habit> selectHabitsByDoer(String doerId) throws Exception;
	
	
	/**
	 * 습관 번호로 찾기 in detail
	 * @param habitNo
	 * @return
	 * @throws Exception 
	 */
	Habit selectHabitByHabitNo(int habitNo) throws Exception;
	
	
	/**
	 * 특정 사용자의 수행중인 습관 리스트 찾기
	 * (파라미터 없으면 전체 사용자로)
	 * @return
	 * @throws Exception 
	 */
	List<Habit> selectHabitsDoing() throws Exception;
	List<Habit> selectHabitsDoingByDoer(String doerId) throws Exception;
	
	/**
	 * 특정 사용자의 수행완료한 습관 리스트 찾기
	 * (파라미터 없으면 전체 사용자로)
	 * @param doerId
	 * @return
	 * @throws Exception 
	 */
	List<Habit> selectHabitsDone() throws Exception;
	List<Habit> selectHabitsDoneByDoer(String doerId) throws Exception;
	
	
	Map<String, Object> selectHabitCount(String doerId) throws Exception;
	
	
	/*************************PAGING*************************/
	
	/**
	 * 전체 습관 목록 페이징 
	 * @param startIdx
	 * @param endIdx
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> selectHabitsPaging(int page) throws Exception;

	
	/**
	 * 특정 사용자의 전체 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> selectHabitsByDoerPaging(String doerId, int page) throws Exception;
	
	/**
	 * 전체 진행중인 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> selectHabitsDoingPaging(int page) throws Exception;
	
	/**
	 * 특정 사용자의 진행중인 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> selectHabitsDoingByDoerPaging(String doerId, int page) throws Exception;
	
	/**
	 * 전체 완료된 습관 목록 페이징
	 * @param startIdx
	 * @param endIdx
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> selectHabitsDonePaging(int page) throws Exception;
	
	/**
	 * 특정 사용자의 완료된 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> selectHabitsDoneByDoerPaging(String doerId, int page) throws Exception;

	HabitCheck selectHabitCheckTodayByHabitNo(int habitNo);

	
}
