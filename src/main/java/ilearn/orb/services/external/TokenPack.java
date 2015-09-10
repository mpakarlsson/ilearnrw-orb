package ilearn.orb.services.external;

public class TokenPack {
	private String auth, refresh;

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public String getRefresh() {
		return refresh;
	}

	public void setRefresh(String refresh) {
		this.refresh = refresh;
	}

	@Override
	public String toString() {
		return "TokenPack [auth=" + auth + ", refresh=" + refresh + "]";
	}
	
}
