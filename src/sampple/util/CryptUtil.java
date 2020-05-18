package sampple.util;

import java.math.BigInteger;
import java.security.MessageDigest;

public class CryptUtil {

	/**
	 * Encoding String
	 * 
	 * @param String
	 * @return String
	 */
	public String encoding(String str) {
		String result = null;
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			
			md.update(str.getBytes());
			
			result = new BigInteger(1, md.digest()).toString(16);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
