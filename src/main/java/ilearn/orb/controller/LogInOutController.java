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

import ilearn.orb.services.external.UserServices;

import java.util.Locale;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
public class LogInOutController {

	private static final Logger logger = LoggerFactory
			.getLogger(LogInOutController.class);

	@RequestMapping(value = "/login")
	public ModelAndView login() {
		ModelAndView model = new ModelAndView();
		model.setViewName("login");
		return model;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam String username,
			@RequestParam String pass, ModelMap modelMap,
			HttpServletRequest request, HttpSession session) {
		ModelAndView model = new ModelAndView();

		try {
			String jsonTokens = UserServices.getToken(username, pass);
			JSONObject jsonObj = new JSONObject(jsonTokens);
			String token = jsonObj.getString("auth");
			session.setAttribute("username", username);
			session.setAttribute("auth", token);

			String json = UserServices.getDetails(username);
			session.setAttribute("id", (new JsonParser().parse(json)
					.getAsJsonObject()).get("id").toString());

			model.setViewName("redirect:/");
		} catch (Exception e) {
			model.setViewName("login");
			int t = e.getMessage().indexOf('?');
			modelMap.addAttribute("error", e.getMessage().substring(0, t));
		}
		return model;
	}

	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpSession session) {
		session.removeAttribute("auth");
		session.removeAttribute("username");
		session.removeAttribute("id");
		ModelAndView model = new ModelAndView();
		model.setViewName("logout");
		return model;
	}

}