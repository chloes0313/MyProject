package kr.co.habitmaker.dao.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.habitmaker.dao.HabitCheckDao;
import kr.co.habitmaker.vo.HabitCheck;

@Repository
public class HabitCheckDaoImpl implements HabitCheckDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "habitCheckMapper."+tagId;
	}
	@Override
	public int insertHabitCheck(HabitCheck habitCheck)  {
		// TODO Auto-generated method stub
		return session.insert(makeSql("insertHabitCheck"), habitCheck);
	}

	@Override
	public int updateHabitCheck(HabitCheck habitCheck) {
		// TODO Auto-generated method stub
		return session.update(makeSql("updateHabitCheck"), habitCheck);
	}
	
	
	
	
	@Override
	public int deleteHabitCheckAfterDate(int habitNo, Date habitDate) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("habitNo", habitNo);
		map.put("habitDate", habitDate);
		return session.delete(makeSql("deleteHabitCheckAfterDate"), map);
	}
		
	@Override
	public HabitCheck selectHabitCheck(int habitNo, int day) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("habitNo", habitNo);
		map.put("day", day);
		return session.selectOne(makeSql("selectHabitCheck"), map);
	}
	
	
	
	@Override
	public HabitCheck selectHabitCheckTodayByHabitNo(int habitNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("habitNo", habitNo);
		System.out.println("habitNo:"+habitNo);
		// TODO Auto-generated method stub
				HabitCheck temp = session.selectOne(makeSql("selectHabitCheckTodayByHabitNo"), map);
		System.out.println("temp:"+temp);
		return temp;
	}
	@Override
	public List<HabitCheck> selectHabitCheckDoingToday(Date habitDate) {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectHabitCheckDoingToday"), habitDate);
		
	}

	
}
