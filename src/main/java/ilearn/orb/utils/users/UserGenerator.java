package ilearn.orb.utils.users;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
import ilearn.orb.entities.User;
import ilearnrw.utils.LanguageCode;

public class UserGenerator {
	public static User createUser(LanguageCode language, String name, int id){
		return new User(language, name, id);
	}
}
