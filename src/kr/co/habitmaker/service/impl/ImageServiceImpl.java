package kr.co.habitmaker.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.habitmaker.dao.ImageDao;
import kr.co.habitmaker.dao.JournalDao;
import kr.co.habitmaker.service.ImageService;
import kr.co.habitmaker.vo.Image;

@Service(value="imageService")
public class ImageServiceImpl implements ImageService{

	@Autowired
	private ImageDao imageDao;
	
	@Autowired
	private JournalDao jrnlDao;
	
	@Override
	public int insertImage(Image image) throws Exception {
		//유효성 검사
		if(jrnlDao.selectJournalByNo(image.getJournalNo()) == null){
			throw new Exception("존재하지 않는 저널입니다!");
		}
		
		return imageDao.insertImage(image);
	}

	@Override
	public int deleteImageByJournalNo(int journalNo) throws Exception {
		//유효성 검사
		if(jrnlDao.selectJournalByNo(journalNo) == null){
			throw new Exception("존재하지 않는 저널입니다!");
		}
	
		return imageDao.deleteImageByJournalNo(journalNo);
	}

	@Override
	public int deleteImage(int journalNo, String imageSaveName) throws Exception {
		if(jrnlDao.selectJournalByNo(journalNo) == null){
			throw new Exception("존재하지 않는 저널입니다!");
		}else if(imageDao.selectImageBySaveName(journalNo, imageSaveName) == null){
			throw new Exception("존재하지 않는 이미지입니다!");
		}
		
		return imageDao.deleteImage(journalNo, imageSaveName);
	}

	@Override
	public List<Image> selectImageListByJournalNo(int journalNo) throws Exception {
		if(jrnlDao.selectJournalByNo(journalNo) == null ){
			throw new Exception("존재하지 않는 저널입니다!");
		}
		
		return imageDao.selectImageListByJournalNo(journalNo);
	}
	
	

}
