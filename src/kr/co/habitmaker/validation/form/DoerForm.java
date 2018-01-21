package kr.co.habitmaker.validation.form;

import java.util.ArrayList;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import kr.co.habitmaker.vo.Habit;

public class DoerForm {
	
	@NotEmpty(message="아이디는 4자이상 20자 이하로 입력해주세요.")
	@Length(min=4, max=20)
	private String id;
	
	@NotEmpty(message="비밀번호는 4자이상 20자 이하로 입력해주세요.")
	@Length(min=4, max=20)
	private String password;
	
	@NotEmpty(message="이름을 입력하세요.")
	private String name;
	
	@NotEmpty(message="이메일을 입력하세요.")
	private String email;

	private ArrayList<Habit> habitList;
	
	
	
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public ArrayList<Habit> getHabitList() {
		return habitList;
	}


	public void setHabitList(ArrayList<Habit> habitList) {
		this.habitList = habitList;
	}



	
	
	
	

	
	
}
