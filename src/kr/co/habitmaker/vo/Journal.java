package kr.co.habitmaker.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;


import org.springframework.web.multipart.MultipartFile;

public class Journal implements Serializable{

	private int journalNo;
	private String journalWriteId;
	private Date journalWriteDate;
	private String journalTitle;
	private String journalContents;
	private String journalIconicImage;
	
	private List<MultipartFile> upImage;
	private List<String> dropImage; //저장된 이름 
	
	private List<Image> imageList;
	
	public Journal() {
	}


	

	public Journal(int journalNo, String journalWriteId, Date journalWriteDate, String journalTitle, String journalContents,
			String journalIconicImage) {
		this.journalNo = journalNo;
		this.journalWriteId = journalWriteId;
		this.journalWriteDate = journalWriteDate;
		this.journalTitle = journalTitle;
		this.journalContents = journalContents;
		this.journalIconicImage = journalIconicImage;
	}
	
	

	public Journal(int journalNo, String journalWriteId, Date journalWriteDate, String journalTitle, String journalContents,
			String journalIconicImage, List<MultipartFile> upImage, List<String> dropImage) {
	
		this(journalNo, journalWriteId, journalWriteDate, journalTitle, journalContents, journalIconicImage);
		this.upImage = upImage;
		this.dropImage = dropImage;
	}




	public Journal(int journalNo, String journalWriteId, Date journalWriteDate, String journalTitle, String journalContents,
				String journalIconicImage, ArrayList<Image> imageList) {
		this(journalNo, journalWriteId, journalWriteDate, journalTitle, journalContents, journalIconicImage);
		this.imageList = imageList;
	}





	


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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dropImage == null) ? 0 : dropImage.hashCode());
		result = prime * result + ((imageList == null) ? 0 : imageList.hashCode());
		result = prime * result + ((journalContents == null) ? 0 : journalContents.hashCode());
		result = prime * result + ((journalIconicImage == null) ? 0 : journalIconicImage.hashCode());
		result = prime * result + journalNo;
		result = prime * result + ((journalTitle == null) ? 0 : journalTitle.hashCode());
		result = prime * result + ((journalWriteDate == null) ? 0 : journalWriteDate.hashCode());
		result = prime * result + ((journalWriteId == null) ? 0 : journalWriteId.hashCode());
		result = prime * result + ((upImage == null) ? 0 : upImage.hashCode());
		return result;
	}




	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Journal other = (Journal) obj;
		if (dropImage == null) {
			if (other.dropImage != null)
				return false;
		} else if (!dropImage.equals(other.dropImage))
			return false;
		if (imageList == null) {
			if (other.imageList != null)
				return false;
		} else if (!imageList.equals(other.imageList))
			return false;
		if (journalContents == null) {
			if (other.journalContents != null)
				return false;
		} else if (!journalContents.equals(other.journalContents))
			return false;
		if (journalIconicImage == null) {
			if (other.journalIconicImage != null)
				return false;
		} else if (!journalIconicImage.equals(other.journalIconicImage))
			return false;
		if (journalNo != other.journalNo)
			return false;
		if (journalTitle == null) {
			if (other.journalTitle != null)
				return false;
		} else if (!journalTitle.equals(other.journalTitle))
			return false;
		if (journalWriteDate == null) {
			if (other.journalWriteDate != null)
				return false;
		} else if (!journalWriteDate.equals(other.journalWriteDate))
			return false;
		if (journalWriteId == null) {
			if (other.journalWriteId != null)
				return false;
		} else if (!journalWriteId.equals(other.journalWriteId))
			return false;
		if (upImage == null) {
			if (other.upImage != null)
				return false;
		} else if (!upImage.equals(other.upImage))
			return false;
		return true;
	}




	@Override
	public String toString() {
		return "Journal [journalNo=" + journalNo + ", journalWriteId=" + journalWriteId + ", journalWriteDate="
				+ journalWriteDate + ", journalTitle=" + journalTitle + ", journalContents=" + journalContents
				+ ", journalIconicImage=" + journalIconicImage + ", imageList=" + imageList + "]";
	}




	
	
	
	
	
}
