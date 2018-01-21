package kr.co.habitmaker.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import kr.co.habitmaker.dao.DoerDao;
import kr.co.habitmaker.dao.HabitCheckDao;
import kr.co.habitmaker.dao.HabitDao;
import kr.co.habitmaker.service.HabitService;
import kr.co.habitmaker.util.PagingBean;
import kr.co.habitmaker.vo.Habit;
import kr.co.habitmaker.vo.HabitCheck;

@Service(value="habitService")
public class HabitServiceImpl implements HabitService{
	
	@Autowired
	private HabitDao habitDao;
	
	@Autowired
	private HabitCheckDao habitCheckDao;
	
	@Autowired
	private DoerDao doerDao;

	@Override
	public void insertHabit(Habit habit) throws Exception{
		for(Habit temp : habitDao.selectHabitsDoingByDoer(habit.getDoerId())){
			if(temp.getHabitTitle().equals(habit.getHabitTitle())){
				throw new Exception("동일한 목표의 진행중인 습관이 있습니다.");
			}
		}
		habitDao.insertHabit(habit);
		
		HabitCheck habitCheck = new HabitCheck();
		habitCheck.setHabitNo(habit.getHabitNo());
		Calendar cal = Calendar.getInstance();
		/*SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(sdf.parse(sdf.format(habit.getHabitStart())));*/
		cal.setTime(habit.getHabitStart());
		
		for(int i=1; i<=66 ; i++){
			habitCheck.setDay(i);
			habitCheck.setHabitDate(cal.getTime());
			habitCheck.setHabitState("yet");
			habitCheckDao.insertHabitCheck(habitCheck);
			
			cal.add(Calendar.DATE, 1);
		}
		
	}

	@Override
	public void updateHabit(Habit habit) throws Exception {
		for(Habit temp : habitDao.selectHabitsDoingByDoer(habit.getDoerId())){
			if(temp.getHabitTitle().equals(habit.getHabitTitle())){
				throw new Exception("동일한 목표의 진행중인 습관이 있습니다.");
			}
		}
		//날짜가 수정될때
		// 1)원래 시작날짜보다 더 나중으로 바꿀 때 : 미뤄진 기간 내 결과가 있다면 리셋
		//habitDao.selectHabitByHabitNo(habit.getHabitNo()).getHabitStart()
		habitDao.updateHabit(habit);
	}
	
	
	@Override
	public void updateHabitCheck(HabitCheck habitCheck) throws Exception {
		if(habitCheck.getHabitState().equalsIgnoreCase("yet")){
			habitCheck.setHabitState("do");
		}else if(habitCheck.getHabitState().equalsIgnoreCase("do")){
			habitCheck.setHabitState("yet");
		}
		
		habitCheckDao.updateHabitCheck(habitCheck);
	}
	
	
	
	

	@Override
	public void deleteHabitByHabitNo(List<Integer> habitNo) throws Exception {
		for(int temp : habitNo){
			if(habitDao.selectHabitByHabitNo(temp) == null){
				throw new Exception("존재하지 않은 습관입니다!");
			}
		}
		
		habitDao.deleteHabitByHabitNo(habitNo);
	}

