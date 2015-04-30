package ilearn.orb.controller.utils.profiles;

import ilearn.orb.entities.User;
import ilearn.orb.utils.profiles.ProfileGenerator;
import ilearnrw.user.profile.UserProfile;
import ilearnrw.utils.LanguageCode;

public class HardcodedUsers {
	
	public static User[] defaultStudents() {
		User[] students = new User[2];
		students[0] = new User(LanguageCode.EN, "english_profile", -10);
		students[1] = new User(LanguageCode.EN, "greek_profile", -20);
		return students;
	}
	
	/*public static UserProfile defaultProfile(int id){
		if (id == -20)
			return ProfileGenerator.createProfile(LanguageCode.GR, 3);
		else 
			return ProfileGenerator.createProfile(LanguageCode.EN, 3);
	}*/

	public static String defaultProfileLanguage(int id){
		if (id == -20)
			return "GR";
		else 
			return "EN";
	}

}
