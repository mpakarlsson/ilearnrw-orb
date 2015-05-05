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

import ilearn.orb.controller.utils.profiles.HardcodedUsers;
import ilearn.orb.entities.User;
import ilearn.orb.services.external.TextServices;
import ilearn.orb.services.external.UserServices;
import ilearn.orb.services.external.utils.UtilDateDeserializer;
import ilearnrw.annotation.AnnotatedPack;
import ilearnrw.textadaptation.Rule;
import ilearnrw.textadaptation.TextAnnotationModule;
import ilearnrw.user.profile.UserProfile;

import java.io.UnsupportedEncodingException;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class AnnotationController {
	private TextAnnotationModule txModule;
	private AnnotatedPack annotatedPack;
	private static final Logger logger = LoggerFactory
			.getLogger(AnnotationController.class);

	@RequestMapping(value = "/annotation")
	public ModelAndView textAnnotation(Locale locale, ModelMap modelMap,
			HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		// System.err.println(request.getRemoteAddr());
		// System.err.println(request.getRemoteHost());
		// System.err.println(request.getRemotePort());

		txModule = new TextAnnotationModule();

		ModelAndView model = new ModelAndView();
		model.setViewName("annotation");

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
			if (text != null) {
				text = new String(text.getBytes("8859_1"), "UTF-8");
			} else
				text = "";
			modelMap.put("profileId", profileId);
			modelMap.put("text", text);
			//UserProfile pr = retrieveProfile(session,
			//		Integer.parseInt(profileId));

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

	@RequestMapping(value = "/annotation/{userid}", method = RequestMethod.GET)
	public ModelAndView textUserAnnotation(Locale locale, ModelMap modelMap,
			HttpServletRequest request, HttpSession session,
			@PathVariable("userid") Integer userid) {

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		// System.err.println(request.getRemoteAddr());
		// System.err.println(request.getRemoteHost());
		// System.err.println(request.getRemotePort());

		txModule = new TextAnnotationModule();

		ModelAndView model = new ModelAndView();
		model.setViewName("annotation");

		try {
			User[] students = null;
			UserProfile p = null;
			User selectedStudent = null;
			if (userid < 0) {
				students = HardcodedUsers.defaultStudents();
				selectedStudent = selectedStudent(students, userid.intValue());
				//p = HardcodedUsers.defaultProfile(selectedStudent.getId());
				String json = UserServices.getDefaultProfile(HardcodedUsers.defaultProfileLanguage(selectedStudent.getId()));
				if (json != null)
					p = new Gson().fromJson(json, UserProfile.class);
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
			modelMap.put("profileId", userid);
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

	@RequestMapping(value = "/annotated/{userid}")
	public ModelAndView annotatedText(Locale locale, ModelMap modelMap,
			HttpServletRequest request, HttpSession session,
			@PathVariable("userid") Integer userid) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		ActiveRule activeRules[] = null;
		String activatedRules = request.getParameter("activeRules");
		if (!activatedRules.trim().isEmpty()){
			String p[] = activatedRules.trim().split(",");
			activeRules = new ActiveRule[p.length];
			for (int i=0; i<p.length; i++){
				activeRules[i] = new ActiveRule();
				String q[] = p[i].trim().split("_");
				activeRules[i].category = Integer.parseInt(q[0]);
				activeRules[i].index = Integer.parseInt(q[1]);
				activeRules[i].rule = Integer.parseInt(q[2]);
				activeRules[i].color = Integer.parseInt(q[3].substring(1), 16);
			}
		}
		
		ModelAndView model = new ModelAndView();
		model.setViewName("annotated");

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
			if (text == null)
				text = "";
			
			modelMap.put("profileId", userid);
			modelMap.put("text", text);
			UserProfile pr = retrieveProfile(session, userid);

			String annotatedJson;
			if (userid>0)
				annotatedJson = TextServices.getAnnotatedText(userid, "EN",
						session.getAttribute("auth").toString(), text);
			else
				annotatedJson = TextServices.getAnnotatedText(HardcodedUsers.defaultProfileLanguage(userid), text);
			annotatedPack = (new Gson()).fromJson(annotatedJson,
					AnnotatedPack.class);

			txModule.setProfile(pr);
			txModule.initializePresentationModule();
			txModule.setInputHTMLFile(annotatedPack.getHtml());
			txModule.setJSonObject(annotatedPack.getWordSet());

			if (activeRules != null && activeRules.length > 0){
				for (ActiveRule ar : activeRules){
					txModule.getPresentationRulesModule().setPresentationRule(ar.category, ar.index,
							ar.rule);
					txModule.getPresentationRulesModule().setTextColor(ar.category, ar.index, ar.color);
					txModule.getPresentationRulesModule().setHighlightingColor(ar.category, ar.index,
							ar.color);
					txModule.getPresentationRulesModule().setActivated(ar.category, ar.index, true);
				}
			}
			txModule.annotateText();

			String result = new String(txModule.getAnnotatedHTMLFile());
			modelMap.put("annotatedText", result);
			
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

	private class ActiveRule{
		int category, index, rule, color;
	}
	
	private static UserProfile retrieveProfile(HttpSession session, int userId)
			throws NumberFormatException, Exception {
		UserProfile p = null;
		if (userId < 0) {
			//p = HardcodedUsers.defaultProfile(selectedStudent.getId());
			String json = UserServices.getDefaultProfile(HardcodedUsers.defaultProfileLanguage(userId));
			if (json != null)
				p = new Gson().fromJson(json, UserProfile.class);
		} else {
			String json = UserServices.getProfiles(
					Integer.parseInt(session.getAttribute("id").toString()),
					session.getAttribute("auth").toString());

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