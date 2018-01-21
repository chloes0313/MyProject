package kr.co.habitmaker.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.habitmaker.dao.HabitDao;
import kr.co.habitmaker.vo.Habit;

@Repository
public class HabitDaoImpl implements HabitDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "habitMapper."+tagId;
	}

	@Override
	public int insertHabit(Habit habit) {
		// TODO Auto-generated method stub
		return session.insert(makeSql("insertHabit"), habit);
	}

	@Override
	public int updateHabit(Habit habit) {
		// TODO Auto-generated method stub
		return session.update(makeSql("updateHabit"), habit);
	}

	@Override
	public int deleteHabitByHabitNo(List<Integer> habitNo) {
		// TODO Auto-generated method stub
		return session.delete(makeSql("deleteHabitByHabitNo"), habitNo);
	}

	@Override
	public int deleteHabitByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.delete(makeSql("deleteHabitByDoer"), doerId);
	}

	@Override
	public int deleteHabtisDone() {
		// TODO Auto-generated method stub
		return session.delete(makeSql("deleteHabtisDone"));
	}

	@Override
	public int deleteHabtisDoneByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.delete(makeSql("deleteHabtisDoneByDoer"), doerId);
	}

	
	///////INSERT//////////////////////////////////////////////////////
	@Override
	public List<Habit> selectHabits() {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectHabits"));
	}

	@Override
	public List<Habit> selectHabitsByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectHabitsByDoer"), doerId);
	}

	@Override
	public Habit selectHabitByHabitNo(int habitNo) {
		// TODO Auto-generated method stub
		Habit habit = (Habit)session.selectOne(makeSql("selectHabitByHabitNo"), habitNo);
		System.out.println(habit.toString());
		return session.selectOne(makeSql("selectHabitByHabitNo"), habitNo);
	}

	@Override
	public List<Habit> selectHabitsDoing() {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectHabitsDoing"));
	}

	@Override
	public List<Habit> selectHabitsDoingByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectHabitsDoingByDoer"), doerId);
	}

	@Override
	public List<Habit> selectHabitsDone() {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectHabitsDone"));
	}

	@Override
	public List<Habit> selectHabitsDoneByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectHavitsDoneByDoer"), doerId);
	}

	
	/*************************PAGING*************************/
	//selectHabitsPaging
	@Override
	public List<Habit> selectHabitsPaging(int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectHabitsPaging"), input);
	}
	@Override
	public int selectCountHabits() {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountHabits"));
	}

	//selectHabitsByDoerPaging
	@Override
	public List<Habit> selectHabitsByDoerPaging(String doerId, int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("doerId", doerId);
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectHabitsByDoerPaging"), input);
	}
	@Override
	public int selectCountHabitsByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountHabitsByDoer"), doerId);
	}

	//selectHabitsDoingPaging
	@Override
	public List<Habit> selectHabitsDoingPaging(int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectHabitsDoingPaging"), input);
	}
	@Override
	public int selectCountHabitsDoing() {
		// TODO Auto-generated method stub
		
		return session.selectOne(makeSql("selectCountHabitsDoing"));
	}

	//selectHabitsDoingByDoerPaging
	@Override
	public List<Habit> selectHabitsDoingByDoerPaging(String doerId, int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("doerId", doerId);
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectHabitsDoingByDoerPaging"), input);
	}
	@Override
	public int selectCountHabitsDoingByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountHabitsDoingByDoer"),doerId);
	}

	//selectHabitsDonePaging
	@Override
	public List<Habit> selectHabitsDonePaging(int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectHabitsDonePaging"), input);
	}
	@Override
	public int selectCountHabitsDone() {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountHabitsDone"));
	}

	//selectHabitsDoneByDoerPaging
	@Override
	public List<Habit> selectHabitsDoneByDoerPaging(String doerId, int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("doerId", doerId);
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectHabitsDoneByDoerPaging"), input);
	}
	@Override
	public int selectCountHabitsDoneByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountHabitsDoneByDoer"),doerId);
	}

	@Override
	public int selectCountHabitsSuccessByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountHabitsSuccessByDoer"),doerId);
	}

	@Override
	public int selectCountHabitsFailureByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountHabitsFailureByDoer"),doerId);
	}
	
	
	
}
