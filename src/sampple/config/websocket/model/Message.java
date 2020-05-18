package sampple.config.websocket.model;

public class Message {

	private String from; // message.from
	private String to; // message.to
	private String content; // message.content
	private String sysMsg;
	private String name;

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSysMsg() {
		return sysMsg;
	}

	public void setSysMsg(String sysMsg) {
		this.sysMsg = sysMsg;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
