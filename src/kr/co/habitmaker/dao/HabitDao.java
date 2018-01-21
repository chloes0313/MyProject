package kr.co.habitmaker.dao;

import java.util.List;

import kr.co.habitmaker.vo.Habit;

public interface HabitDao {

	/**
	 * 습관등록
	 * @param habit
	 * @return
	 */
	int insertHabit(Habit habit);
	
	/**
	 * 습관 업데이트
	 * @param habit
	 * @return
	 */
	int updateHabit(Habit habit);
	
	/**
	 * 해당 번호(들) 습관 삭제 (동적쿼리)
	 * @param habitNo
	 * @return
	 */
	int deleteHabitByHabitNo(List<Integer> habitNo);
	
	/**
	 * 해당 사용자의 습관 삭제
	 * @param doerId
	 * @return
	 */
	int deleteHabitByDoer(String doerId);
	
	

	/**
	 * 수행완료된 습관들 삭제(완료유무판단)
	 * 
	 * @return
	 */
	int deleteHabtisDone();
	int deleteHabtisDoneByDoer(String doerId);
	
	/**
	 * 모든 습관 선택
	 * @return
	 */
	List<Habit> selectHabits();

	/**
	 * 특정 수행자의 습관 찾기
	 * @param doerId
	 * @return
	 */
	List<Habit> selectHabitsByDoer(String doerId);
	
	
	/**
	 * 습관 번호로 찾기
	 * @param habitNo
	 * @return
	 */
	Habit selectHabitByHabitNo(int habitNo);
	
	
	/**
	 * 특정 사용자의 수행중인 습관 리스트 찾기
	 * (파라미터 없으면 전체 사용자로)
	 * @return
	 */
	List<Habit> selectHabitsDoing();
	List<Habit> selectHabitsDoingByDoer(String doerId);
	
	/**
	 * 특정 사용자의 수행완료한 습관 리스트 찾기
	 * (파라미터 없으면 전체 사용자로)
	 * @param doerId
	 * @return
	 */
	List<Habit> selectHabitsDone();
	List<Habit> selectHabitsDoneByDoer(String doerId);
	
	
	/*************************PAGING*************************/
	
	/**
	 * 전체 습관 목록 페이징 
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	List<Habit> selectHabitsPaging(int startIdx, int endIdx);
	int selectCountHabits();
	
	/**
	 * 특정 사용자의 전체 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	List<Habit> selectHabitsByDoerPaging(String doerId, int startIdx, int endIdx);
	int selectCountHabitsByDoer(String doerId);
	
	/**
	 * 전체 진행중인 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	List<Habit> selectHabitsDoingPaging(int startIdx, int endIdx);
	int selectCountHabitsDoing();
	
	/**
	 * 특정 사용자의 진행중인 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	List<Habit> selectHabitsDoingByDoerPaging(String doerId, int startIdx, int endIdx);
	int selectCountHabitsDoingByDoer(String doerId);
	
	/**
	 * 전체 완료된 습관 목록 페이징
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	List<Habit> selectHabitsDonePaging(int startIdx, int endIdx);
	int selectCountHabitsDone();
	
	/**
	 * 특정 사용자의 완료된 습관 목록 페이징
	 * @param doerId
	 * @param startIdx
	 * @param endIdx
	 * @return
	 */
	List<Habit> selectHabitsDoneByDoerPaging(String doerId, int startIdx, int endIdx);
	int selectCountHabitsDoneByDoer(String doerId);
	
	int selectCountHabitsSuccessByDoer(String doerId);
	int selectCountHabitsFailureByDoer(String doerId);
}
