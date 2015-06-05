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
import ilearn.orb.services.external.AnalysisResults;
import ilearn.orb.services.external.TextServices;
import ilearn.orb.services.external.UserServices;
import ilearn.orb.services.external.utils.UtilDateDeserializer;
import ilearnrw.user.profile.UserProfile;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class AnalysisController {

	private static final Logger logger = LoggerFactory
			.getLogger(AnalysisController.class);

	// @RequestMapping(value = "/{name}", method = RequestMethod.GET)
	@RequestMapping(value = "/analysis")
	public ModelAndView textAnalysis(Locale locale,
			ModelMap modelMap,
			HttpServletRequest request, 
			HttpSession session) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		ModelAndView model = new ModelAndView();
		model.setViewName("analysis");

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
			String text = request.getParameter("inputText");
			String profileId = request.getParameter("selectedId");
			if (text != null){
				text = new String(text.getBytes("8859_1"),"UTF-8");
			}
			else
				text = "";
			modelMap.put("profileId", profileId);
			modelMap.put("text", text);
			String json;
			if (Integer.parseInt(profileId) > 0)
				json = TextServices.getAnalysisJson(Integer.parseInt(profileId), session.getAttribute("auth").toString(), text);
			else
				json = TextServices.getAnalysisJson(HardcodedUsers.defaultProfileLanguage(Integer.parseInt(profileId)), text);
			AnalysisResults analysisResults = null;
			analysisResults = (new Gson()).fromJson(json, AnalysisResults.class);
			modelMap.put("analysisResults", analysisResults);
			UserProfile pr = retrieveProfile(session, Integer.parseInt(profileId));
			modelMap.put("selectedProfile", pr);
			int maxWordsMatched = 0;
			for (int i=0; i<pr.getUserProblems().getNumerOfRows(); i++){
				for (int j = 0; j<pr.getUserProblems().getRowLength(i); j++){
					if (analysisResults.getUserCounters().getValue(i, j) > maxWordsMatched)
						maxWordsMatched = analysisResults.getUserCounters().getValue(i, j);
				}
			}
			modelMap.put("maxWordsMatched", maxWordsMatched);
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

	private static UserProfile retrieveProfile(HttpSession session, int userId)
			throws NumberFormatException, Exception {
		UserProfile p = null;
		User[] students = null;
		User selectedStudent = null;
		if (userId < 0) {
			students = HardcodedUsers.defaultStudents();
			selectedStudent = selectedStudent(students, userId);
			//p = HardcodedUsers.defaultProfile(selectedStudent.getId());
			String json = UserServices.getDefaultProfile(HardcodedUsers.defaultProfileLanguage(selectedStudent.getId()));
			if (json != null)
				p = new Gson().fromJson(json, UserProfile.class);
			
		} else {
			Gson gson = new GsonBuilder()
					.registerTypeAdapter(java.util.Date.class,
							new UtilDateDeserializer())
					.setDateFormat(DateFormat.LONG).create();
			String json = UserServices.getProfiles(
					Integer.parseInt(session.getAttribute("id").toString()),
					session.getAttribute("auth").toString());
			students = gson.fromJson(json, User[].class);
			selectedStudent = selectedStudent(students, userId);

			json = UserServices.getJsonProfile(userId,
					session.getAttribute("auth").toString());
			if (json != null)
				p = new Gson().fromJson(json, UserProfile.class);
		}
		return p;
	}

	private static User selectedStudent(User[] students, int id) {
		User selectedStudent = students[0];
		for (User student : students)
			if (student.getId() == id) {
				selectedStudent = student;
				break;
			}
		return selectedStudent;
	}

}