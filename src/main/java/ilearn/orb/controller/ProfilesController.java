/**
 * 
 */
package ilearn.orb.controller;

/**
 * @author chris
 * Jan 28, 2015
 *
 * webtests / webtests / WelcomeController.java
 */

import ilearn.orb.entities.User;
import ilearn.orb.services.external.UserServices;
import ilearn.orb.services.external.utils.UtilDateDeserializer;
import ilearn.orb.utils.profiles.ProfileGenerator;
import ilearnrw.user.profile.UserProfile;
import ilearnrw.utils.LanguageCode;

import java.text.DateFormat;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.http.HttpSession;

@Controller
public class ProfilesController {

	private static final Logger logger = LoggerFactory
			.getLogger(ProfilesController.class);

	@RequestMapping(value = "/profiles")
	public ModelAndView profiles(Locale locale, ModelMap modelMap,
			HttpSession session) {

		ModelAndView model = new ModelAndView();
		model.setViewName("profiles");

		try {
			Gson gson = new GsonBuilder()
					.registerTypeAdapter(java.util.Date.class,
							new UtilDateDeserializer())
					.setDateFormat(DateFormat.LONG).create();
			User[] students = null;
			try {
				String json = UserServices
						.getProfiles(Integer.parseInt(session
								.getAttribute("id").toString()), session
								.getAttribute("auth").toString());
				students = gson.fromJson(json, User[].class);
			} catch (NullPointerException e) {
			}
			if (students == null || students.length == 0) {
				students = defaultStudents();
			}
			modelMap.put("students", students);

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

	@RequestMapping(value = "/profiles/{userid}", method = RequestMethod.GET)
	public ModelAndView userProfile(Locale locale,
			@PathVariable("userid") Integer userid, ModelMap modelMap,
			HttpSession session) {

		ModelAndView model = new ModelAndView();
		model.setViewName("profiles");

		try {
			User[] students = null;
			UserProfile p = null;
			User selectedStudent = null;
			if (userid < 0) {
				students = defaultStudents();
				selectedStudent = selectedStudent(students, userid.intValue());
				p = defaultProfile(selectedStudent.getId());
			} else {
				Gson gson = new GsonBuilder()
						.registerTypeAdapter(java.util.Date.class,
								new UtilDateDeserializer())
						.setDateFormat(DateFormat.LONG).create();
				String json = UserServices
						.getProfiles(Integer.parseInt(session
								.getAttribute("id").toString()), session
								.getAttribute("auth").toString());
				students = gson.fromJson(json, User[].class);
				selectedStudent = selectedStudent(students, userid.intValue());

				json = UserServices.getJsonProfile(userid, session
						.getAttribute("auth").toString());
				if (json != null)
					p = new Gson().fromJson(json, UserProfile.class);
			}
			modelMap.put("selectedStudent", selectedStudent);
			modelMap.put("students", students);
			modelMap.put("selectedProfile", p);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

	private User selectedStudent(User [] students, int id){
		User selectedStudent = students[0];
		for (User student : students)
			if (student.getId() == id) {
				selectedStudent = student;
				break;
			}
		return selectedStudent;
	}
	
	private static User[] defaultStudents() {
		User[] students = new User[4];
		students[0] = new User(LanguageCode.EN, "english_low", -50);
		students[1] = new User(LanguageCode.EN, "english_high", -40);
		students[2] = new User(LanguageCode.EN, "greek_low", -30);
		students[3] = new User(LanguageCode.EN, "greek_high", -20);
		return students;
	}
	
	private static UserProfile defaultProfile(int id){
		if (id == -20)
			return ProfileGenerator.createProfile(LanguageCode.GR, 3);
		else if (id == -30)
			return ProfileGenerator.createProfile(LanguageCode.GR, 1);
		if (id == -40)
			return ProfileGenerator.createProfile(LanguageCode.EN, 3);
		else
			return ProfileGenerator.createProfile(LanguageCode.EN, 1);
	}
}