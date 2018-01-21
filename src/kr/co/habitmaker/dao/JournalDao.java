package kr.co.habitmaker.dao;

import java.util.List;

import kr.co.habitmaker.vo.Journal;

/**
 * 저널(블로그) 관련 DAO
 * @author Chloe
 *
 */
public interface JournalDao {

	/**
	 * 저널 삽입
	 * @param jrnl
	 * @return
	 */
	int insertJournal(Journal jrnl);
	
	/**
	 * 저널 갱신
	 * @param jrnl
	 * @return
	 */
	int updateJournal(Journal jrnl);
	
	
	/**
	 * 저널삭제
	 * @param journalNo
	 * @return
	 */
	int deleteJournal(List<Integer> journalNo);
	
	
	/**
	 * 특정 번호 저널 조회
	 * @param JournalNo
	 * @return
	 */
	Journal selectJournalByNo(int JournalNo);
	
	/**
	 * 특정 번호 저널  상세 조회
	 * @param journalNo
	 * @return
	 */
	Journal selectJournalByNoInDetail(int journalNo);
	
	
	/**
	 * 전체 저널(전체사용자) 조회
	 * @return
	 */
	List<Journal> selectJournalAll();
	
	int selectCountJournalAll();
	List<Journal> selectJournalAllPaging(int startIdx, int endIdx);
	
	
	/**
	 * 특정 사용자 전체 저널 조회
	 * @return
	 */
	List<Journal> selectJournalByDoer(String doerId);
	
	int selectCountJournalByDoer(String doerId);
	List<Journal> selectJournalByDoerPaging(String doerId, int startIdx, int endIdx);
	
	/**
	 * 제목 부분검색해서 특정 사용자 저널 조회
	 * @param title
	 * @return
	 */
	List<Journal> selectJournalByTitle(String doerId, String title);
	
	int selectCountJournalByTitle(String doerId, String title);
	List<Journal> selectJournalByTitlePaging(String doerId, String title, int startIdx, int endIdx);

}
