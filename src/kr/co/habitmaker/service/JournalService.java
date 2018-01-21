package kr.co.habitmaker.service;

import java.util.List;
import java.util.Map;

import kr.co.habitmaker.vo.Journal;

/**
 * Jouranl 관련 
 * @author Chloe
 *
 */
public interface JournalService {

	/**
	 * 저널을 추가한다
	 * @param jrnl
	 * @return
	 */
	int insertJournal(Journal jrnl);
	
	/**
	 * 저널 갱신
	 * @param jrnl
	 * @return
	 * @throws Exception 
	 */
	int updateJournal(Journal jrnl) throws Exception;
	
	
	/**
	 * 저널 삭제한다
	 * @param journalNo
	 * @return
	 * @throws Exception 
	 */
	int deleteJournal(List<Integer> journalNo) throws Exception;
	
	
	/**
	 * 특정 번호 저널 조회
	 * @param JournalNo
	 * @return
	 * @throws Exception 
	 */
	Journal selectJournalByNo(int JournalNo) throws Exception;
	
	
	/**
	 * 특정 번호 저널 상세 조회 - in detail
	 * @param journalNo
	 * @return
	 * @throws Exception 
	 */
	Journal selectJournalByNoInDetail(int journalNo) throws Exception;
	
	
	/**
	 * 전체 저널(전체사용자) 조회
	 * @return
	 * @throws Exception 
	 */
	List<Journal> selectJournalAll() throws Exception;
	
	Map<String, Object> selectJournalAllPaging(int page) throws Exception;
	
	
	/**
	 * 특정 사용자 전체 저널 조회
	 * @return
	 * @throws Exception 
	 */
	List<Journal> selectJournalByDoer(String doerId) throws Exception;
	
	Map<String, Object> selectJournalByDoerPaging(String doerId, int page);
	
	/**
	 * 제목 부분검색해서 특정 사용자 저널 조회
	 * @param title
	 * @return
	 * @throws Exception 
	 */
	List<Journal> selectJournalByTitle(String doerId, String title) throws Exception;
	
	Map<String, Object> selectJournalByTitlePaging(String doerId, String title, int page) throws Exception;

	
}
