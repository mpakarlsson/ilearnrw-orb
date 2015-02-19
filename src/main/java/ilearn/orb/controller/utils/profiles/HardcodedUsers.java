package ilearn.orb.controller.utils.profiles;

import ilearn.orb.entities.User;
import ilearn.orb.utils.profiles.ProfileGenerator;
import ilearnrw.user.profile.UserProfile;
import ilearnrw.utils.LanguageCode;

public class HardcodedUsers {
	
	public static User[] defaultStudents() {
		User[] students = new User[4];
		students[0] = new User(LanguageCode.EN, "english_low", -50);
		students[1] = new User(LanguageCode.EN, "english_high", -40);
		students[2] = new User(LanguageCode.EN, "greek_low", -30);
		students[3] = new User(LanguageCode.EN, "greek_high", -20);
		return students;
	}
	
	public static UserProfile defaultProfile(int id){
		if (id == -20)
			return ProfileGenerator.createProfile(LanguageCode.GR, 3);
		else if (id == -30)
			return ProfileGenerator.createProfile(LanguageCode.GR, 1);
		if (id == -40)
			return ProfileGenerator.createProfile(LanguageCode.EN, 3);
		else
			return ProfileGenerator.createProfile(LanguageCode.EN, 1);
	}

}
