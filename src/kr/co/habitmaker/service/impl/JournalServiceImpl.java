package kr.co.habitmaker.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ejb.access.EjbAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.ExceptionHandlerExceptionResolver;

import kr.co.habitmaker.dao.DoerDao;
import kr.co.habitmaker.dao.ImageDao;
import kr.co.habitmaker.dao.JournalDao;
import kr.co.habitmaker.service.JournalService;
import kr.co.habitmaker.util.PagingBean;
import kr.co.habitmaker.vo.Journal;

@Service(value="journalService")
public class JournalServiceImpl implements JournalService{

	@Autowired
	private JournalDao jrnlDao;
	
	@Autowired
	private ImageDao imgDao;
	
	
	
	
	@Override
	public int insertJournal(Journal jrnl) {
		// 1)저널 추가 : 제목 중복 허용
		return jrnlDao.insertJournal(jrnl);
		
	}

	@Override
	public int updateJournal(Journal jrnl) throws Exception {
		// 유효성검사
		if(jrnlDao.selectJournalByNo(jrnl.getJournalNo()) == null){
			throw new Exception("존재하지 않는 저널입니다!");
		}
	
		// 1) 저널 갱신
		return jrnlDao.updateJournal(jrnl);
		
		
	}

	
	@Override
	public int deleteJournal(List<Integer> journalNo) {
		// 유효성 검사
/*		for(int tempNo : journalNo){
			if(jrnlDao.selectJournalByNo(tempNo) == null){
				throw new Exception("존재하지 않는 저널입니다!");
			}
		}*/
	
		return jrnlDao.deleteJournal(journalNo);
	}

	@Override
	public Journal selectJournalByNo(int journalNo) throws Exception {
		// 유효성 검사
		Journal journal = jrnlDao.selectJournalByNo(journalNo);
		if( journal == null ){
			throw new Exception("존재하지 않는 저널입니다.");
		}
		
		return journal;
	}
	
	

	@Override
	public Journal selectJournalByNoInDetail(int journalNo) throws Exception {
		// 유효성 검사
				Journal journal = jrnlDao.selectJournalByNoInDetail(journalNo);
				if( journal == null ){
					throw new Exception("존재하지 않는 저널입니다.");
				}
				
				return journal;
	}

	@Override
	public List<Journal> selectJournalAll() {
		// 유효성 검사
		List<Journal> list = jrnlDao.selectJournalAll();
		/*if( list == null || list.isEmpty() || list.size() <= 0 ){
			throw new Exception("저널이 존재하지 않습니다.");
		}*/
		return list;
	}

	@Override
	public Map<String, Object> selectJournalAllPaging(int page) {
		// TODO Auto-generated method stub
		// 유효성 검사
		List<Journal> check = jrnlDao.selectJournalAll();
		/*if( check == null || check.isEmpty() || check.size() == 0 ){
			throw new Exception("저널이 존재하지 않습니다.");
		}
		*/
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = jrnlDao.selectCountJournalAll();
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Journal> list = jrnlDao.selectJournalAllPaging(pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}

	@Override
	public List<Journal> selectJournalByDoer(String doerId) {
		// 유효성 검사
		List<Journal> list = jrnlDao.selectJournalByDoer(doerId);
		/*if( list == null || list.isEmpty() || list.size() == 0 ){
			throw new Exception(doerId+"님의 저널이 존재하지 않습니다.");
		}*/
		return list;
	}

	@Override
	public Map<String, Object> selectJournalByDoerPaging(String journalWriteId, int page){
		/*List<Journal> check = jrnlDao.selectJournalByDoer(doerId);
		if( check == null || check.isEmpty() || check.size() == 0 ){
			throw new Exception(doerId+"님의 저널이 존재하지 않습니다.");
		}*/
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = jrnlDao.selectCountJournalByDoer(journalWriteId);
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Journal> list = jrnlDao.selectJournalByDoerPaging(journalWriteId, pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}

	@Override
	public List<Journal> selectJournalByTitle(String doerId, String title) {
		// 유효성 검사
		List<Journal> list = jrnlDao.selectJournalByTitle(doerId, title);
		/*if( list == null || list.isEmpty() || list.size() == 0 ){
			throw new Exception(doerId+"님의 저널 중에서 \""+title+"\"라는 구문이 포함된 제목의 저널이 존재하지 않습니다.");
		}*/
		return list;
	}

	@Override
	public Map<String, Object> selectJournalByTitlePaging(String doerId, String title, int page) {
		// 유효성 검사
		List<Journal> check = jrnlDao.selectJournalByTitle(doerId, title);
		/*if( check == null || check.isEmpty() || check.size() == 0 ){
			throw new Exception(doerId+"님의 저널 중에서 \""+title+"\"라는 구문이 포함된 제목의 저널이 존재하지 않습니다.");
		}
		*/
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = jrnlDao.selectCountJournalAll();
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Journal> list = jrnlDao.selectJournalByTitlePaging(doerId, title, pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		return pagingMap;
	}
	

}
