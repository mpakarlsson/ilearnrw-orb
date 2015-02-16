/**
 * 
 */
package ilearn.orb.services.external;

import ilearn.orb.services.external.utils.Connection;


/**
 * @author chris
 * Nov 15, 2014
 *
 * iLearnTextAnalysis / application / Services.java
 */
public class UserServices {
	
	public static String getToken(String username, String password) throws Exception{
		return Connection.sendGet("user/auth?username=" + username
						+ "&pass=" + password);
	}

	public static String getJsonProfile(int id, String token) throws Exception{
		return Connection.sendGet("profile?userId="+id+"&token=" + token);
	}

	public static String getProfiles(int id, String token) throws Exception{
		return Connection.sendGet("application/"+id+"/profiles?token=" + token);
	}

	public static String getProfileUpdates(String username) throws Exception{
		return Connection.sendGet("logs/"+username+"?applicationId=PROFILE_UPDATER&tags=PROFILE_UPDATE");
	}

	public static String getDetails(String username) throws Exception{
		return Connection.sendGet("/user/details/"+username);
	}
}