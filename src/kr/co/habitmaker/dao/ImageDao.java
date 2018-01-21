package kr.co.habitmaker.dao;

import java.util.List;

import kr.co.habitmaker.vo.Image;

/**
 * 저널에 포함될 이미지 관련 DAO
 * @author Chloe
 *
 */
public interface ImageDao {

	/**
	 * 저널 이미지 삽입
	 * @param Image
	 * @return
	 */
	int insertImage(Image image);
	
	/**
	 * 저널 이미지들 모두 삭제
	 * @param journalNo
	 * @return
	 */
	int deleteImageByJournalNo(int journalNo);
	
	/**
	 * 저널의 특정 이미지 삭제
	 * @param journalNo
	 * @param Image
	 * @return
	 */
	int deleteImage(int journalNo, String imageOriginalName); 
	
	/**
	 * 선택 저넉의 이미지들 조회
	 * @param journalNo
	 * @return
	 */
	List<Image> selectImageListByJournalNo(int journalNo);
	
	
	Image selectImageBySaveName(int journalNo,  String imageSaveName);
}
