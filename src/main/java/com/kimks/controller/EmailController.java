package com.kimks.controller;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kimks.domain.EmailDTO;
import com.kimks.domain.MemberVO;
import com.kimks.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/email/*")
@AllArgsConstructor
public class EmailController {

	private JavaMailSender mailSender;
	
	private BCryptPasswordEncoder crytPassEnc;
	
	private MemberService service;
	
	@ResponseBody
	@PostMapping("/send")
	public ResponseEntity<String> send(String u_id, String u_email) throws Exception{
		ResponseEntity<String> entity = null;
		MemberVO vo = service.findPW(u_id, u_email);
		String message = "";
		if(vo != null) {
			message = "success";
			String instantPW = makePW();
			vo.setU_pw(crytPassEnc.encode(instantPW));//암호화
			service.changePW(vo);
			String subject = "뮤직스쿨 임시비밀번호 발송";
			String body = String.format("임시비밀번호 : %s", instantPW);
			EmailDTO dto = new EmailDTO("뮤직스쿨", "kimks3971@gmail.com", vo.getU_email(), subject, body);
			sendMail(dto);
			
		}else {
			message = "fail";
		}
		
		entity = new ResponseEntity<String>(message, HttpStatus.OK);
		return entity;
	}

	private String makePW() {
		String pw = "";
		for(int i=0; i<6; i++) {
			pw += String.valueOf((int)(Math.random()*9)+1);
		}
		return pw;
	}
	
	private void sendMail(EmailDTO dto) {
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiverMail()));
			msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
			msg.setSubject(dto.getMessage(), "utf-8");
			msg.setText(dto.getMessage(), "utf-8");
			mailSender.send(msg);
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
