package ilearn.orb.utils.presents;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
import java.util.ArrayList;

import com.google.gson.Gson;

public class Groups {
	private ArrayList<Group> groups;
	
	public Groups(ArrayList<Group> groups) {
		this.groups = groups;
	}
	
	public ArrayList<Group> getGroups() {
		return groups;
	}
	
	public void setGroups(ArrayList<Group> groups) {
		this.groups = groups;
	}
	
	public ArrayList<Group> getGroupedProblems() {
		return groups;
	}
	
	public String getItemsJson(int groupIdx, int subGroupIdx){
		String res = new Gson().toJson(groups.get(groupIdx).getSubgroups().get(subGroupIdx).getItems());
		return res;
	}
}
