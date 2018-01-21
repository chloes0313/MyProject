package kr.co.habitmaker.validation.form;

import java.sql.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class HabitForm{
	
	private int habitNo;
	
	private String doerId;
	
	@NotEmpty(message="목표는 2자이상 20자 이하로 입력하세요.")
	@Length(min=2, max=20)
	private String habitTitle;
	
	@NotNull
	private Date habitStart;
	
	private Date habitEnd;
	
	private char completion;
	
	private char achievement;
	
	
	public HabitForm() {
		super();
	}

	

	
	public HabitForm(int habitNo, String doerId, String habitTitle, Date habitStart, char completion,
			char achievement) {
		super();
		this.habitNo = habitNo;
		this.doerId = doerId;
		this.habitTitle = habitTitle;
		this.habitStart = habitStart;
		this.habitEnd = new Date(habitStart.getTime()+(1000*60*60*24*66));
		this.completion = completion;
		this.achievement = achievement;
	}


	public String getDoerId() {
		return doerId;
	}


	public void setDoerId(String doerId) {
		this.doerId = doerId;
	}


	public int getHabitNo() {
		return habitNo;
	}


	public void setHabitNo(int habitNo) {
		this.habitNo = habitNo;
	}


	public String getHabitTitle() {
		return habitTitle;
	}


	public void setHabitTitle(String habitTitle) {
		this.habitTitle = habitTitle;
	}


	public Date getHabitStart() {
		return habitStart;
	}


	public void setHabitStart(Date habitStart) {
		this.habitStart = habitStart;
	}


	public Date getHabitEnd() {
		return habitEnd;
	}


	public void setHabitEnd(Date habitEnd) {
		this.habitEnd = habitEnd;
	}


	public char getCompletion() {
		return completion;
	}


	public void setCompletion(char completion) {
		this.completion = completion;
	}


	public char getAchievement() {
		return achievement;
	}


	public void setAchievement(char achievement) {
		this.achievement = achievement;
	}


	@Override
	public String toString() {
		return "HabitForm [habitNo=" + habitNo + ", doerId=" + doerId + ", habitTitle=" + habitTitle + ", habitStart="
				+ habitStart + ", habitEnd=" + habitEnd + ", completion=" + completion + ", achievement=" + achievement
				+ "]";
	}


	

}
