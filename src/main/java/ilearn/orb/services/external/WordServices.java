package ilearn.orb.services.external;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
import ilearn.orb.services.external.utils.Connection;

public class WordServices {
	
	public static String getWords(int id, String token) throws Exception{
		return Connection.sendGet("activity/new_data?count=10&evaluation_mode=0&probId=5_0" +
		"&difficultyLevel=0&activity=HARVEST&userId="+id+"&token=" + token);
	}
}
