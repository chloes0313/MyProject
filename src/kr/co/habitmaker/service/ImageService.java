package kr.co.habitmaker.service;

import java.util.List;

import kr.co.habitmaker.vo.Image;

public interface ImageService {
	/**
	 * 저널 이미지 삽입
	 * @param Image
	 * @return
	 * @throws Exception 
	 */
	int insertImage(Image image) throws Exception;
	
	/**
	 * 저널 이미지들 모두 삭제
	 * @param journalNo
	 * @return
	 * @throws Exception 
	 */
	int deleteImageByJournalNo(int journalNo) throws Exception;
	
	/**
	 * 저널의 특정 이미지 삭제
	 * @param journalNo
	 * @param Image
	 * @return
	 * @throws Exception 
	 */
	int deleteImage(int journalNo, String imageSaveName) throws Exception; 
	
	/**
	 * 선택 저넉의 이미지들 조회
	 * @param journalNo
	 * @return
	 * @throws Exception 
	 */
	List<Image> selectImageListByJournalNo(int journalNo) throws Exception;
}
