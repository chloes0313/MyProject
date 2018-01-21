package kr.co.habitmaker.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.habitmaker.dao.DoerDao;
import kr.co.habitmaker.vo.Authority;
import kr.co.habitmaker.vo.Doer;

@Repository
public class DoerDaoImpl implements DoerDao{
	
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "doerMapper."+tagId;
	}
	

	@Override
	public int insertDoer(Doer doer) {
		// TODO Auto-generated method stub
		return session.insert(makeSql("insertDoer"), doer);
	}
	
	@Override
	public int insertAuthority(Authority authority) {
		// TODO Auto-generated method stub
		return session.insert(makeSql("insertAuthority"), authority);
	}

	@Override
	public int updateDoer(Doer doer) {
		// TODO Auto-generated method stub
		return session.update(makeSql("updateDoer"), doer);
	}

	@Override
	public int deleteDoer(String id) {
		// TODO Auto-generated method stub
		return session.delete(makeSql("deleteDoer"), id);
	}

	
	

	@Override
	public List<Authority> selectAuthoritiesById(String userId) {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectAuthoritiesById"), userId);
	}

	// SELECT
	@Override
	public List<Doer> selectAllDoers() {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectAllDoers"));
	}

	@Override
	public Doer selectDoerById(String id) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectDoerById"), id);
	}

	@Override
	public Doer selectDoerByName(String name) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectDoerByName"), name);
	}

	
	/*************************PAGING*************************/
	@Override
	public int selectCountDoer() {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("selectCountDoer"));
	}

	@Override
	public List<Doer> selectAllDoersPaging(int startIdx, int endIdx) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("startIdx", startIdx);
		input.put("endIdx", endIdx);
		return session.selectList(makeSql("selectAllDoersPaging"), input);
	}
	
	

}
