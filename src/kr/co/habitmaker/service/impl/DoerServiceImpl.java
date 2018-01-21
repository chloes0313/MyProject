package kr.co.habitmaker.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.habitmaker.dao.DoerDao;
import kr.co.habitmaker.service.DoerService;
import kr.co.habitmaker.util.PagingBean;
import kr.co.habitmaker.vo.Authority;
import kr.co.habitmaker.vo.Doer;

@Service(value="doerService")
public class DoerServiceImpl implements DoerService{
	
	@Autowired
	private DoerDao doerDao;

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@Override
	public int insertDoer(Doer doer, String authority) throws Exception {
		//콘솔에 로그찍기
		System.out.println("insertDoer : " +doer.toString());
		
		if(doerDao.selectDoerById(doer.getId()) != null){
			throw new Exception("이미 존재하는 아이디입니다.");
		}
		
		//패스워드 암호화 처리
		doer.setPassword(passwordEncoder.encode(doer.getPassword()));
		doerDao.insertDoer(doer);
		doerDao.insertAuthority(new Authority(doer.getId(), authority));
		return 1;
	}

	@Override
	public int updateDoer(Doer doer) throws Exception {
		if(doerDao.selectDoerById(doer.getId()) == null){
			throw new Exception("존재하지 않는 회원입니다.");
		}
		//콘솔에 로그찍기
		System.out.println("updateDoer : " +doer.toString());
		//패스워드 암호화 처리
		doer.setPassword(passwordEncoder.encode(doer.getPassword()));
		return doerDao.updateDoer(doer);
	}

	@Override
	public int deleteDoer(String id) throws Exception{
		if(doerDao.selectDoerById(id) == null){
			throw new Exception("존재하지 않는 회원입니다.");
		}
		return doerDao.deleteDoer(id);
	}

	
	
	@Override
	public List<Doer> selectAllDoers() throws Exception {
		if(doerDao.selectAllDoers() == null){
			throw new Exception("존재하지 않는 회원입니다.");
		}
		return doerDao.selectAllDoers();
	}

	@Override
	public Doer selectDoerById(String id) throws Exception {
		if(doerDao.selectDoerById(id) == null){
			throw new Exception(id+"(이)라는 아이디의 회원이 존재하지 않습니다.");
		}
		return doerDao.selectDoerById(id);
	}

	@Override
	public Doer selectDoerByName(String name) throws Exception {
		if(doerDao.selectDoerByName(name) == null){
			throw new Exception(name+"(이)라는 이름의 회원이 존재하지 않습니다");
		}
		return doerDao.selectDoerByName(name);
	}


	@Override
	public Map<String, Object> selectAllDoersPaging(int page) throws Exception {
		if(doerDao.selectAllDoers() == null){
			throw new Exception("회원이 존재하지 않습니다.");
		}
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		int totalCount = doerDao.selectCountDoer();
		PagingBean pagingBean = new PagingBean(totalCount, page);
		
		List<Doer> list = doerDao.selectAllDoersPaging(pagingBean.getBeginItemInPage(), pagingBean.getEndItemInPage());
		pagingMap.put("pagingBean", pagingBean);
		pagingMap.put("list", list);
		
		return pagingMap;
	}
	
	

	
}
