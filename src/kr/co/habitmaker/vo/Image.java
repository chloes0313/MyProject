package kr.co.habitmaker.vo;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

public class Image implements Serializable{
	private int journalNo;
	private String imageSaveName;		//UUID로 생성한 이름 - 파일명 중복을 피하기 위해
	private String imageOriginalName;	 //원래이름
	
	private MultipartFile upImage;
	
	
	
	public Image(int journalNo, String imageSaveName, String imageOriginalName) {
		super();
		this.journalNo = journalNo;
		this.imageSaveName = imageSaveName;
		this.imageOriginalName = imageOriginalName;
	}

	public Image(int journalNo, String imageSaveName, String imageOriginalName, MultipartFile upImage) {
		super();
		this.journalNo = journalNo;
		this.imageSaveName = imageSaveName;
		this.imageOriginalName = imageOriginalName;
		this.upImage = upImage;
	}

	public Image(){}
	
	
	
	public int getJournalNo() {
		return journalNo;
	}

	public void setJournalNo(int journalNo) {
		this.journalNo = journalNo;
	}

	public String getImageSaveName() {
		return imageSaveName;
	}

	public void setImageSaveName(String imageSaveName) {
		this.imageSaveName = imageSaveName;
	}

	public String getImageOriginalName() {
		return imageOriginalName;
	}

	public void setImageOriginalName(String imageOriginalName) {
		this.imageOriginalName = imageOriginalName;
	}

	public MultipartFile getUpImage() {
		return upImage;
	}
	
	public void setUpImage(MultipartFile upImage) {
		this.upImage = upImage;
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((imageOriginalName == null) ? 0 : imageOriginalName.hashCode());
		result = prime * result + ((imageSaveName == null) ? 0 : imageSaveName.hashCode());
		result = prime * result + journalNo;
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
		Image other = (Image) obj;
		if (imageOriginalName == null) {
			if (other.imageOriginalName != null)
				return false;
		} else if (!imageOriginalName.equals(other.imageOriginalName))
			return false;
		if (imageSaveName == null) {
			if (other.imageSaveName != null)
				return false;
		} else if (!imageSaveName.equals(other.imageSaveName))
			return false;
		if (journalNo != other.journalNo)
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
		return "Image [journalNo=" + journalNo + ", imageSaveName=" + imageSaveName + ", imageOriginalName="
				+ imageOriginalName + ", upImage=" + upImage + "]";
	}

	
	
}
