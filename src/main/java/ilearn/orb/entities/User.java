package ilearn.orb.entities;

import java.util.Date;

/*
 * This class should be identical to the following class of ilearnrw-services project:
 * package com.ilearnrw.common.security.users.model.User
 */
public class User {

	private Integer id;
	private String username;
	private String password;

	private boolean enabled;
	
	private String gender;
	
	private Date birthdate;
	
	private String language;

	public User() {
	}

	public User(String id) {
		this.id = Integer.parseInt(id);
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password="
				+ password + ", enabled=" + enabled + ", gender=" + gender
				+ ", birthdate=" + birthdate + ", language=" + language + "]";
	}
		
}