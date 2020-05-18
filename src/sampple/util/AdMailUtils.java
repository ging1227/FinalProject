package sampple.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import sampple.model.Users;

public class AdMailUtils {

	private static final Logger logger = Logger.getLogger(AdMailUtils.class);

	private SessionFactory sessionFactory;

	public AdMailUtils(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public void executeMethod() throws MessagingException {
		// 取得所有用戶email
		ArrayList<String> userMails = (ArrayList<String>) getRecipients();

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
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sendName, sendPassword);
			}
		});
		// 控制檯輸出debug信息
		session.setDebug(true);

		// 創建一個Message，它相當於郵件內容
		// 相當於獲取信封
		for (String email : userMails) {
			try {
				Message message = new MimeMessage(session);
				// 設置發送人
				message.setFrom(new InternetAddress("w92532@gmail.com"));
				// 設置發送方式與接收者
				message.setRecipient(RecipientType.TO, new InternetAddress(email));
				// 郵件主題
				message.setSubject("台灣sampple網廣告信");
				// 郵件內容
				Multipart emailMsg = buildMsg();
				message.setContent(emailMsg, "text/html;charset=utf-8");

				// 創建 Transport用來發送郵件
				Transport.send(message);
			} catch (MessagingException e) {
				logger.error(e);
			}
		}

	}

	// 創建郵件內容
	public Multipart buildMsg() {
		// 讀取HTML
		File recipientsFile = new File("C:/GitHubDesktop/FinalProject/WebContent/Flash Sale.html");

		StringBuilder builder = new StringBuilder();
		try (InputStream in = new FileInputStream(recipientsFile);
				BufferedReader br = new BufferedReader(new InputStreamReader(in));) {
			String line = null;
			// 讀入
			while ((line = br.readLine()) != null) {
				builder.append(line);
			}
		} catch (IOException e) {
			logger.error(e);
		}

		// 讀取html code
		MimeBodyPart textPart = new MimeBodyPart();
		Multipart email = new MimeMultipart();
		try {
			textPart.setContent(builder.toString(), "text/html; charset=UTF-8");
			email.addBodyPart(textPart);
		} catch (MessagingException e) {
			logger.error(e);
		}

		return email;
	}

	// 獲取所有收件人方式
	public List<String> getRecipients() {
		ArrayList<String> result = new ArrayList<>();
		org.hibernate.Session session = sessionFactory.openSession();
		try {
			session.beginTransaction();

			Query<Users> query = session.createQuery("From Users", Users.class);
			List<Users> list = query.list();
			logger.info(list.get(0).getEmail());

			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getUinfo().getAdemail().equals("Y")) {
					result.add(list.get(i).getEmail());
				}
			}

			session.getTransaction().commit();
		} catch (Exception e) {
			logger.error(e);
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		return result;
	}

}
