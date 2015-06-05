/**
 * 
 */
package ilearn.orb.services.external;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
import ilearn.orb.services.external.utils.Connection;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;


/**
 * @author chris
 * Nov 15, 2014
 *
 * iLearnTextAnalysis / application / Services.java
 */
public class TextServices {

	public static String getAnalysisJson(int id, String token, String text) throws Exception{
		return Connection.sendPost("text/classify?userId=" + id + "&token=" + token, text);
	}
	
	public static String getAnalysisJson(String lc, String text) throws Exception{
		return Connection.sendPost("public/text/classify?lc=" + lc, text);
	}

	public static String getAnnotatedText(int id, String language, String token, String text) throws Exception{
		return Connection.sendPost("text/annotate?userId=" + id + "&lc="+language+"&token=" + token, text);
	}
	
	public static String getAnnotatedText(String lc, String text) throws Exception{
		return Connection.sendPost("public/text/annotate?lc=" + lc, text);
	}

	public static String loadToken() throws Exception {
		String token = "";
		File f = new File("tokens.json");
		if (f.exists()) {
			InputStream is = new FileInputStream("tokens.json");
			String jsonTxt = IOUtils.toString(is);
			JSONObject json = new JSONObject(jsonTxt);
			token = json.getString("auth");
		}
		return token;
	}
}