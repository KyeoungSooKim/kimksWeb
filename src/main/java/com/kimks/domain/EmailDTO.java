package com.kimks.domain;

public class EmailDTO {

	private	String senderName;
	private	String senderMail;
	private	String receiverMail;
	public String getReceiverMail() {
		return receiverMail;
	}

	public void setReceiverMail(String receiverMail) {
		this.receiverMail = receiverMail;
	}
	private	String subject;
	private	String message;
	
	public EmailDTO(String senderName, String senderMail, String receiverMail, String subject,
			String message) {
		super();
		this.senderName = senderName;
		this.senderMail = senderMail;
		this.receiverMail = receiverMail;
		this.subject = subject;
		this.message = message;
	}
	
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSenderMail() {
		return senderMail;
	}
	public void setSenderMail(String senderMail) {
		this.senderMail = senderMail;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
