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

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class AnalysisController {

	private static final Logger logger = LoggerFactory
			.getLogger(AnalysisController.class);

	//@RequestMapping(value = "/{name}", method = RequestMethod.GET)
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
			if (text != null){
				text = new String(text.getBytes("8859_1"),"UTF-8");
				System.out.println(text);
			}
			else
				text = "";
			modelMap.put("text", text);
			String json = TextServices.getAnalysisJson(Integer.parseInt(session.getAttribute("id").toString()), session.getAttribute("auth").toString(), text);
			System.err.println(json);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

}