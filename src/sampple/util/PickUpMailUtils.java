package sampple.util;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;

import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import sampple.model.Orders;
import sampple.model.Users;

public class PickUpMailUtils {

	private static final Logger logger = Logger.getLogger(AdMailUtils.class);
	
	private SessionFactory sessionFactory;

	public PickUpMailUtils(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public void executeMethod(String[] args)
			throws AddressException, MessagingException, GeneralSecurityException, UnsupportedEncodingException {
		// 取得未取貨會員email
		ArrayList<String> userMails = getRecipients();
		
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
		for (String email : userMails) {
			try {
				Message message = new MimeMessage(session);

				// 設置發送人
				message.setFrom(new InternetAddress("w92532@gmail.com"));
				// 設置發送方式與接收者
				message.setRecipient(RecipientType.TO, new InternetAddress(email));
				// 郵件主題
				message.setSubject("台灣sampple網取貨通知信");
				// 郵件內容
				String emailMsg = buildMsg();
				message.setContent(emailMsg, "text/html;charset=utf-8");

				// 創建 Transport用來發送郵件
				Transport.send(message);

			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}
		}

	}

	// 創建郵件內容
	public String buildMsg() {
		return "<html><head><title>取貨通知信</title></head>" + "<body><p> 親愛的會員您好,</p>"
				+ "<p>您購買的商品已送達，可以取貨了!</p> </body></html>";
	}

	// 獲取所有未取貨會員方式
	public ArrayList<String> getRecipients() {
		ArrayList<String> mails=new ArrayList<String>();
		org.hibernate.Session session = sessionFactory.openSession();
		try {
		session.beginTransaction();
		Query<Orders> query = session.createQuery("From Orders where STATUS=:sta", Orders.class).setParameter("sta", 5);
		List<Orders> list = query.list();
		//取得所有會員編號
		ArrayList<Integer> array=new ArrayList<Integer>();
		for (int i = 0; i < list.size(); i++) {
			array.add(list.get(i).getuSysSn());
		}
		//取得所有會員EMAIL
		
		for(int i=0;i<array.size();i++) {
			Query<Users> query2 = sessionFactory.openSession().createQuery("From Users where SYS_SN=:sys", Users.class).setParameter("sys",array.get(i));
			mails.add(query2.getSingleResult().getEmail());
		}
		session.getTransaction().commit();
		
		} catch (Exception e) {
			logger.error(e);
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		return mails;

	}

}