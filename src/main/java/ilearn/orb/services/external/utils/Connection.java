package ilearn.orb.services.external.utils;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

public class Connection {
	private static String baseUrl = "https://ssl.ilearnrw.eu/ilearnrw/";
	private final static String USER_AGENT = "Mozilla/5.0";

	// HTTP GET request
	public static String sendGet(String link) throws Exception {
		String url = baseUrl+link;
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		// optional default is GET
		con.setRequestMethod("GET");
		con.setRequestProperty("Authorization",
				userNamePasswordBase64("api", "api"));
		// add request header
		con.setRequestProperty("User-Agent", USER_AGENT);

		BufferedReader in = new BufferedReader(new InputStreamReader(
				con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
		return response.toString();
	}

	// HTTP POST request
	public static String sendPost(String link, String urlParameters) throws Exception {
		String url = baseUrl+link;

		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// add reuqest header
		con.setRequestMethod("POST");
		con.setRequestProperty("Authorization",
				userNamePasswordBase64("api", "api"));

		con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

		// Send post request
		con.setDoOutput(true);
		OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), "UTF8");
		//wr.writeBytes(urlParameters);
		wr.write(urlParameters);
		wr.flush();
		wr.close();

		BufferedReader in = new BufferedReader(new InputStreamReader(
				con.getInputStream(), "UTF-8"));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		return response.toString();
	}

	public static String userNamePasswordBase64(String username, String password) {
		return "Basic " + base64Encode(username + ":" + password);
	}

	private final static char base64Array[] = { 'A', 'B', 'C', 'D', 'E', 'F',
			'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
			'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
			'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
			't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5',
			'6', '7', '8', '9', '+', '/' };

	private static String base64Encode(String string) {
		String encodedString = "";
		byte bytes[] = string.getBytes();
		int i = 0;
		int pad = 0;
		while (i < bytes.length) {
			byte b1 = bytes[i++];
			byte b2;
			byte b3;
			if (i >= bytes.length) {
				b2 = 0;
				b3 = 0;
				pad = 2;
			} else {
				b2 = bytes[i++];
				if (i >= bytes.length) {
					b3 = 0;
					pad = 1;
				} else
					b3 = bytes[i++];
			}
			byte c1 = (byte) (b1 >> 2);
			byte c2 = (byte) (((b1 & 0x3) << 4) | (b2 >> 4));
			byte c3 = (byte) (((b2 & 0xf) << 2) | (b3 >> 6));
			byte c4 = (byte) (b3 & 0x3f);
			encodedString += base64Array[c1];
			encodedString += base64Array[c2];
			switch (pad) {
			case 0:
				encodedString += base64Array[c3];
				encodedString += base64Array[c4];
				break;
			case 1:
				encodedString += base64Array[c3];
				encodedString += "=";
				break;
			case 2:
				encodedString += "==";
				break;
			}
		}
		return encodedString;
	}
}
