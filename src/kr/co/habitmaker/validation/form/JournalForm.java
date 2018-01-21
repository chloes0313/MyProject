package kr.co.habitmaker.validation.form;

import java.sql.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import kr.co.habitmaker.vo.Image;

public class JournalForm{
	
	
	private int journalNo;//sql자동 시퀀스
	private String journalWriteId;//컨트롤러에서 
	private Date journalWriteDate;//컨트롤러에서
	
	@NotEmpty
	@Length(min=2, max=50)
	private String journalTitle;
	
	@NotEmpty
	@Length(min=2, max=2000)
	private String journalContents;
	
	private String journalIconicImage;
	
	private List<MultipartFile> upImage;
	private List<String> dropImage;	//저장된 이름 불러옴
	
	private List<Image> imageList;
	
	
	public int getJournalNo() {
		return journalNo;
	}

	public void setJournalNo(int journalNo) {
		this.journalNo = journalNo;
	}

	public String getJournalWriteId() {
		return journalWriteId;
	}

	public void setJournalWriteId(String journalWriteId) {
		this.journalWriteId = journalWriteId;
	}

	public Date getJournalWriteDate() {
		return journalWriteDate;
	}

	public void setJournalWriteDate(Date journalWriteDate) {
		this.journalWriteDate = journalWriteDate;
	}

	public String getJournalTitle() {
		return journalTitle;
	}

	public void setJournalTitle(String journalTitle) {
		this.journalTitle = journalTitle;
	}

	public String getJournalContents() {
		return journalContents;
	}

	public void setJournalContents(String journalContents) {
		this.journalContents = journalContents;
	}

	public String getJournalIconicImage() {
		return journalIconicImage;
	}

	public void setJournalIconicImage(String journalIconicImage) {
		this.journalIconicImage = journalIconicImage;
	}

	public List<MultipartFile> getUpImage() {
		return upImage;
	}

	public void setUpImage(List<MultipartFile> upImage) {
		this.upImage = upImage;
	}

	public List<String> getDropImage() {
		return dropImage;
	}

	public void setDropImage(List<String> dropImage) {
		this.dropImage = dropImage;
	}

	public List<Image> getImageList() {
		return imageList;
	}

	public void setImageList(List<Image> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "JournalForm [journalNo=" + journalNo + ", journalWriteId=" + journalWriteId + ", journalWriteDate="
				+ journalWriteDate + ", journalTitle=" + journalTitle + ", journalContents=" + journalContents
				+ ", journalIconicImage=" + journalIconicImage + ", upImage=" + upImage + ", dropImage=" + dropImage
				+ ", imageList=" + imageList + "]";
	}

	
	
	
}
