package sampple.util;

import java.util.Properties;
import sampple.model.Users;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;


public class MailUtils {
	// type:註冊認證或密碼重置
	// url:連結到對應的controller
	// user:用戶的bean
	public static void sendMail(String type, Users user, String url) throws MessagingException {
		// 取得用戶email
		String userName = user.getEmail();
		// 使用者是進行註冊激活或忘記密碼操作
		String subject = type.equalsIgnoreCase("sign") ? "註冊認證" : "密碼重置";

		String host = "smtp.gmail.com";
		int port = 587; // Gmail的端口號
		final String sendName = "w92532@gmail.com";
		final String sendPassword = "Ww414200";// your password
		// 建立一個屬性物件
		Properties props = new Properties();

		props.put("mail.smtp.auth", "true");// SMTP服務使用者認證
		props.put("mail.smtp.starttls.enable", "true");// 根據郵件服務器是否需要ttl驗證添加
		// 設定mail Server
		props.put("mail.smtp.host", host);// 設定SMTP伺服器地址
		props.put("mail.smtp.port", port);// 設定SMTP埠號
		props.put("mail.debug", "true");

		// 創建程序到郵件服務器的第一次對話
		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sendName, sendPassword);
			}
		});
		// 控制檯輸出debug信息
		session.setDebug(true);

		// 創建一個Message，它相當於郵件內容
		// 相當於獲取信封
		try {
			Message message = new MimeMessage(session);

			// 設置發送人
			message.setFrom(new InternetAddress("w92532@gmail.com"));
			// 設置發送方式與接收者
			message.setRecipient(RecipientType.TO, new InternetAddress(userName));
			// 郵件主題
			message.setSubject("台灣sampple網" + subject + "信");
			// 郵件內容
			String emailMsg = buildMsg(subject, userName, url);
			message.setContent(emailMsg, "text/html;charset=utf-8");

			// 創建 Transport用來發送郵件
			Transport.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

	// 創建郵件內容
	public static String buildMsg(String subject, String userName, String url) {
		// 123@gmail.com > 123
		userName = userName.substring(0, userName.indexOf('@'));
		

		return "<html><head><title>" + subject + "</title></head>" + "<body><p> 親愛的 " + userName + " 您好,</p>"
				+ "<p>請點擊以下連結進行" + subject + "作業</p>" + url + "</body></html>";
	}
}
