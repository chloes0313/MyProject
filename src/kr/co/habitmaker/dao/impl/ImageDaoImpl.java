package kr.co.habitmaker.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.habitmaker.dao.ImageDao;
import kr.co.habitmaker.vo.Image;

@Repository
public class ImageDaoImpl implements ImageDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "imageMapper."+tagId;
	}
	
	
	@Override
	public int insertImage(Image image) {
		// TODO Auto-generated method stub
		return session.insert(makeSql("insertImage"), image);
	}

	@Override
	public int deleteImageByJournalNo(int journalNo) {
		// TODO Auto-generated method stub
		return session.delete(makeSql("deleteImage"), journalNo);
	}

	@Override
	public int deleteImage(int journalNo, String imageSaveName) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("journalNo", journalNo);
		input.put("imageSaveName", imageSaveName);
		return session.delete(makeSql("deleteImage"), input);
	}

	@Override
	public List<Image> selectImageListByJournalNo(int journalNo) {
		// TODO Auto-generated method stub
		return session.selectList(makeSql("selectImageListByJournalNo"), journalNo);
	}


	@Override
	public Image selectImageBySaveName(int journalNo, String imageSaveName) {
		// TODO Auto-generated method stub
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("journalNo", journalNo);
		input.put("imageSaveName", imageSaveName);
		return session.selectOne(makeSql("selectImageBySaveName"), input);
	}
	
	
	

}
