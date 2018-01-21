package kr.co.habitmaker.dao;

import java.util.Date;
import java.util.List;

import kr.co.habitmaker.vo.HabitCheck;

public interface HabitCheckDao {

	/**
	 * 
	 * @param habitCheck
	 * @return
	 */
	int insertHabitCheck(HabitCheck habitCheck);
	
	
	/**
	 * 
	 * @param habitCheck
	 * @return
	 */
	int updateHabitCheck(HabitCheck habitCheck);
	
	/**
	 * 특정 날짜 이후 습관체크 삭제
	 * @param habitDate
	 * @return
	 */
	int deleteHabitCheckAfterDate(int habitNo, Date habitDate);
	
	/**
	 * 습관 번호와 날짜로 습관체크 찾기
	 * @param habitNo
	 * @param day
	 * @return
	 */
	HabitCheck selectHabitCheck(int habitNo, int day);
	
	HabitCheck selectHabitCheckTodayByHabitNo(int habitNo);
	/**
	 * 
	 * @param habitDate
	 * @return
	 */
	List<HabitCheck> selectHabitCheckDoingToday(Date habitDate);
	
	
	
}
