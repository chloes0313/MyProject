package kr.co.habitmaker.vo;

import java.io.Serializable;
import java.util.Date;

/****
 *  없어도 될 VO - 사용 보류
 * @author Chloe
 *
 */
public class HabitCheck implements Serializable{
	private int habitNo;
	private int day;
	private Date habitDate;
	private String habitState;
	
	Habit habit;
	
	public HabitCheck() {
		super();
	}

	

	public HabitCheck(int habitNo, int day, Date date, String habitState) {
		super();
		this.habitNo = habitNo;
		this.day = day;
		this.habitDate = date;
		this.habitState = habitState;
	}



	public HabitCheck(int habitNo, int day, Date date, String habitState, Habit habit) {
		super();
		this.habitNo = habitNo;
		this.day = day;
		this.habitDate = date;
		this.habitState = habitState;
		this.habit = habit;
	}



	public int getHabitNo() {
		return habitNo;
	}

	public void setHabitNo(int habitNo) {
		this.habitNo = habitNo;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}



	public Date getHabitDate() {
		return habitDate;
	}


	public void setHabitDate(Date habitDate) {
		this.habitDate = habitDate;
	}
	
	public String getHabitState() {
		return habitState;
	}

	public void setHabitState(String habitState) {
		this.habitState = habitState;
	}

	




	public Habit getHabit() {
		return habit;
	}

	public void setHabit(Habit habit) {
		this.habit = habit;
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((habitDate == null) ? 0 : habitDate.hashCode());
		result = prime * result + day;
		result = prime * result + ((habit == null) ? 0 : habit.hashCode());
		result = prime * result + habitNo;
		result = prime * result + ((habitState == null) ? 0 : habitState.hashCode());
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
		HabitCheck other = (HabitCheck) obj;
		if (habitDate == null) {
			if (other.habitDate != null)
				return false;
		} else if (!habitDate.equals(other.habitDate))
			return false;
		if (day != other.day)
			return false;
		if (habit == null) {
			if (other.habit != null)
				return false;
		} else if (!habit.equals(other.habit))
			return false;
		if (habitNo != other.habitNo)
			return false;
		if (habitState == null) {
			if (other.habitState != null)
				return false;
		} else if (!habitState.equals(other.habitState))
			return false;
		return true;
	}



	@Override
	public String toString() {
		return "HabitCheck [habitNo=" + habitNo + ", day=" + day + ", date=" + habitDate + ", habitState=" + habitState
				+ ", habit=" + habit + "]";
	}

	
	
	

	
	

}
