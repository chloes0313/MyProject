package kr.co.habitmaker.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

public class Habit implements Serializable{
	private int habitNo;
	private String doerId;
	private String habitTitle;
	private Date habitStart;
	private Date habitEnd;
	private char completion;
	private char achievement;
	
	
	ArrayList<HabitCheck> habitCheck;
	//int day, String habitState
	
	//Calendar tempD = Calendar.getInstance();
	
	public Habit() {
		super();
	}


	public Habit(int habitNo, String doerId, String habitTitle, Date habitStart, char completion,
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
	
	


	public Habit(int habitNo, String doerId, String habitTitle, Date habitStart, Date habitEnd, char completion,
			char achievement, ArrayList<HabitCheck> habitCheck) {
		super();
		this.habitNo = habitNo;
		this.doerId = doerId;
		this.habitTitle = habitTitle;
		this.habitStart = habitStart;
		this.habitEnd = habitEnd;
		this.completion = completion;
		this.achievement = achievement;
		this.habitCheck = habitCheck;
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

	
	

	

	public ArrayList<HabitCheck> getHabitCheck() {
		return habitCheck;
	}


	public void setHabitCheck(ArrayList<HabitCheck> habitCheck) {
		this.habitCheck = habitCheck;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + achievement;
		result = prime * result + completion;
		result = prime * result + ((doerId == null) ? 0 : doerId.hashCode());
		result = prime * result + ((habitCheck == null) ? 0 : habitCheck.hashCode());
		result = prime * result + ((habitEnd == null) ? 0 : habitEnd.hashCode());
		result = prime * result + habitNo;
		result = prime * result + ((habitStart == null) ? 0 : habitStart.hashCode());
		result = prime * result + ((habitTitle == null) ? 0 : habitTitle.hashCode());
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
		Habit other = (Habit) obj;
		if (achievement != other.achievement)
			return false;
		if (completion != other.completion)
			return false;
		if (doerId == null) {
			if (other.doerId != null)
				return false;
		} else if (!doerId.equals(other.doerId))
			return false;
		if (habitCheck == null) {
			if (other.habitCheck != null)
				return false;
		} else if (!habitCheck.equals(other.habitCheck))
			return false;
		if (habitEnd == null) {
			if (other.habitEnd != null)
				return false;
		} else if (!habitEnd.equals(other.habitEnd))
			return false;
		if (habitNo != other.habitNo)
			return false;
		if (habitStart == null) {
			if (other.habitStart != null)
				return false;
		} else if (!habitStart.equals(other.habitStart))
			return false;
		if (habitTitle == null) {
			if (other.habitTitle != null)
				return false;
		} else if (!habitTitle.equals(other.habitTitle))
			return false;
		return true;
	}


	@Override
	public String toString() {
		return "Habit [habitNo=" + habitNo + ", doerId=" + doerId + ", habitTitle=" + habitTitle + ", habitStart="
				+ habitStart + ", habitEnd=" + habitEnd + ", completion=" + completion + ", achievement=" + achievement
				+ ", habitCheck=" + habitCheck + "]";
	}


	


	
	
	

}
