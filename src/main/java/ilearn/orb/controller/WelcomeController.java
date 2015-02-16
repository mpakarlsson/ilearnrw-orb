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

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;


@Controller
public class WelcomeController {

	private static final Logger logger = LoggerFactory
			.getLogger(WelcomeController.class);

	//@RequestMapping(value = "/{name}", method = RequestMethod.GET)
	@RequestMapping(value = "/")
	public ModelAndView welcome(Locale locale,
			//@PathVariable("name") String name,
			HttpSession session) {

		ModelAndView model = new ModelAndView();
		model.setViewName("index");
		//model.addObject("name", name);

		return model;

	}

}