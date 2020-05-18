package sampple.util;

public class ConstProperty {

	private ConstProperty() {
		throw new IllegalStateException("Utility class");
	}

	public static final String PARA_EMAIL = "userEmail";
	public static final String PARA_PW = "userPwd";
	
	public static final String EMAIL_REGEX = "^\\w{2,63}@[a-zA-Z0-9]{2,63}\\.[a-zA-Z]{2,63}(\\.[a-zA-Z]{2,63})?$";
	public static final String PWD_REGEX = "\\w{2,12}";
	

}