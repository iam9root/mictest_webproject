package vo;

import java.util.Date;

public class LoginVO {
	String email;
	String nickname;
	String password;
	Date joindate;
	int gender;
	int user_level;
	int birthyear;
	int m_like;
	String profile_img;
	
	public LoginVO(String email, String password) {
		super();
		this.email = email;
		this.password = password;
	}	
	
	public LoginVO() {
		
	}	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getJoindate() {
		return joindate;
	}
	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getUser_level() {
		return user_level;
	}
	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}
	public int getBirthyear() {
		return birthyear;
	}
	public void setBirthyear(int birthyear) {
		this.birthyear = birthyear;
	}
	public int getM_like() {
		return m_like;
	}
	public void setM_like(int m_like) {
		this.m_like = m_like;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	
}

