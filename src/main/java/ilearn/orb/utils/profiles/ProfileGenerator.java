package ilearn.orb.utils.profiles;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
import java.util.ArrayList;

import com.google.gson.Gson;

import ilearn.orb.utils.files.LocalStorageTextFileHandler;
import ilearnrw.textclassification.Word;
import ilearnrw.user.UserPreferences;
import ilearnrw.user.problems.ProblemDefinitionIndex;
import ilearnrw.user.profile.UserProblems;
import ilearnrw.user.profile.UserProfile;
import ilearnrw.user.profile.UserSeverities;
import ilearnrw.utils.LanguageCode;

public class ProfileGenerator {
	public static UserProfile createProfile(LanguageCode language, int value) {
		UserProfile up = new UserProfile(language, createProblems(
				createDefinitionIndex(language), value),
				new UserPreferences(14));
		return up;
	}

	private static ProblemDefinitionIndex createDefinitionIndex(
			LanguageCode language) {
		ProblemDefinitionIndex res;
		if (language == LanguageCode.EN) {
			String json = LocalStorageTextFileHandler
					.loadAsString("/home/chris/git/ilearnrw-orb/src/main/webapp/resources/data/problem_definitions_en.json");
			res = (ProblemDefinitionIndex) new Gson().fromJson(json,
					ProblemDefinitionIndex.class);
		} else {
			String json = LocalStorageTextFileHandler
					.loadAsString("/home/chris/git/ilearnrw-orb/src/main/webapp/resources/data/problem_definitions_greece.json");
			res = (ProblemDefinitionIndex) new Gson().fromJson(json,
					ProblemDefinitionIndex.class);

		}
		return res;
	}

	private static UserSeverities createSeverities(ProblemDefinitionIndex pdi,
			int value) {
		UserSeverities us = new UserSeverities(pdi.getProblems().length);
		for (int i = 0; i < pdi.getProblems().length; i++) {
			us.constructRow(i, pdi.getProblems()[i].length);
		}
		for (int i = 0; i < us.getLength(); i++) {
			us.getSystemIndices()[i] = 0;
			us.getTeacherIndices()[i] = 0;
			int curValue = value;
			if (pdi.getProblemDefinition(i).getSeverityType().equals("binary"))
				curValue = value < 2 ? value : 1;
			for (int j = 0; j < us.getSeverities()[i].length; j++) {
				us.setSeverity(i, j, curValue);
			}
		}
		return us;
	}

	private static UserProblems createProblems(ProblemDefinitionIndex pdi,
			int value) {
		UserProblems up = new UserProblems(pdi);
		up.setTrickyWords(new ArrayList<Word>());
		up.setUserSeverities(createSeverities(pdi, value));
		return up;
	}
}