	@Override
	public void deleteHabitByDoer(String doerId) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}

		habitDao.deleteHabitByDoer(doerId);
	}

	@Override
	public void deleteHabtisDone() {
		// TODO Auto-generated method stub
		habitDao.deleteHabtisDone();
	}

	@Override
	public void deleteHabtisDoneByDoer(String doerId) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}
		habitDao.deleteHabtisDoneByDoer(doerId);
	}

	@Override
	public List<Habit> selectHabits() throws Exception {
		if(habitDao.selectHabits() == null) {
			throw new Exception("습관이 존재하지 않습니다!");
		}
		return habitDao.selectHabits();
	}

	@Override
	public List<Habit> selectHabitsByDoer(String doerId) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}
		if(habitDao.selectHabitsByDoer(doerId) == null) {
			throw new Exception(doerId+"님의 습관이 존재하지 않습니다!");
		}
		return habitDao.selectHabitsByDoer(doerId);
	}

	@Override
	public Habit selectHabitByHabitNo(int habitNo) throws Exception {
		if(habitDao.selectHabitByHabitNo(habitNo) == null){
			throw new Exception("존재하지 않는 습관입니다.");
		}
		return habitDao.selectHabitByHabitNo(habitNo);
	}

	@Override
	public List<Habit> selectHabitsDoing() throws Exception {
		if(habitDao.selectHabitsDoing() == null){
			throw new Exception("진행중인 습관이 존재하지 않습니다.");
		}
		return habitDao.selectHabitsDoing();
	}

	@Override
	public List<Habit> selectHabitsDoingByDoer(String doerId) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}
		if(habitDao.selectHabitsDoingByDoer(doerId) == null){
			throw new Exception(doerId+"님의 진행중인 습관이 존재하지 않습니다.");
		}
		return habitDao.selectHabitsDoingByDoer(doerId);
	}

	@Override
	public List<Habit> selectHabitsDone() throws Exception {
		if(habitDao.selectHabitsDone() == null){
			throw new Exception("진행중인 습관이 존재하지 않습니다.");
		}
		return habitDao.selectHabitsDone();
	}

	@Override
	public List<Habit> selectHabitsDoneByDoer(String doerId) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}
		if(habitDao.selectHabitsDoneByDoer(doerId) == null){
			throw new Exception(doerId+"님의 진행중인 습관이 존재하지 않습니다.");
		}
		return habitDao.selectHabitsDoneByDoer(doerId);
	}
	

	@Override
	public HabitCheck selectHabitCheckTodayByHabitNo(int habitNo) {
		return habitCheckDao.selectHabitCheckTodayByHabitNo(habitNo);
	}

	@Override
	public Map<String, Object> selectHabitsPaging(int page) throws Exception {
		if(habitDao.selectHabits() == null) {
			throw new Exception("습관이 존재하지 않습니다!");
		}
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = habitDao.selectCountHabits();
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Habit> list = habitDao.selectHabitsPaging(pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}

	

	@Override
	public Map<String, Object> selectHabitsByDoerPaging(String doerId, int page) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}
		/*if(habitDao.selectHabitsByDoer(doerId) == null) {
			throw new Exception(doerId+"님의 습관이 존재하지 않습니다!");
		}*/
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = habitDao.selectCountHabitsByDoer(doerId);
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Habit> list = habitDao.selectHabitsByDoerPaging(doerId, pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}

	@Override
	public Map<String, Object> selectHabitsDoingPaging(int page) throws Exception {
		if(habitDao.selectHabitsDoing() == null){
			throw new Exception("진행중인 습관이 존재하지 않습니다.");
		}
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = habitDao.selectCountHabitsDoing();
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Habit> list = habitDao.selectHabitsDoingPaging(pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}


	@Override
	public Map<String, Object> selectHabitsDoingByDoerPaging(String doerId, int page) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}
		if(habitDao.selectHabitsDoingByDoer(doerId) == null){
			throw new Exception(doerId+"님의 진행중인 습관이 존재하지 않습니다.");
		}
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = habitDao.selectCountHabitsDoingByDoer(doerId);
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Habit> list = habitDao.selectHabitsDoingByDoerPaging(doerId, pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}


	@Override
	public Map<String, Object> selectHabitsDonePaging(int page) throws Exception {
		if(habitDao.selectHabitsDone() == null){
			throw new Exception("진행중인 습관이 존재하지 않습니다.");
		}

		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = habitDao.selectCountHabitsDone();
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Habit> list = habitDao.selectHabitsDonePaging(pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}


	@Override
	public Map<String, Object> selectHabitsDoneByDoerPaging(String doerId, int page) throws Exception {
		if(doerDao.selectDoerById(doerId) == null) {
			throw new Exception("존재하지 않는 회원입니다!");
		}
		if(habitDao.selectHabitsDoneByDoer(doerId) == null){
			throw new Exception(doerId+"님의 진행중인 습관이 존재하지 않습니다.");
		}

		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = habitDao.selectCountHabitsDoneByDoer(doerId);
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Habit> list = habitDao.selectHabitsDoneByDoerPaging(doerId, pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}
	
	
	public Map<String, Object> selectHabitCount(String doerId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalAllHabitCount", habitDao.selectCountHabitsByDoer(doerId));
		map.put("totalHabitDoingCount", habitDao.selectCountHabitsDoingByDoer(doerId));
		map.put("totalHabitSuccessCount", habitDao.selectCountHabitsSuccessByDoer(doerId));
		map.put("totalHabitFailureCount", habitDao.selectCountHabitsFailureByDoer(doerId));
		return map;
	}
	
	@Scheduled(cron="0 58 23 * * *")
	public void testScheduler(){
		System.out.println("----scheduler가 2분 후에 작동합니다!----");
		
	}	
	
	
	
	//------------------스케줄링---------------------
	@Scheduled(cron="0 0 0 * * *")
	public void autoCheckHabitState() {
		List<HabitCheck> habitChkList = new ArrayList<>();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date dateChk = Date.valueOf(sdf.format(cal.getTime()));
		/* Same As :
		 * 		String dateStr = sdf.format(cal.getTime());
		 * 		Date dateChk = sdf.parse(dateStr);
		 */
		System.out.println(dateChk);
		habitChkList = habitCheckDao.selectHabitCheckDoingToday(dateChk);
		System.out.println("habitChkList:"+habitChkList.toString());
		
		for(HabitCheck temp: habitChkList){
			if(temp.getHabitState().equalsIgnoreCase("yet")){
				System.out.println("habitChks:"+temp.toString());
				System.out.println("habit:"+temp.getHabit().toString());
				
				temp.setHabitState("not");
				temp.getHabit().setHabitEnd(dateChk); // 어제 부로
				temp.getHabit().setCompletion('y');	// 진행 끝
				temp.getHabit().setAchievement('n'); // 습관 미완수
				
				//상태 업데이트 
				habitCheckDao.updateHabitCheck(temp);
				System.out.println("-----updateHabitCheck완");
				habitDao.updateHabit(temp.getHabit());
				System.out.println("-----updateHabit완");
				//habitCheck 실패한 나머지 날들 삭제
				System.out.println("삭제한 habitChk수:"+habitCheckDao.deleteHabitCheckAfterDate(temp.getHabitNo(), new Date(cal.getTimeInMillis())));
			
			}
		}
	}
}

