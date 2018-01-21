package kr.co.habitmaker.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.habitmaker.dao.JournalDao;
import kr.co.habitmaker.vo.Journal;

@Repository
public class JournalDaoImpl implements JournalDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "journalMapper."+tagId;
	}
	
	@Override
	public int insertJournal(Journal journal) {
		// TODO Auto-generated method stub
		return session.insert(makeSql("insertJournal"), journal);
	}

	@Override
	public int updateJournal(Journal journal) {
		// TODO Auto-generated method stub
		return session.update(makeSql("updateJournal"), journal);
	}

	
	@Override
	public int deleteJournal(List<Integer> journalNo) {
		// TODO Auto-generated method stub
		// Map<String, Object> map = new HashMap<String, Object>();
		return session.delete(makeSql("deleteJournal"), journalNo);
	}

	@Override
	public Journal selectJournalByNo(int journalNo) {
		// TODO Auto-generated method stub
		System.out.println("JournalDao-selectJournalByNo:JournalNo="+journalNo);
		return session.selectOne(makeSql("selectJournalByNo"), journalNo);
	}
	
	
	
	
	@Override
	public Journal selectJournalByNoInDetail(int journalNo) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectJournalByNoInDetail"), journalNo);
	}

	@Override
	public List<Journal> selectJournalAll() {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectJournalAll"));
	}
	
	@Override
	public int selectCountJournalAll() {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountJournalAll"));
	}

	@Override
	public List<Journal> selectJournalAllPaging(int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectJournalAllPaging"), input);
	}

	
	

	@Override
	public List<Journal> selectJournalByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectJournalByDoer"), doerId);
	}
	
	@Override
	public int selectCountJournalByDoer(String doerId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountJournalByDoer"), doerId);
	}

	@Override
	public List<Journal> selectJournalByDoerPaging(String journalWriteId, int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("journalWriteId", journalWriteId);
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectJournalByDoerPaging"), input);
	}
	
	
	

	@Override
	public List<Journal> selectJournalByTitle(String doerId, String title) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("doerId", doerId);
		input.put("title", title);
		return session.selectList(makeSql("selectJournalByTitle"), input);
	}
	
	@Override
	public int selectCountJournalByTitle(String doerId, String title) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("doerId", doerId);
		input.put("title", title);
		return session.selectOne(makeSql("selectCountJournalByTitle"), input);
	}

	@Override
	public List<Journal> selectJournalByTitlePaging(String doerId, String title, int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("doerId", doerId);
		input.put("title", title);
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectJournalByTitlePaging"), input);
	}
	

}
