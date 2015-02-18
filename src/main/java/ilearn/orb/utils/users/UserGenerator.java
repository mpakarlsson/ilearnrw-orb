package ilearn.orb.utils.users;

import ilearn.orb.entities.User;
import ilearnrw.utils.LanguageCode;

public class UserGenerator {
	public static User createUser(LanguageCode language, String name, int id){
		return new User(language, name, id);
	}
}
