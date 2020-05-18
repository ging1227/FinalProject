package sampple.util;

import static sampple.util.ConstProperty.EMAIL_REGEX;
import static sampple.util.ConstProperty.PWD_REGEX;

public class VerifyUtil {
	
	public boolean chkEmail(String userName) {
		boolean chk = false;
		
		if (userName.matches(EMAIL_REGEX)) {
			chk = true;
		}
		return chk;
	}
	
	public boolean chkLogin(String userName, String userPwd) {
		boolean chk = false;

		if (userName.matches(EMAIL_REGEX) && userPwd.matches(PWD_REGEX)) {
			chk = true;
		}

		return chk;
	}
}
