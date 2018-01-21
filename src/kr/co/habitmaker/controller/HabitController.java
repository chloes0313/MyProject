package kr.co.habitmaker.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.habitmaker.service.DoerService;
import kr.co.habitmaker.service.HabitService;
import kr.co.habitmaker.validation.form.HabitForm;
import kr.co.habitmaker.vo.Doer;
import kr.co.habitmaker.vo.Habit;
import kr.co.habitmaker.vo.HabitCheck;

@Controller
@RequestMapping("/habit/")
public class HabitController {

	@Autowired
	private DoerService doerSvc;
	@Autowired
	private HabitService habitSvc;
	
	
	List list;
	Doer doer;
	Habit habit;
	HabitCheck habitCheck;
	Map<String, Object> map;
	
	
	@RequestMapping("add")
	public ModelAndView addHabit(@ModelAttribute("habit") @Valid HabitForm habitForm, BindingResult errors) throws IllegalStateException, IOException{
		//검증
		if(errors.hasErrors()){
			System.out.println("addHabit 검증 폼:"+habitForm);
			System.out.println("addHabit 검증애러:"+errors.getAllErrors());
			return new ModelAndView("habit");
		}
		
		
		//비즈니스 로직
		//	1)권한 ID CHK
		Doer doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//	2)Habit 객체 생성후 검증된 폼 넣기
		Habit habit = new Habit();
		BeanUtils.copyProperties(habitForm, habit);
		habit.setDoerId(doer.getId());
		Calendar cal = Calendar.getInstance();
		cal.setTime(habit.getHabitStart());
		cal.add(Calendar.DATE, 66);
		habit.setHabitEnd(new Date(cal.getTimeInMillis()));
		habit.setCompletion('n');
		System.out.println(habit);
		
		try {
			habitSvc.insertHabit(habit);
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("habit", "errorMsg_duplicateTitle", e.getMessage());
		}
		
		return new ModelAndView("redirect:/habit/success.do");
	}
		
	
	@RequestMapping("success")
	public ModelAndView addHabitSuccess() throws Exception{
		System.out.println("addHabitSuccess():추가성공");
		return new ModelAndView("redirect:/habit/main.do");
	}
	
	
	
	
	@RequestMapping("main")
	public ModelAndView moveToHabitMain(@RequestParam(value = "page", defaultValue = "1") int page){
		ModelAndView mv = new ModelAndView();
		//권한 ID CHK
			Doer doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			//비즈니스로직
			try {
				//	진행중인 것만 불러와!
				map = habitSvc.selectHabitsDoingByDoerPaging(doer.getId(), page);
			} catch (Exception e) {
				e.printStackTrace();
				mv.addObject("errorMsg", e.getMessage());
				mv.setViewName("/habit");
				return mv;
			}
			
			mv.addObject("doingMap", map);
			mv.setViewName("/habit");
			return mv;
		}
	
	
	@RequestMapping("detail")
	public ModelAndView showHabitDetail(@RequestParam int habitNo){
		ModelAndView mv = new ModelAndView();
		System.out.println("showHabitDetail-------"+habitNo);
		try {
			habit = habitSvc.selectHabitByHabitNo(habitNo);
			habitCheck = habitSvc.selectHabitCheckTodayByHabitNo(habitNo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.addObject("errorMsg", e.getMessage());
			mv.setViewName("error/fail_to_req");
			return mv;
		}
		
		System.out.println("habit:"+habit);
		System.out.println("todayHabitCheck:"+habitCheck);
		mv.addObject("habit", habit);
		mv.addObject("todayHabitCheck", habitCheck);
		mv.setViewName("/habit/detail");	//jsp
		return mv;
	}
	
	@RequestMapping(value="habit_chk/toggle")
	@ResponseBody
	public HabitCheck toggleHabitCheck(@RequestParam int habitNo, @RequestParam int day) throws Exception{
		HabitCheck habitCheck = new HabitCheck();
		try {
			habitCheck = habitSvc.selectHabitByHabitNo(habitNo).getHabitCheck().get(day-1);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			habitSvc.updateHabitCheck(habitCheck);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
		return habitSvc.selectHabitByHabitNo(habitNo).getHabitCheck().get(day-1);
	}
	
	@RequestMapping(value="calendar", produces="application/json", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public List getHabitCalendar(){
		
		List<Map<String, Object>> events = new ArrayList<Map<String, Object>>();
		Doer doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Habit> habitList = new ArrayList<Habit>();
		try {
			habitList = habitSvc.selectHabitsByDoer(doer.getId());
			for(Habit habit : habitList){
				Map<String, Object> event = new HashMap<>();
				event.put("title", habit.getHabitTitle());
				event.put("start", new SimpleDateFormat("yyyy-MM-dd").format(habit.getHabitStart()));	// 그냥 habit.getHabitStart()를 넣으면 -1일로 출력됨!
				event.put("end", new SimpleDateFormat("yyyy-MM-dd").format(habit.getHabitEnd()));
				events.add(event);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("getHabitCalendar:"+events.toString());
		return events;
				
	}
	
	@RequestMapping(value = "remove", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeHabit(@RequestParam List<Integer> habitNo){
		try {
			habitSvc.deleteHabitByHabitNo(habitNo);
			return "0";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.getMessage();
		}
		
	}
	
}
