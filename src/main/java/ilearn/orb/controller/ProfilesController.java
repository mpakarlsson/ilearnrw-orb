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
	public ModelAndView profiles(Locale locale,
			ModelMap modelMap, HttpSession session) {

		ModelAndView model = new ModelAndView();
		model.setViewName("profiles");

		try {
			Gson gson = new GsonBuilder ().registerTypeAdapter(java.util.Date.class, new UtilDateDeserializer()) 
					.setDateFormat(DateFormat.LONG).create(); 
			String json = UserServices.getProfiles(Integer.parseInt(session.getAttribute("id").toString()), session.getAttribute("auth").toString());
            User[] students = gson.fromJson(json, User[].class);
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
			@PathVariable("userid") Integer userid,
			ModelMap modelMap, HttpSession session) {

		ModelAndView model = new ModelAndView();
		model.setViewName("profiles");

		try {
			Gson gson = new GsonBuilder ().registerTypeAdapter(java.util.Date.class, new UtilDateDeserializer()) 
					.setDateFormat(DateFormat.LONG).create(); 
			String json = UserServices.getProfiles(Integer.parseInt(session.getAttribute("id").toString()), session.getAttribute("auth").toString());
            User[] students = gson.fromJson(json, User[].class);
            modelMap.put("students", students);
            User selectedStudent = students[0];
            for (User student : students)
            	if (student.getId() == userid.intValue()){
            		selectedStudent = student;
            		break;
            	}
            modelMap.put("selectedStudent", selectedStudent);
            
            json = UserServices.getJsonProfile(userid, session.getAttribute("auth").toString());
            UserProfile p = new Gson().fromJson(json,UserProfile.class);
            modelMap.put("selectedProfile", p);

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

}