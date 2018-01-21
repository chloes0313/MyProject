package kr.co.habitmaker.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.habitmaker.service.DoerService;
import kr.co.habitmaker.service.HabitService;
import kr.co.habitmaker.validation.form.DoerForm;
import kr.co.habitmaker.vo.Doer;
import kr.co.habitmaker.vo.Habit;
import kr.co.habitmaker.vo.HabitCheck;

@Controller
@RequestMapping("/")
public class DoerController {
	
	@Autowired
	private DoerService doerSvc;
	@Autowired
	private HabitService habitSvc;
	
	/*
	@Autowired
	private HabitCheckService habitChkSvc
	*/
	
	List list;
	Doer doer;
	Habit habit;
	HabitCheck habitChk;
	
	/**
	 * 회원가입
	 * @param doerForm
	 * @param errors
	 * @return
	 */
	@RequestMapping("join")
	public ModelAndView registerDoer(@ModelAttribute("doer") @Valid DoerForm doerForm, BindingResult errors) throws IllegalStateException, IOException{
		ModelAndView mv = new ModelAndView();
		if(errors.hasErrors()){
			List<FieldError> list = errors.getFieldErrors();
			StringBuffer sb = new StringBuffer();
			for(FieldError e : list){
				sb.append(e.getDefaultMessage()+"\n");
			}
			mv.addObject("fail", "#join-us");
			mv.setViewName("/index");
			return mv;
		}
		
		//비즈니스 로직 처리
		doer = new Doer();
		BeanUtils.copyProperties(doerForm, doer);
		try {
			doerSvc.insertDoer(doer, "ROLE_DOER");
		} catch (Exception e) {
			mv.addObject("errorMsg", e.getMessage());
			mv.addObject("fail", "#join-us");
			mv.setViewName("/index");
			return mv;
		}
		
		mv.setViewName("redirect:/join/success.do");
		return mv;
		
	}
	
	
	@RequestMapping("join/success")
	public ModelAndView registerDoerSuccess(){
		System.out.println("왓니");
		//웰컴페이지 필요
		return new ModelAndView("welcome");
	}	
	
	/**
	 * 로그인 실패
	 * @param errorMsg
	 * @return
	 */
	@RequestMapping(value="signIn/fail", produces="text/html;charset=UTF-8", method={RequestMethod.POST,RequestMethod.GET}) 
	public ModelAndView signInFailure(String errorCode){
		ModelAndView mv = new ModelAndView();
		if(errorCode.equals("id")){
			mv.addObject("errorMsg_id", "ID를 확인하세요.");
		}else if(errorCode.equals("pw")){
			mv.addObject("errorMsg_pw", "패스워드를 확인하세요.");
		}
		mv.addObject("fail", "#sign-in");
		mv.setViewName("/index");
		return mv;
	}
	
	
	/**
	 * 로그인 성공
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="signIn/success", produces="text/html;charset=UTF-8", method={RequestMethod.POST,RequestMethod.GET}) 
	public ModelAndView signInSuccess() throws Exception{
		Doer doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//갯수 체크
		// 1) 전체 시도 습관
		ModelAndView mv = new ModelAndView();
		Map<String, Object> countMap = new HashMap<>();
		
		countMap = habitSvc.selectHabitCount(doer.getId());
		mv.addObject("countMap", countMap);
		mv.setViewName("/index");
		return mv;
		
	}
	
	@RequestMapping(value="findHabitCount", produces="application/json", method={RequestMethod.POST,RequestMethod.GET}) 
	@ResponseBody
	public Map<String, Object> findHabitCount() throws Exception{
		Doer doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Map<String, Object> countMap = new HashMap<>();
		//System.out.println("doer:"+doer);
		countMap = habitSvc.selectHabitCount(doer.getId());
		System.out.println("findHabitCount:"+countMap);
		return countMap;
	}
}
