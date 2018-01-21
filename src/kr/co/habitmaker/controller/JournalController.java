package kr.co.habitmaker.controller;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.sql.Date;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.habitmaker.service.ImageService;
import kr.co.habitmaker.service.JournalService;
import kr.co.habitmaker.validation.form.JournalForm;
import kr.co.habitmaker.vo.Doer;
import kr.co.habitmaker.vo.Image;
import kr.co.habitmaker.vo.Journal;

@Controller
@RequestMapping("/journal/")
public class JournalController {

	@Autowired
	private JournalService jrnlSvc;
	
	@Autowired
	private ImageService imageSvc;
	
	private final static String ECLIPSE_DIR = "D:\\Java\\workplace1\\HabitMaker\\WebContent\\images\\upload";
	
	List list;
	Doer doer;
	Journal journal;
	Image image;
	Map<String, Object> map;
	Calendar cal;
	
	
	//************저널 추가 메서드
	@RequestMapping("add")
	public ModelAndView addJournal(@ModelAttribute("journal") @Valid JournalForm journalForm, BindingResult errors,	///바인딩리절트 위치 꼭 발리드 뒤에!!!!!!!!!!!!!!!!!!!!!!!!
							HttpServletRequest request) throws IllegalAccessException, InvocationTargetException {
		ModelAndView mv = new ModelAndView();
		
		// 검증
		if(errors.hasErrors()){
			mv.setViewName("/journal/add_form");
			return mv;
		}
		
		
		// 비즈니스 로직
		//	0) 귄한 DOER 쳌
		doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//	1) Journal 객체 생성후  검증된 폼 넣기, 속성값 set
		Journal journal = new Journal();
		//No value specified for 'java.sql.Date'해결위해
		BeanUtilsBean beanUtilsBean = BeanUtilsBean.getInstance();
		beanUtilsBean.getConvertUtils().register(new org.apache.commons.beanutils.converters.SqlDateConverter(null), java.sql.Date.class);
	
		System.out.println(journalForm);
		BeanUtils.copyProperties(journalForm, journal);
		
		journal.setJournalWriteId(doer.getId());	//작성자 설정 : 현재 권한 DOER
		cal = Calendar.getInstance();	//현 시간
		journal.setJournalWriteDate(new Date(cal.getTimeInMillis())); //오늘 날짜로 작성일 설정
		journal.setJournalContents(journal.getJournalContents().replace("\r\n", "<br>"));	//엔터처리
		System.out.println("insert전:"+journal);
		
		// **비즈니스 로직 처리
		jrnlSvc.insertJournal(journal); // journalNo이 생성되어야 image 삽입 가능!!
		
		
		//	2) Journal과 조인된 upImage 사진들 저장 (0~n)  
		String upImageDir = request.getServletContext().getRealPath("/images/upload"); // 이미지 업로드시 저장될 경로 -> 이클립스 프로젝트로 옮길것!
		List<MultipartFile> upImageList = journal.getUpImage();
		if(upImageList != null && !upImageList.isEmpty() && upImageList.size() > 0){	//null체크 최우선
			
			for(MultipartFile upImage : upImageList){	// 하나씩 불러와서 image 개체
				System.out.println("insert후:"+journal);
				if(!upImage.isEmpty()){
				// **image로 넣기
				image = new Image();
				image.setJournalNo(journal.getJournalNo());
				image.setImageOriginalName(upImage.getOriginalFilename());	// 원래 파일이름 세팅
				String imageSaveName = UUID.randomUUID().toString()
											+ getFilenameExtensions(upImage.getOriginalFilename()); // UUID를 이용해 랜덤으로 중복 없는 파일명 생성 (36자+확장자) +
				image.setImageSaveName(imageSaveName);	
				if(upImage.equals(upImageList.get(0))){
					//리스트의 첫번쨰 사진객체를 대표사진으로 지정하기 
					journal.setJournalIconicImage(imageSaveName);
					try {
						jrnlSvc.updateJournal(journal);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

				try {
					// 파일이동
					File dest = new File(upImageDir, image.getImageSaveName());
					// 	1) 이클립스 경로로 카피 (리셋방지) : 직접 IO 작업하는 메서드 만들기~
					copyToEclipseDir(imageSaveName, upImage);	
					//	2) 사진 파일로 저장할 파일로 이동(톰캣)
					upImage.transferTo(dest);//IllegalStateException, IOException
					
					imageSvc.insertImage(image);	//Exception
				} catch (IllegalStateException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					mv.setViewName("/journal/add_form");
					return mv;
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					mv.setViewName("/journal/add_form");
					return mv;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					mv.setViewName("/journal/add_form");
					return mv;
				}
					
				
			}
			}
		}
		
		
		mv.addObject("journalNo", journal.getJournalNo());
		mv.setViewName("redirect:/journal/add/success.do");
		return mv;
	}

	
	
	//************저널 추가 메서드
		@RequestMapping(value="addJournalPop_up", produces="text/html;charset=UTF-8")
		@ResponseBody
		public String addJournal2(@ModelAttribute("journal") @Valid JournalForm journalForm,
											BindingResult errors, HttpServletRequest request) //****BindingResult은 검증 폼 바로뒤 필수!!!!!!!!!!!!!!!!!!!!!!!!!!!!
													throws IllegalAccessException, InvocationTargetException {
			
			// 검증
			if(errors.hasErrors()){
				
				return "-1";
			}
			
			
			// 비즈니스 로직
			//	0) 귄한 DOER 쳌
			doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			//	1) Journal 객체 생성후  검증된 폼 넣기, 속성값 set
			Journal journal = new Journal();
			//No value specified for 'java.sql.Date'해결위해
			BeanUtilsBean beanUtilsBean = BeanUtilsBean.getInstance();
			beanUtilsBean.getConvertUtils().register(new org.apache.commons.beanutils.converters.SqlDateConverter(null), java.sql.Date.class);
		
			System.out.println(journalForm);
			BeanUtils.copyProperties(journalForm, journal);
			
			journal.setJournalWriteId(doer.getId());	//작성자 설정 : 현재 권한 DOER
			cal = Calendar.getInstance();	//현 시간
			journal.setJournalWriteDate(new Date(cal.getTimeInMillis())); //오늘 날짜로 작성일 설정
			journal.setJournalContents(journal.getJournalContents().replace("\r\n", "<br>"));	//엔터처리
			System.out.println("insert전:"+journal);
			
			// **비즈니스 로직 처리
			jrnlSvc.insertJournal(journal); // journalNo이 생성되어야 image 삽입 가능!!
			
			
			
			//	2) Journal과 조인된 upImage 사진들 저장 (0~n)  
			String upImageDir = request.getServletContext().getRealPath("/images/upload"); // 이미지 업로드시 저장될 경로 -> 이클립스 프로젝트로 옮길것!
			List<MultipartFile> upImageList = journal.getUpImage();
			if(upImageList != null && !upImageList.isEmpty() && upImageList.size() > 0){	//null체크 최우선
				
				for(MultipartFile upImage : upImageList){	// 하나씩 불러와서 image 개체
					System.out.println("insert후:"+journal);
					if(!upImage.isEmpty()){
					// **image로 넣기
					image = new Image();
					image.setJournalNo(journal.getJournalNo());
					image.setImageOriginalName(upImage.getOriginalFilename());	// 원래 파일이름 세팅
					String imageSaveName = UUID.randomUUID().toString()
												+ getFilenameExtensions(upImage.getOriginalFilename()); // UUID를 이용해 랜덤으로 중복 없는 파일명 생성 (36자+확장자) +
					image.setImageSaveName(imageSaveName);	
					if(upImage.equals(upImageList.get(0))){
						//리스트의 첫번쨰 사진객체를 대표사진으로 지정하기 
						journal.setJournalIconicImage(imageSaveName);
						try {
							jrnlSvc.updateJournal(journal);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}

					try {
						// 파일이동
						File dest = new File(upImageDir, image.getImageSaveName());
						// 	1) 이클립스 경로로 카피 (리셋방지) : 직접 IO 작업하는 메서드 만들기~
						copyToEclipseDir(imageSaveName, upImage);	
						//	2) 사진 파일로 저장할 파일로 이동(톰캣)
						upImage.transferTo(dest);//IllegalStateException, IOException
						
						imageSvc.insertImage(image);	//Exception
					} catch (IllegalStateException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					} catch (IOException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
						
					/* 125라인에서 처리
					// journal 대표사진지정 : 제일 첫 업로드된 이미지 자동 지정(12/08) -> 나중에 선택할수있게 바꾸기
					if(upImage == upImageList.get(0)){
						journal.setJournalIconicImage(imageSaveName);
					}*/
					
				}
				}
			}
			
			
			// journal 대표사진지정 : 제일 첫 업로드된 이미지 자동 지정(12/08) -> 나중에 선택할수있게 바꾸기
			/*imageSvc.selectImageListByJournalNo(journal.getJournalNo()).get(0);*/
			
			
		
			return "0";
		}
	
	
	
	
	
	// 이클립스 경로로 카피 IO처리 메서드
	private void copyToEclipseDir(String imageSaveName, MultipartFile upImage) {	// io
		File eclipseDest = new File(ECLIPSE_DIR, imageSaveName);
		FileOutputStream fos = null;
		InputStream is = null;
		
		try {
			fos = new FileOutputStream(eclipseDest);
			
			 is = upImage.getInputStream();
			
			byte[] b = new byte[10000];
			int cnt = is.read(b);
			while(cnt != -1){
				fos.write(b, 0, cnt);
				cnt = is.read(b);
			}
		} catch (FileNotFoundException e) { //fos
			e.printStackTrace();
		} catch (IOException e) { //is
			e.printStackTrace();
		}finally{
			try {
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	//굳이 만들어야 한다면
	private String getFilenameExtensions(String fileName){
		return fileName.substring(fileName.lastIndexOf("."));
	}
	
	
	//**************저널 상제 보기 메서드
	@RequestMapping("detail")
	public ModelAndView showJournalDetail(@RequestParam(value="journalNo") int journalNo){
		ModelAndView mv = new ModelAndView();
		
		try {
			journal = jrnlSvc.selectJournalByNoInDetail(journalNo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.addObject("errorMsg", e.getMessage());
			mv.setViewName("/error/fail_to_req");
			return mv;
		}
		System.out.println("journal:"+journal);
		mv.addObject("journal", journal);
		mv.setViewName("/journal/detail");
		return mv;
	}
	
	@RequestMapping("mod_Chk")
	public ModelAndView modfiyJournalForm(@RequestParam int journalNo){
		System.out.println("modfiyJournalForm:"+journalNo);
		ModelAndView mv = new ModelAndView();
		
		try {
			System.out.println("modfiyJournalForm: try안에 전");
			journal = jrnlSvc.selectJournalByNoInDetail(journalNo);
			journal.setJournalContents(journal.getJournalContents().replace("<br>","\r\n"));	//<br>->>\r\n
			System.out.println("modfiyJournalForm: try안에 ");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.addObject("errorMsg", e.getMessage());
			mv.setViewName("/error/fail_to_req");
			return mv;
		}
		
		
		
		mv.addObject("journal", journal);
		mv.setViewName("journal/mod_form");
		return mv;
		
		
	}
	
	
	
	/*//************저널 수정 메서드
	@RequestMapping("modify")
	public ModelAndView modifyJournal(@ModelAttribute("journal") @Valid JournalForm journalForm, BindingResult errors, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		System.out.println("modifyJournal시작!:"+journalForm.toString());
		// 검증
		if(errors.hasErrors()){
			System.out.println("errors.hasErrors():"+errors.getAllErrors());
			mv.setViewName("/journal/mod_form");
			return mv;
		}
		
		
		// 비즈니스 로직
		//	0) 귄한 DOER 쳌
		doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//	1) Journal 객체 생성후  검증된 폼 넣기, 속성값 set
		Journal journal = new Journal();
		//No value specified for 'java.sql.Date'해결위해
		BeanUtilsBean beanUtilsBean = BeanUtilsBean.getInstance();
		beanUtilsBean.getConvertUtils().register(new org.apache.commons.beanutils.converters.SqlDateConverter(null), java.sql.Date.class);
	
		System.out.println(journalForm);
		BeanUtils.copyProperties(journalForm, journal);
		
		journal.setJournalWriteId(doer.getId());	//작성자 설정 : 현재 권한 DOER
		cal = Calendar.getInstance();	//현 시간
		journal.setJournalWriteDate(new Date(cal.getTimeInMillis())); //오늘 날짜로 작성일 설정
		journal.setJournalContents(journal.getJournalContents().replace("\r\n", "<br>"));	//엔터처리
		System.out.println("insert전:"+journal);
		System.out.println("journal.getJournalIconicImage().equals('null')?:"+journal.getJournalIconicImage().equals("null"));
		System.out.println("journal.getJournalIconicImage():"+ journal.getJournalIconicImage());
		
		if(journal.getJournalIconicImage().equals("null") || journal.getJournalIconicImage().equals("")){
			journal.setJournalIconicImage(null);
		}
		
		// 선택된 dropImage 사진들 삭제
		List<String> dropImageList = journal.getDropImage();
		if(dropImageList != null && !dropImageList.isEmpty() && dropImageList.size() > 0){
			System.out.println("dropImageList:"+dropImageList.toString());
			for(String dropImage : dropImageList){
				imageSvc.deleteImage(journal.getJournalNo(), dropImage);
				if(journal.getJournalIconicImage().equals(dropImage)){
					대표사진 갱신작업
					// 삭제하는 사진 리스트에 대표사진이 존재한다면 우선 삭제하고 null로 만든다
					journal.setJournalIconicImage(null);
				}
			}	
				*//******************************
				 * 이클립스, 톰캣 경로에서도 삭제해야하는데 
				 * 그 IO 작업은 나중에 해보자
				 ******************************//*
		}
		
		//모두 삭제 후 
		List<Image> currentImage = imageSvc.selectImageListByJournalNo(journal.getJournalNo());
		System.out.println("currentImage:"+currentImage);
		
		if(currentImage.size() > 0 && journal.getJournalIconicImage() == null){
			//현재 사진 중에 남아있는 것이 있다면 그중 첫쨰 사진 대표사진으로
			journal.setJournalIconicImage(currentImage.get(0).getImageSaveName());
			
		}
		
		
		//	2) Journal과 조인된 upImage 사진들 저장 (0~n)  
		String upImageDir = request.getServletContext().getRealPath("/images/upload"); // 이미지 업로드시 저장될 경로 -> 이클립스 프로젝트로 옮길것!
		List<MultipartFile> upImageList = journal.getUpImage();
		if(upImageList != null && !upImageList.isEmpty() && upImageList.size() > 0){	//null체크 최우선
			
			for(MultipartFile upImage : upImageList){	// 하나씩 불러와서 image 개체
				System.out.println("upImage is Empty() CHK:"+ upImage.isEmpty());
				if(!upImage.isEmpty()){
				// **image로 넣기
				image = new Image();
				image.setJournalNo(journal.getJournalNo());
				image.setImageOriginalName(upImage.getOriginalFilename());	// 원래 파일이름 세팅
				String imageSaveName = UUID.randomUUID().toString()
											+ getFilenameExtensions(upImage.getOriginalFilename()); // UUID를 이용해 랜덤으로 중복 없는 파일명 생성 (36자+확장자) +
				image.setImageSaveName(imageSaveName);	
				if(journal.getJournalIconicImage() == null && upImage.equals(upImageList.get(0))){
					
					//리스트의 첫번쨰 사진객체를 대표사진으로 지정하기 
					System.out.println("journal.getJournalIconicImage() == null && upImage.equals(upImageList.get(0))");
					journal.setJournalIconicImage(imageSaveName);
					
				}
				

				*//**파일이동**//*
				try {
					// 파일이동
					File dest = new File(upImageDir, image.getImageSaveName());
					// 	1) 이클립스 경로로 카피 (리셋방지) : 직접 IO 작업하는 메서드 만들기~
					copyToEclipseDir(imageSaveName, upImage);	
					//	2) 사진 파일로 저장할 파일로 이동(톰캣)
					upImage.transferTo(dest);//IllegalStateException, IOException
					
					imageSvc.insertImage(image);	//Exception
				} catch (IllegalStateException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
			}
			}
		}
		
		
		// **비즈니스 로직 처리
		jrnlSvc.updateJournal(journal); // journalNo이 생성되어야 image 삽입 가능!!
	
		mv.setViewName("redirect:/journal/success.do");
		return mv;	
		
	}*/
	
	
	//************저널 수정 메서드
		@RequestMapping("modify")
		public ModelAndView modifyJournal(@ModelAttribute("journal") @Valid JournalForm journalForm, BindingResult errors, HttpServletRequest request) throws Exception{
			ModelAndView mv = new ModelAndView();
			System.out.println("modifyJournal시작!:"+journalForm.toString());
			// 검증
			if(errors.hasErrors()){
				System.out.println("errors.hasErrors():"+errors.getAllErrors());
				mv.setViewName("/journal/mod_form");
				return mv;
			}
			
			
			// 비즈니스 로직
			//	0) 귄한 DOER 쳌
			doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			//	1) Journal 객체 생성후  검증된 폼 넣기, 속성값 set
			Journal journal = new Journal();
			//No value specified for 'java.sql.Date'해결위해
			BeanUtilsBean beanUtilsBean = BeanUtilsBean.getInstance();
			beanUtilsBean.getConvertUtils().register(new org.apache.commons.beanutils.converters.SqlDateConverter(null), java.sql.Date.class);
		
			System.out.println(journalForm);
			BeanUtils.copyProperties(journalForm, journal);
			
			journal.setJournalWriteId(doer.getId());	//작성자 설정 : 현재 권한 DOER
			cal = Calendar.getInstance();	//현 시간
			journal.setJournalWriteDate(new Date(cal.getTimeInMillis())); //오늘 날짜로 작성일 설정
			journal.setJournalContents(journal.getJournalContents().replace("\r\n", "<br>"));	//엔터처리
			System.out.println("insert전:"+journal);
			System.out.println("journal.getJournalIconicImage().equals('null')?:"+journal.getJournalIconicImage().equals("null"));
			System.out.println("journal.getJournalIconicImage():"+ journal.getJournalIconicImage());
			
			if(journal.getJournalIconicImage().equals("null") || journal.getJournalIconicImage().equals("")){
				journal.setJournalIconicImage(null);
			}
			
			// 선택된 dropImage 사진들 삭제
			List<String> dropImageList = journal.getDropImage();
			if(dropImageList != null && !dropImageList.isEmpty() && dropImageList.size() > 0){
				System.out.println("dropImageList:"+dropImageList.toString());
				for(String dropImage : dropImageList){
					imageSvc.deleteImage(journal.getJournalNo(), dropImage);
					if(journal.getJournalIconicImage().equals(dropImage)){
						/*대표사진 갱신작업*/
						// 삭제하는 사진 리스트에 대표사진이 존재한다면 우선 삭제하고 null로 만든다
						journal.setJournalIconicImage(null);
					}
				}	
					/******************************
					 * 이클립스, 톰캣 경로에서도 삭제해야하는데 
					 * 그 IO 작업은 나중에 해보자
					 ******************************/
			}
			
			//모두 삭제 후 
			List<Image> currentImage = imageSvc.selectImageListByJournalNo(journal.getJournalNo());
			System.out.println("currentImage:"+currentImage);
			
			if(currentImage.size() > 0 && journal.getJournalIconicImage() == null){
				//현재 사진 중에 남아있는 것이 있다면 그중 첫쨰 사진 대표사진으로
				journal.setJournalIconicImage(currentImage.get(0).getImageSaveName());
				
			}
			
			
			//	2) Journal과 조인된 upImage 사진들 저장 (0~n)  
			String upImageDir = request.getServletContext().getRealPath("/images/upload"); // 이미지 업로드시 저장될 경로 -> 이클립스 프로젝트로 옮길것!
			List<MultipartFile> upImageList = journal.getUpImage();
			if(upImageList != null && !upImageList.isEmpty() && upImageList.size() > 0){	//null체크 최우선
				
				for(MultipartFile upImage : upImageList){	// 하나씩 불러와서 image 개체
					System.out.println("upImage is Empty() CHK:"+ upImage.isEmpty());
					if(!upImage.isEmpty()){
					// **image로 넣기
					image = new Image();
					image.setJournalNo(journal.getJournalNo());
					image.setImageOriginalName(upImage.getOriginalFilename());	// 원래 파일이름 세팅
					String imageSaveName = UUID.randomUUID().toString()
												+ getFilenameExtensions(upImage.getOriginalFilename()); // UUID를 이용해 랜덤으로 중복 없는 파일명 생성 (36자+확장자) +
					image.setImageSaveName(imageSaveName);	
					if(journal.getJournalIconicImage() == null && upImage.equals(upImageList.get(0))){
						
						//리스트의 첫번쨰 사진객체를 대표사진으로 지정하기 
						System.out.println("journal.getJournalIconicImage() == null && upImage.equals(upImageList.get(0))");
						journal.setJournalIconicImage(imageSaveName);
						
					}
					

					/**파일이동**/
					try {
						// 파일이동
						File dest = new File(upImageDir, image.getImageSaveName());
						// 	1) 이클립스 경로로 카피 (리셋방지) : 직접 IO 작업하는 메서드 만들기~
						copyToEclipseDir(imageSaveName, upImage);	
						//	2) 사진 파일로 저장할 파일로 이동(톰캣)
						upImage.transferTo(dest);//IllegalStateException, IOException
						
						imageSvc.insertImage(image);	//Exception
					} catch (IllegalStateException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					} catch (IOException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			
				}
				}
			}
			
			
			// **비즈니스 로직 처리
			jrnlSvc.updateJournal(journal); // journalNo이 생성되어야 image 삽입 가능!!
			mv.addObject("journalNo", journal.getJournalNo());
			mv.setViewName("redirect:/journal/modify/success.do");
			return mv;	
			
		}
	
	
	
	@RequestMapping(value = {"modify/success", "add/success"})
	public ModelAndView modifySuccess(int journalNo){
		ModelAndView mv = new ModelAndView();
		try {
			journal = jrnlSvc.selectJournalByNoInDetail(journalNo);
			mv.addObject("journalNo", journalNo);
			mv.setViewName("redirect:/journal/detail.do");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.setViewName("/error/fail_to_req");
			return mv;
		}
		
		return mv;

		
	}
	
	@RequestMapping(value = "remove", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeJournal(@RequestParam List<Integer> journalNo){
		
		System.out.println(journalNo.toString());
		try {
			System.out.println("removeJournal() 삭제 개수:"+jrnlSvc.deleteJournal(journalNo));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.getMessage();
		}
		
		return "0";
	}
	
	
	@RequestMapping("main")
	public ModelAndView moveToJournalMain(@RequestParam(value="page", defaultValue = "1") int page){
		ModelAndView mv = new ModelAndView();
		Doer doer = (Doer)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Map<String, Object> resultMap = jrnlSvc.selectJournalByDoerPaging(doer.getId(), page);
		System.out.println("journal/main.do:"+resultMap.get("list"));
		mv.addObject("resultMap", resultMap);
		mv.setViewName("/journal");
		return mv;
	}

}