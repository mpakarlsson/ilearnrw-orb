/**
 * 
 */
package ilearn.orb.controller;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
/**
 * @author chris
 * Jan 28, 2015
 *
 * webtests / webtests / WelcomeController.java
 */

import ilearn.orb.controller.utils.profiles.HardcodedUsers;
import ilearn.orb.entities.User;
import ilearn.orb.services.external.UserServices;
import ilearn.orb.services.external.utils.UtilDateDeserializer;
import ilearnrw.user.problems.ProblemDescription;
import ilearnrw.user.profile.UserProfile;

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
				students = HardcodedUsers.defaultStudents();
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
			String json;
			User[] students = null;
			UserProfile p = null;
			User selectedStudent = null;
			if (userid < 0) {
				students = HardcodedUsers.defaultStudents();
				selectedStudent = selectedStudent(students, userid.intValue());
				//p = HardcodedUsers.defaultProfile(selectedStudent.getId());
				json = UserServices.getDefaultProfile(HardcodedUsers.defaultProfileLanguage(userid));
				if (json != null)
					p = new Gson().fromJson(json, UserProfile.class);
			} else {
				Gson gson = new GsonBuilder()
						.registerTypeAdapter(java.util.Date.class,
								new UtilDateDeserializer())
						.setDateFormat(DateFormat.LONG).create();
				json = UserServices
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
			String dataForCircles = "";
			if (p != null){
				String categories = "[";
				dataForCircles = "[";
				ProblemDescription probs[][] = p.getUserProblems().getProblems().getProblems();
				for (int i=0; i<probs.length; i++){
					for (int j=0; j<probs[i].length;j++){
						dataForCircles = dataForCircles+"["+i+", "+p.getUserProblems().getUserSeverity(i, j)+",\""+probs[i][j].getHumanReadableDescription()+"\"]";
						if (i != probs.length-1 || j!= probs[i].length-1)
							dataForCircles = dataForCircles + ", ";
					}
					categories = categories + "\""+p.getUserProblems().getProblemDefinition(i).getUri()+"\"";
					if (i != probs.length-1)
						categories = categories + ", ";
				}
				categories = categories+"]";
				dataForCircles = dataForCircles+"], "+categories+", "+probs.length+", \""+p.getLanguage()+"\"";
			}
			modelMap.put("selectedStudent", selectedStudent);
			modelMap.put("students", students);
			modelMap.put("selectedProfile", p);
			modelMap.put("dataForCircles", dataForCircles);
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
}